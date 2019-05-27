#!/bin/bash
echo "#### Creating objects ####"
echo """
curl -X POST \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn1","subnet":{"prefix":"1.0.0.0","prefixLength":26}}' \
	localhost:3333/v1/virtualnetworks
"""
curl -X POST \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn1","subnet":{"prefix":"1.0.0.0","prefixLength":26}}' \
	localhost:3333/v1/virtualnetworks
echo """
curl -X POST \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn2","subnets":[{"prefix":"2.0.0.0","prefixLength":26}]}' \
	localhost:3333/v1/virtualnetworks
"""
curl -X POST \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn2","subnets":[{"prefix":"2.0.0.0","prefixLength":26}]}' \
	localhost:3333/v1/virtualnetworks
echo """
curl -X POST \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn3","subnets":[{"prefix":"3.0.0.0","prefixLength":26}]}' \
	localhost:3333/v2alpha1/virtualnetworks
"""
curl -X POST \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn3","subnets":[{"prefix":"3.0.0.0","prefixLength":26}]}' \
	localhost:3333/v2alpha1/virtualnetworks
echo """
curl -X POST \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn4","subnets":[{"prefix":"4.0.0.0","prefixLength":26},{"prefix":"5.0.0.0","prefixLength":26}]}' \
	localhost:3333/v2alpha1/virtualnetworks
"""
curl -X POST \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn4","subnets":[{"prefix":"4.0.0.0","prefixLength":26},{"prefix":"5.0.0.0","prefixLength":26}]}' \
	localhost:3333/v2alpha1/virtualnetworks
echo "#### Getting Objects #####"
echo """
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn1"}' \
	localhost:3333/v1/virtualnetworks
"""
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn1"}' \
	localhost:3333/v1/virtualnetworks
echo """
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn2"}' \
	localhost:3333/v1/virtualnetworks
"""
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn2"}' \
	localhost:3333/v1/virtualnetworks
echo """
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn3"}' \
	localhost:3333/v1/virtualnetworks
"""
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn3"}' \
	localhost:3333/v1/virtualnetworks
echo """
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn4"}' \
	localhost:3333/v1/virtualnetworks
"""
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn4"}' \
	localhost:3333/v1/virtualnetworks
echo """
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn1"}' \
	localhost:3333/v2alpha1/virtualnetworks
"""
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn1"}' \
	localhost:3333/v2alpha1/virtualnetworks
echo """
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn2"}' \
	localhost:3333/v2alpha1/virtualnetworks
"""
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn2"}' \
	localhost:3333/v2alpha1/virtualnetworks
echo """
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn3"}' \
	localhost:3333/v2alpha1/virtualnetworks
"""
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn3"}' \
	localhost:3333/v2alpha1/virtualnetworks
echo """
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn4"}' \
	localhost:3333/v2alpha1/virtualnetworks
"""
curl -X GET \
	-H 'Content-Type: application/json' \
	-d  '{"name":"vn4"}' \
	localhost:3333/v2alpha1/virtualnetworks
echo "#### Listing Objects ####"
echo """
curl -X GET \
	-H 'Content-Type: application/json' \
	localhost:3333/v1/virtualnetworks
"""
curl -X GET \
	-H 'Content-Type: application/json' \
	localhost:3333/v1/virtualnetworks
echo """
curl -X GET \
	-H 'Content-Type: application/json' \
	localhost:3333/v2alpha1/virtualnetworks
"""
curl -X GET \
	-H 'Content-Type: application/json' \
	localhost:3333/v2alpha1/virtualnetworks
