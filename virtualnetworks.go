package main

import (
        "encoding/json"
	"github.com/michaelhenkel/apitest/v1"
	"github.com/michaelhenkel/apitest/v2alpha1"
)

type Converter interface{
	ConvertToInternal()
}

type VirtualNetwork struct {
	Name string `json:"name"`
	Subnets []*Subnet `json:"subnets,omitempty"`
	Id *int `json:"id,omitempty"`
}

func (vn *VirtualNetwork) Create(body []byte, vnDb map[string]interface{}) interface{}{
	err := json.Unmarshal(body, &vn)
	if err != nil {
		panic(err)
	}
	return vn
}

func (vn *VirtualNetwork) Write(interface{}, map[string]interface{}){
}

func (vn *VirtualNetwork) List(map[string]interface{}) []interface{} {
	return nil
}

func (vn *VirtualNetwork) Read([]byte, map[string]interface{}) interface{} {
	return nil
}

func (vn *VirtualNetwork) ConvertToVersion(version string) interface{} {
	switch version{
	case "v1":
		var v1subnets []*v1.Subnet
		for _, sn := range(vn.Subnets){
			v1sn := v1.Subnet{
				Prefix: sn.Prefix,
				PrefixLength: sn.PrefixLength,
			}
			v1subnets = append(v1subnets, &v1sn)
		}
		vnv1 := &v1.VirtualNetwork{
			Name: vn.Name,
			Subnets: v1subnets,
			Subnet: v1subnets[0],
			Id: vn.Id,
		}
		return vnv1
	case "v2alpha1":
		var v2alpha1subnets []*v2alpha1.Subnet
		for _, sn := range(vn.Subnets){
			v2alpha1sn := v2alpha1.Subnet{
				Prefix: sn.Prefix,
				PrefixLength: sn.PrefixLength,
			}
			v2alpha1subnets = append(v2alpha1subnets, &v2alpha1sn)
		}
		vnv2alpha1 := &v2alpha1.VirtualNetwork{
			Name: vn.Name,
			Subnets: v2alpha1subnets,
			Id: vn.Id,
		}
		return vnv2alpha1
	}
	return nil
}

func (vn *VirtualNetwork) ConvertToInternal(vnObject interface{}){
	switch vnObject.(type){
	case *v1.VirtualNetwork:
		vnv1 := vnObject.(*v1.VirtualNetwork)
		var subnets []*Subnet
		if vnv1.Subnets == nil && vnv1.Subnet != nil {
			subnets = []*Subnet{{
				Prefix: vnv1.Subnet.Prefix,
				PrefixLength: vnv1.Subnet.PrefixLength,
			}}
		}
		if vnv1.Subnets != nil {
			for _, v1sn := range(vnv1.Subnets){
				sn := Subnet{
					Prefix: v1sn.Prefix,
					PrefixLength: v1sn.PrefixLength,
				}
				subnets = append(subnets, &sn)
			}
		}
		vn.Subnets = subnets
		vn.Name = vnv1.Name
		vn.Id = vnv1.Id
	case *v2alpha1.VirtualNetwork:
		vnv2alpha1 := vnObject.(*v2alpha1.VirtualNetwork)
		var subnets []*Subnet
		if vnv2alpha1.Subnets != nil {
			for _, v2alpha1sn := range(vnv2alpha1.Subnets){
				sn := Subnet{
					Prefix: v2alpha1sn.Prefix,
					PrefixLength: v2alpha1sn.PrefixLength,
				}
				subnets = append(subnets, &sn)
			}
		}
		vn.Subnets = subnets
		vn.Name = vnv2alpha1.Name
		vn.Id = vnv2alpha1.Id
	}
}
