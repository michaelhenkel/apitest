#!/bin/bash
clear
echo ""
echo "#### 1. Create v1 vn1 object with single subnet ####"
printf """
curl -X POST \\
	-H 'Content-Type: application/json' \\
	-d  '{"name":"vn1","subnet":{"prefix":"1.0.0.0","prefixLength":26}}' \\
	localhost:3333/v1/virtualnetworks

"""
read  -n 1 -p "Press key"
curl -s -X POST \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn1","subnet":{"prefix":"1.0.0.0","prefixLength":26}}' \
	localhost:3333/v1/virtualnetworks

clear
echo ""
echo "#### 1.1 Read v1 vn1 and filter for subnet ####"
echo """
curl -X GET \\
	-H 'Content-Type: application/json' \\
	-d '{"name":"vn1"}' \\
	localhost:3333/v1/virtualnetworks | jq .subnet

"""
read  -n 1 -p "Press key for result"
echo ""
curl -s -X GET \
        -H 'Content-Type: application/json' \
        -d '{"name":"vn1"}' \
        localhost:3333/v1/virtualnetworks | jq .subnet
echo ""
read  -n 1 -p "Press key"


clear
echo ""
echo "#### 1.2 Read v1 vn1 with v2alpha1 API and filter for subnets ####"
echo """
curl -X GET \\
        -H 'Content-Type: application/json' \\
        -d '{"name":"vn1"}' \\
        localhost:3333/v2alpha1/virtualnetworks | jq .subnets

"""
read  -n 1 -p "Press key for result"
echo ""
curl -s -X GET \
        -H 'Content-Type: application/json' \
        -d '{"name":"vn1"}' \
        localhost:3333/v2alpha1/virtualnetworks | jq .subnets
echo ""
read  -n 1 -p "Press key"


clear
echo ""
echo "#### 2. Create v1 vn1 object with multiple subnets ####"
printf """
curl -X POST \\
        -H 'Content-Type: application/json' \\
        -d  '{"name":"vn1","subnets": \\
	  [{"prefix":"1.0.0.0","prefixLength":26}, \\
           {"prefix":"1.1.0.0","prefixLength":26}]}' \\
        localhost:3333/v1/virtualnetworks

"""
read  -n 1 -p "Press key"
curl -s -X POST \
        -H 'Content-Type: application/json' \
        -d  '{"name":"vn2","subnets":
          [{"prefix":"2.0.0.0","prefixLength":26},
           {"prefix":"2.1.0.0","prefixLength":26}]}' \
        localhost:3333/v1/virtualnetworks

clear
echo ""
echo "#### 2.1 Read v1 vn2 and filter for subnet ####"
echo """
curl -X GET \\
        -H 'Content-Type: application/json' \\
        -d '{"name":"vn2"}' \\
        localhost:3333/v1/virtualnetworks | jq .subnet

"""
read  -n 1 -p "Press key for result"
echo ""
curl -s -X GET \
        -H 'Content-Type: application/json' \
        -d '{"name":"vn2"}' \
        localhost:3333/v1/virtualnetworks | jq .subnet
echo ""
read  -n 1 -p "Press key"


clear
echo ""
echo "#### 2.2 Read v1 vn2 with v2alpha1 API and filter for subnets ####"
echo """
curl -X GET \\
        -H 'Content-Type: application/json' \\
        -d '{"name":"vn2"}' \\
        localhost:3333/v2alpha1/virtualnetworks | jq .subnets

"""
read  -n 1 -p "Press key for result"
echo ""
curl -s -X GET \
        -H 'Content-Type: application/json' \
        -d '{"name":"vn2"}' \
        localhost:3333/v2alpha1/virtualnetworks | jq .subnets
echo ""
read  -n 1 -p "Press key"


clear
echo ""
echo "#### 3. Create v2alpha1 vn3 object with multiple subnets ####"
printf """
curl -X POST \\
        -H 'Content-Type: application/json' \\
        -d  '{"name":"vn3","subnets": \\
          [{"prefix":"3.0.0.0","prefixLength":26}, \\
           {"prefix":"3.1.0.0","prefixLength":26}]}' \\
        localhost:3333/v2alpha1/virtualnetworks

"""
read  -n 1 -p "Press key"
curl -s -X POST \
        -H 'Content-Type: application/json' \
        -d  '{"name":"vn3","subnets":
          [{"prefix":"3.0.0.0","prefixLength":26},
           {"prefix":"3.1.0.0","prefixLength":26}]}' \
        localhost:3333/v2alpha1/virtualnetworks

clear
echo ""
echo "#### 3.1 Read v2alpha1 vn3 and filter for subnets ####"
echo """
curl -X GET \\
        -H 'Content-Type: application/json' \\
        -d '{"name":"vn3"}' \\
        localhost:3333/v2alpha1/virtualnetworks | jq .subnets

"""
read  -n 1 -p "Press key for result"
echo ""
curl -s -X GET \
        -H 'Content-Type: application/json' \
        -d '{"name":"vn3"}' \
        localhost:3333/v2alpha1/virtualnetworks | jq .subnets
echo ""
read  -n 1 -p "Press key"


clear
echo ""
echo "#### 3.2 Read v2alpha1 vn3 with v1 API and filter for subnet ####"
echo """
curl -X GET \\
        -H 'Content-Type: application/json' \\
        -d '{"name":"vn3"}' \\
        localhost:3333/v1/virtualnetworks | jq .subnet

"""
read  -n 1 -p "Press key for result"
echo ""
curl -s -X GET \
        -H 'Content-Type: application/json' \
        -d '{"name":"vn3"}' \
        localhost:3333/v1/virtualnetworks | jq .subnet
echo ""
read  -n 1 -p "Press key"


clear
echo ""
echo "#### 4.1 list all subnets using v1 API ####"
echo """
curl -X GET \\
        -H 'Content-Type: application/json' \\
        localhost:3333/v1/virtualnetworks | jq .

"""
read  -n 1 -p "Press key for result"
echo ""
curl -s -X GET \
        -H 'Content-Type: application/json' \
        localhost:3333/v1/virtualnetworks | jq .
echo ""
read  -n 1 -p "Press key"


clear
echo ""
echo "#### 4.2 list all subnets using v2alpha1 API ####"
echo """
curl -X GET \\
        -H 'Content-Type: application/json' \\
        localhost:3333/v2alpha1/virtualnetworks | jq .

"""
read  -n 1 -p "Press key for result"
echo ""
curl -s -X GET \
        -H 'Content-Type: application/json' \
        localhost:3333/v2alpha1/virtualnetworks | jq .
echo ""
read  -n 1 -p "Press key"
