import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:KubernetesMobile/DockerLaunch.dart';
import 'dart:core';

var x_list;
var imp;
bool isdone = false;

Widget Widget_for_resource_info(var data_json) {
  if (imp == "pods") {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Name : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['metadata']['name'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Kind : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['kind'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Ready : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['status']['containerStatuses'][0]['ready']
                          ? "YES"
                          : "NO",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Started: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['status']['containerStatuses'][0]['started']
                          ? "YES"
                          : " NO",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Node: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['spec']['nodeName'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Pod IP: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['status']['podIP'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Host IP: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['status']['hostIP'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Labels: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['metadata']['labels'].toString(),
                      style: TextStyle(color: Colors.black),
                      maxLines: 2,
                      softWrap: true,
                    ),
                  )
                ],
              ),
              // Container(child: FlatButton(onPressed: Logs(), child: Text("LOGS")),),
            ],
          )
        ],
      ),
    );
  }

  if (imp == "deployments" || imp == "rc" || imp == "rs") {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Name : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['metadata']['name'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Kind : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['kind'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Image : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["spec"]['template']["spec"]["containers"][0]
                              ["image"]
                          .toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Namespace: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["metadata"]["namespace"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Labels: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['metadata']['labels'].toString(),
                      style: TextStyle(color: Colors.black),
                      maxLines: 2,
                      softWrap: true,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Replicas ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Available: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["status"]["availableReplicas"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Desired: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['status']['replicas'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Ready: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["status"]["readyReplicas"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  if (imp == "namespace") {
    var stamp = DateTime.parse(data_json["metadata"]['creationTimestamp']);
    var age = DateTime.now().difference(stamp);
    print(age.inDays);
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Name : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['metadata']['name'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Kind : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['kind'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Status : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["status"]["phase"],
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Age : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      "${age.inDays}d",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
  if (imp == "nodes") {
    var stamp = DateTime.parse(data_json["metadata"]['creationTimestamp']);
    var age = DateTime.now().difference(stamp);
    print(age.inDays);
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Name : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['metadata']['name'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Kind : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['kind'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Age : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      "${age.inDays}d",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Version : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["status"]["nodeInfo"]["kubeletVersion"],
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Kernel Version : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["status"]["nodeInfo"]["kernelVersion"],
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "OS-Image : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["status"]["nodeInfo"]["osImage"],
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Container Version : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["status"]["nodeInfo"]
                          ["containerRuntimeVersion"],
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Internal IP : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["status"]["addresses"][0]["address"],
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
  if (imp == "services") {
    var stamp = DateTime.parse(data_json["metadata"]['creationTimestamp']);
    var age = DateTime.now().difference(stamp);
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Name : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['metadata']['name'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Kind : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['kind'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Age : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      "${age.inDays}d",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Namespace: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["metadata"]["namespace"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Type: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['spec']['type'].toString(),
                      style: TextStyle(color: Colors.black),
                      maxLines: 2,
                      softWrap: true,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Cluster IP: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['spec']['clusterIP'].toString(),
                      style: TextStyle(color: Colors.black),
                      maxLines: 2,
                      softWrap: true,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Port: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['spec']['ports'][0]['port'].toString(),
                      style: TextStyle(color: Colors.black),
                      maxLines: 2,
                      softWrap: true,
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Protocol: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['spec']['ports'][0]['protocol'].toString(),
                      style: TextStyle(color: Colors.black),
                      maxLines: 2,
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  if (imp == "pv") {
    var stamp = DateTime.parse(data_json["metadata"]['creationTimestamp']);
    var age = DateTime.now().difference(stamp);
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Name : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['metadata']['name'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Kind : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['kind'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Age : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      "${age.inDays}d",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Labels: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["metadata"]["labels"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Access Modes: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["spec"]["accessModes"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Capacity: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["spec"]["capacity"]["storage"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Reclaim Policy: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["spec"]["persistentVolumeReclaimPolicy"]
                          .toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Status: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['status']["phase"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Volume Mode: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["spec"]["volumeMode"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Claim details: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 25),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Name: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["spec"]["claimRef"]['name'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 25),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "kind: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["spec"]["claimRef"]['kind'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 25),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "namespace: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["spec"]["claimRef"]['namespace'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  if (imp == 'pvc') {
    var stamp = DateTime.parse(data_json["metadata"]['creationTimestamp']);
    var age = DateTime.now().difference(stamp);
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Name : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['metadata']['name'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Kind : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['kind'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Age : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      "${age.inDays}d",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Namespace: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["metadata"]["namespace"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Access Modes: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["spec"]["accessModes"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Capacity: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["status"]["capacity"]["storage"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Status: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['status']["phase"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Volume Mode: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["spec"]["volumeMode"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Volume Name: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["spec"]["volumeName"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Storage Class: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["spec"]["storageClassName"].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
  if (imp == "secret") {
    var stamp = DateTime.parse(data_json["metadata"]['creationTimestamp']);
    var age = DateTime.now().difference(stamp);
    print(age.inDays);
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Name : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['metadata']['name'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Kind : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json['kind'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Namespace : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      data_json["metadata"]["namespace"],
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Age : ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15, left: 10),
                    child: Text(
                      "${age.inDays}d",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      "Type: ",
                      style: TextStyle(
                          color: Colors.lightBlue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0, bottom: 15),
                    child: Text(
                      data_json['type'],
                      textScaleFactor: 0.9,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

Pod_details(variable) async {
  String temporary;
  temporary = await serverCredentials.client
      .execute("kubectl get $imp $variable -o json");
  var json = jsonDecode(temporary);
  return json;
}

Widget body_pod_info() {
  return Container(
    margin: EdgeInsets.only(top: 25, left: 25),
    child: ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(x_list[index]),
          onTap: () async {
            var info_json = await Pod_details(x_list[index]);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: 90,
                          top: -70,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              maxRadius: 20,
                              child: IconButton(
                                  alignment: Alignment.center,
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  onPressed: Navigator.of(context).pop),
                            ),
                          ),
                        ),
                        Widget_for_resource_info(info_json),
                      ],
                    ),
                  );
                });
          },
        );
      },
      itemCount: x_list.length,
    ),
  );
}

Widget appbar_pod_info() {
  return AppBar(
    title: Text("$imp info"),
  );
}

class Pod_Info extends StatefulWidget {
  var s;
  Pod_Info({this.s});
  @override
  _Pod_InfoState createState() => _Pod_InfoState();
}

class _Pod_InfoState extends State<Pod_Info> {
  Pod_list() async {
    String temporary;
    List raw_list = [];

    temporary =
        await serverCredentials.client.execute("kubectl get $imp -o json");

    var json = jsonDecode(temporary);
    for (var item in json['items']) {
      raw_list.add(item['metadata']['name']);
    }
    x_list = raw_list;
    setState(() {
      isdone = true;
    });
  }

  @override
  void initState() {
    imp = this.widget.s;
    super.initState();
    Pod_list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appbar
        //
        appBar: appbar_pod_info(),
        //body
        //
        body: isdone
            ? body_pod_info()
            : Center(
                child: CircularProgressIndicator(),
              )
        //
        );
  }
}
