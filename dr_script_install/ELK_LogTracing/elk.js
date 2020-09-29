elk

Demo here: http://boris-42.github.io/ngk.html

===========================
fix here 
{"error":{"root_cause":[{"type":"circuit_breaking_exception","reason":"[parent] Data too large, data for [<http_request>] would be [3978481792/3.7gb], which is larger than the limit of [3944244838/3.6gb], real usage: [3978481792/3.7gb], new bytes reserved: [0/0b]","bytes_wanted":3978481792,"bytes_limit":3944244838,"durability":"PERMANENT"}],"type":"circuit_breaking_exception","reason":"[parent] Data too large, data for [<http_request>] would be [3978481792/3.7gb], which is larger than the limit of [3944244838/3.6gb], real usage: [3978481792/3.7gb], new bytes reserved: [0/0b]","bytes_wanted":3978481792,"bytes_limit":3944244838,"durability":"PERMANENT"},"status":429}


curl -X PUT "localhost:9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d'
{
    "persistent" : {
        "indices.recovery.max_bytes_per_sec" : "50mb"
    }
}
'
curl -X PUT "localhost:9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d'
{
     "persistent" : {
         "indices.breaker.request.limit" : "81%"
  }
}
'

==> fix vim /usr/lib/systemd/system/elasticsearch.service
==> fix /usr/share/elasticsearch/jdk/bin/java -Xms12g -Xmx12g -XX:+Us
vi /etc/elasticsearch/jvm.options

-Xms12g
-Xmx12g



=====================

curl -XPOST 'http://jfblouvmlxecs01:9200/test/test/1' -d lane.json

curl -H "Content-Type: application/json" -XPOST 'localhost:9200/trace/trace1/_bulk?pretty&refresh' --data-binary "@trace1.json"


_bulk
_msearch
get _mapping


curl -H "Content-Type: application/json" -XGET 'http://localhost:9200/google/employee/_search?q' -d '
{
    "query" : {
        "filter" : {
            "range" : {
                "age" : { "gt" : 19 }
             }
        }
        
    }
}
'




curl -H "Content-Type: application/json" -XGET 'http://localhost:9200/google/employee/_search?q' -d '
{
    "query" : {
        "filtered" : {
            "filter" : {
                "range" : {
                    "age" : { "gt" : 19 }
                 }
            },
            "query" : {
                "match" : {
                "last_name" : "smith"
                }
            }
        }
    }
}
'



{"index":{"_id":"1"}}
{"first_name" : "John","last_name" : "Smith","age" : 25,"about" : "I love to go rock climbing","interests": [ "sports", "music" ]}
{"index":{"_id":"2"}}
{"first_name" : "Jane","last_name" : "Laura","age" : 30,"about" : "I love to go swimming","interests": [ "music" ]}
{"index":{"_id":"3"}}
{"first_name" : "Messi","last_name" : "Leonel","age" : 40,"about" : "I love to go playing soccer","interests": [ "forestry" ]}


/google/employee/_search?q=last_name:Smith AND age:20





curl -X GET "localhost:9200/jaeger-span-2019-11-04/_search?pretty" -H 'Content-Type: application/json' -d '
            { 
            "query" : {
                "match" : {
                "traceID" : ""
                }
            } }'



--------------------------------------- jaeger save database:
    _index: "jaeger-span-2019-11-04"
    _type: "_doc"
    _id: "zxsfsdfsfdsfds"
    _score: 1
    _source: 
        traceID: "66666"
        spanID: "777777"
        flags: 1
        operationName: "wsgi"
        references:
            0:
                refType: "CHILD_OF"
                traceID: "6624234234434"
                spanID: "66634534"
        startTime: 157283
        startTimeMillis: 157283
        duration: 934141
        tags: []
        tag:
            http@method: "GET"
            http@path: "/v3/auth/tokens"
            http@query: ""
            http@scheme: "http"
            internal@span@format: "proto"
        logs: []
        process: 
            serviceName: "keystone-public"
            tags: []
            tag:
                hostname: "controller02"
                ip: "172.16.29.146"



openstack image list --os-profile foo 
curl -X GET "http://localhost:9200/osprofiler_notifications/_search?pretty" -H "Content-Type: application/json" -d '{"query":{"match":{"project":"glance"}}}'







Tác động hiệu suất:
     - Nếu bị tắt thì không có tác động đáng kể, chỉ bằng vài hàm "if None" check.
     - Nếu được bật:
        + Không có trace header: ko có tác động hiệu suất
        + Có trace header:
            Trace id được ký với wrong HMAC overhead trên checking mà trace id được ký bởi khóa HMAC thích hợp
            Hiệu suất tiếp theo sẽ bị ảnh hưởng bởi số lượng điểm theo dõi và hiệu suất API thông báo. (đối với yêu caafu như khởi động vM sẽ chậm đi đáng kể, nhưng những yêu cầu như hiển thị chi tiết về tài nguyên thì sẽ không đáng kể)
        + Theo dõi 


============================================================================================================================================
============================================================================================================================================
============================================================================================================================================
============================================================================================================================================
============================================================================================================================================
============================================================================================================================================
============================================================================================================================================


ElasticsearchDriver:

from datetime import datetime
from elasticsearch import Elasticsearch
es = Elasticsearch("")

doc = {
    'author': 'kimchy',
    'text': 'Elasticsearch: cool. bonsai cool.',
    'timestamp': datetime.now(),
}
res = es.index(index="test-index", doc_type='tweet', id=1, body=doc)
print(res['result'])

res = es.get(index="test-index", doc_type='tweet', id=1)
print(res['_source'])

es.indices.refresh(index="test-index")

res = es.search(index="test-index", body={"query": {"match_all": {}}})
print("Got %d Hits:" % res['hits']['total']['value'])
for hit in res['hits']['hits']:
    print("%(timestamp)s %(author)s: %(text)s" % hit["_source"])
