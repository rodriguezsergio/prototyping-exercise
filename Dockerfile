FROM golang:1.11.2-alpine

COPY ./citrusbyte /go/src/citrusbyte

WORKDIR /go/src/citrusbyte
RUN go install

EXPOSE 8080

USER nobody
CMD ["citrusbyte"]
