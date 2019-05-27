package main

import (
        "encoding/json"
        "log"
)
var vnDb = make(map[string]*VirtualNetwork)

type Converter interface{
	ConvertToInternal()
}

type VirtualNetwork struct {
	Name string `json:"name"`
	Subnets []*Subnet `json:"subnet,omitempty"`
	Id *int `json:"id,omitempty"`
}

func (vn *VirtualNetwork) Create(body []byte){
	log.Println(body)
	err := json.Unmarshal(body, &vn)
	if err != nil {
		panic(err)
	}
	if vn.Id == nil {
		id := 1
		vn.Id = &id
	}
}

func (vn *VirtualNetwork) Write(){
	vnDb[vn.Name] = vn
}

func (vn *VirtualNetwork) Read(body []byte) ([]byte, error) {
	err := json.Unmarshal(body, &vn)
	if err != nil {
		panic(err)
	}
	return json.Marshal(vnDb[vn.Name])
}

func (vn *VirtualNetwork) ConvertV1toInternal(v1vn *VirtualNetwork){
	log.Println(vn)
}

func (vn *VirtualNetwork) ConvertToInternal(){
}
