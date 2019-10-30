#!/bin/sh
data='{"name":'\""jenkins-ci-$1"\"', "code_source_url": "https://github.com/dldaisy/jenkins_test.git/tree/'"$1"'", "package_url": {"pipeline_url": "https://127.0.0.1:8081/pipeline.py.zip"}, 
"resource_references": [{"key": {"id": '\""$2"\"', "type":3}, "relationship":1}]}'
version=$(curl -H "Content-Type: application/json" -X POST -d "$data" http://34.70.82.171:8888/apis/v1beta1/pipeline_versions | jq -r ".id")

# create run
rundata='{"name":'\""$1-run"\"', "resource_references": [{"key": {"id": '\""$version"\"', "type":4}, "relationship":2}, {"key": {"id": "d5a136ac-f931-4d05-8c4c-97851a4ebd6b", "type":1}, "relationship": 1}]}'
echo "$rundata"
curl -H "Content-Type: application/json" -X POST -d "$rundata" http://34.70.82.171:8888/apis/v1beta1/runs
