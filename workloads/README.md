
```
[root@ip-172-16-32-189 core]# cat set.sh 

curl --request PUT --data @payload.json -H Host:consul-dev.mwlabs.net http://10.10.10.10:8500/v1/catalog/register

curl --request PUT --data @payload.json http://consul-dev.mwlabs.net:8500/v1/catalog/register

[root@ip-172-16-32-189 core]# cat payload.json 
{
  "Node": "t2.320",
  "Address": "192.168.10.10",
  "TaggedAddresses": {
    "lan": "192.168.10.10",
    "wan": "10.0.10.10"
  },
  "Service": {
    "ID": "redis1",
    "Service": "redis",
    "Tags": ["primary", "v1"],
    "Address": "127.0.0.1",
    "TaggedAddresses": {
      "lan": {
        "address": "127.0.0.1",
        "port": 8000
      },
      "wan": {
        "address": "198.18.0.1",
        "port": 80
      }
    },
    "Meta": {
      "redis_version": "4.0"
    },
    "Port": 8000
  }
}
```
