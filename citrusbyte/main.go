package main

import (
	"net/http"
	"encoding/json"
)

func main() {
	http.HandleFunc("/", rootHandler)
	http.ListenAndServe(":8080", nil)
}

func rootHandler(w http.ResponseWriter, r *http.Request) {
	responseMap := map[string]string{"Hello":"World!", "Citrus": "Byte"}
	j, _ := json.Marshal(responseMap)
	w.Header().Set("Content-Type", "application/json")
	w.Write(j)
}
