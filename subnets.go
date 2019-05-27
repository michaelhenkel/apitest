package main

import (
        //"encoding/json"
        //"log"
)

type Subnet struct {
        Prefix string `json:"prefix"`
        PrefixLength int32 `json:"prefixLength"`
}
