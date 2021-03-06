provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "citrusbyte-app" {
  name = "citrusbyte/app"
}

resource "aws_ecs_cluster" "citrusbyte-cluster" {
  name = "citrusbyte-cluster"
}

resource "aws_ecs_task_definition" "citrusbyte-app" {
  family                = "citrusbyte-app"
  container_definitions = "${data.template_file.image_path.rendered}"
  network_mode          = "awsvpc"
  execution_role_arn = "${data.aws_iam_role.ecs_task_execution.arn}"
}

resource "aws_ecs_service" "citrusbyte-app" {
  name            = "citrusbyte-app"
  cluster         = "${aws_ecs_cluster.citrusbyte-cluster.id}"
  task_definition = "${aws_ecs_task_definition.citrusbyte-app.arn}"
  desired_count   = 2

  network_configuration {
    subnets         = [ 
                        "${data.aws_subnet.us-east-1a.id}",
                        "${data.aws_subnet.us-east-1b.id}",
                        "${data.aws_subnet.us-east-1d.id}"
                      ]
    security_groups = ["${data.aws_security_group.alb_to_backend.id}"]
  }

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = "${data.aws_lb_target_group.app-8080.arn}"
    container_name   = "citrusbyte-app"
    container_port   = 8080
  }
}
