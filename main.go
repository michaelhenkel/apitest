package main

import (
	"log"
	"net/http"
	"io/ioutil"
	"strings"
	"encoding/json"
	"github.com/michaelhenkel/apitest/v1"
	"github.com/michaelhenkel/apitest/v2alpha1"
)

const(
	stable = "v1"
)
type Resource interface{
        Create([]byte, map[string]interface{}) interface{}
        Read([]byte, map[string]interface{}) interface{}
        List(map[string]interface{}) []interface{}
        ConvertToInternal(interface{})
        ConvertToVersion(string) interface{}
        Write(interface{}, map[string]interface{})
}
var resourceVersionMap = make(map[string]map[string]Resource)
var resourceMap = make(map[string]Resource)
func createResourceVersionMap(){
	var r Resource

	var vn VirtualNetwork
	r = &vn
	resourceVersionMap["internal"] = map[string]Resource{}
	resourceVersionMap["internal"]["virtualnetworks"] = r

	var vnv1 v1.VirtualNetwork
	r = &vnv1
	resourceVersionMap["v1"] = map[string]Resource{}
	resourceVersionMap["v1"]["virtualnetworks"] = r

	var vnv2alpha1 v2alpha1.VirtualNetwork
	r = &vnv2alpha1
	resourceVersionMap["v2alpha1"] = map[string]Resource{}
	resourceVersionMap["v2alpha1"]["virtualnetworks"] = r

}

var vnDb = make(map[string]interface{})
func postResource(body []byte, version string, resource string){
	r := resourceVersionMap[version][resource]
	object := r.Create(body, vnDb)

	rInternal := resourceVersionMap["internal"][resource]
	rInternal.ConvertToInternal(object)
	objectStable := rInternal.ConvertToVersion(stable)

	rStable := resourceVersionMap[stable][resource]
	rStable.Write(objectStable, vnDb)
}

func getResource(body []byte, version string, resource string) []byte {
	rStable := resourceVersionMap[stable][resource]
	objectStable := rStable.Read(body, vnDb)

        rInternal := resourceVersionMap["internal"][resource]
        rInternal.ConvertToInternal(objectStable)
        objectVersion := rInternal.ConvertToVersion(version)

	result, err := json.Marshal(objectVersion)
	if err != nil {
		panic(err)
	}
	return result
}

func listResources(version string, resource string) []byte {
	rStable := resourceVersionMap[stable][resource]
	objectStableList := rStable.List(vnDb)
	var resultList []interface{}
	for _, objectStable := range(objectStableList){
		rInternal := resourceVersionMap["internal"][resource]
		rInternal.ConvertToInternal(objectStable)
		objectVersion := rInternal.ConvertToVersion(version)
		resultList = append(resultList, objectVersion)
	}
	result, err := json.Marshal(resultList)
	if err != nil {
		panic(err)
	}
	return result
}

func pathHandler(rw http.ResponseWriter, req *http.Request) {
	createResourceVersionMap()
	path := req.URL.Path
	log.Println(req.Method, path)
	uri := strings.Split(path,"/")
	version := uri[1]
	resource := uri[2]
	body, err := ioutil.ReadAll(req.Body)
	if err != nil {
		panic(err)
	}
	if req.Method == http.MethodGet{
		if len(body) == 0 {
			response := listResources(version, resource)
			rw.Write(response)
		} else {
			response := getResource(body, version, resource)
			rw.Write(response)
		}
	} else if req.Method == http.MethodPost{
		postResource(body, version, resource)
	}
}
func main() {
	http.HandleFunc("/", pathHandler)
	log.Fatal(http.ListenAndServe(":3333", nil))
}
