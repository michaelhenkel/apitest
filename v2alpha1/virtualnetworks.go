package v2alpha1

import (
        "encoding/json"
        //"log"
)
var vnDb = make(map[string]VirtualNetwork)

type VirtualNetwork struct {
        Name string `json:"name"`
	Subnets []*Subnet `json:"subnets,omitempty"`
	Id *int `json:"id,omitempty"`
}

func (vn *VirtualNetwork) Create(body []byte) interface{} {
        err := json.Unmarshal(body, &vn)
        if err != nil {
                panic(err)
        }
	if vn.Id == nil {
		id := len(vnDb)
		vn.Id = &id
	}
	return vn
}

func (vn *VirtualNetwork) Write(object interface{}){
	vn = object.(*VirtualNetwork)
	vnDb[vn.Name] = *vn
}

func (vn *VirtualNetwork) Read(body []byte) interface{}{
	err := json.Unmarshal(body, &vn)
	if err != nil {
		panic(err)
	}
	vnObject := vnDb[vn.Name]
        return &vnObject
}

func (vn *VirtualNetwork) List() []interface{} {
        var objectList []interface{}
        for _, object := range(vnDb){
                vnObject := vnDb[object.Name]
                objectList = append(objectList, &vnObject)
        }
        return objectList
}

func (vn *VirtualNetwork) ConvertToInternal(vnObject interface{}) {
}

func (vn *VirtualNetwork) ConvertToVersion(stable string) interface{} {
	return nil
}
