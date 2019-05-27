package main

import (
	//"encoding/json"
	"log"
	"net/http"
	"io/ioutil"
	"strings"
	"apitest/v1"
	"apitest/common"
)

const(
	stable = "v1"
)
var resourceVersionMap = make(map[string]map[string]common.Resource)
var resourceMap = make(map[string]common.Resource)
func createResourceVersionMap(){
	var vnv1 v1.VirtualNetwork
	var r common.Resource
	r = &vnv1
	resourceMap["virtualnetworks"] = r
	resourceVersionMap["v1"] = resourceMap

	var vn common.VirtualNetwork
	r = &vn
	resourceMap["virtualnetworks"] = r
	resourceVersionMap["internal"] = resourceMap
	log.Println(resourceVersionMap)
}

func postResource(body []byte, version string, resource string){
	resourceVersionMap[version][resource].Create(body)
	//resourceVersionMap[version][resource].ConvertToInternal()
	resourceVersionMap[version][resource].Write()
}

func convertV1toInternal(){
}

func convertInternaltoV1(){
}

func writeResource(){
}

func getResource(body []byte, version string, resource string) []byte {
	result, err := resourceVersionMap[version][resource].Read(body)
	if err != nil {
		panic(err)
	}
	return result
}

func pathHandler(rw http.ResponseWriter, req *http.Request) {
	path := req.URL.Path
	log.Println(path)
	uri := strings.Split(path,"/")
	version := uri[1]
	resource := uri[2]
	body, err := ioutil.ReadAll(req.Body)
	if err != nil {
		panic(err)
	}
	if req.Method == http.MethodGet{
		response := getResource(body, version, resource)
		rw.Write(response)
	} else if req.Method == http.MethodPost{
		postResource(body, version, resource)
	}
}
func main() {
	createResourceVersionMap()
	//createObjectVersionMap()
	http.HandleFunc("/", pathHandler)
	log.Fatal(http.ListenAndServe(":3333", nil))
}
