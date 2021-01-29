import 'dart:convert';
import 'package:KubernetesMobile/Resources/Deployment.dart';
import 'package:KubernetesMobile/Resources/NameSpaces.dart';
import 'package:KubernetesMobile/Resources/PV-PVC.dart';
import 'package:KubernetesMobile/Resources/RC.dart';
import 'package:KubernetesMobile/Resources/RS.dart';
import 'package:KubernetesMobile/Resources/SvcSelector.dart';
import 'package:KubernetesMobile/ui/Secrets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:KubernetesMobile/DockerLaunch.dart';
import 'dart:core';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'LaunchPods.dart';

List x_list = [];
List<Map> x_list2;
var text = false;
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

delete(temp) async {
  String temporary;
  temporary =
      await serverCredentials.client.execute("kubectl delete $imp $temp");
  print(temporary);
  AppToast(temporary);
}

Pod_details(variable) async {
  String temporary;
  temporary = await serverCredentials.client
      .execute("kubectl get $imp $variable -o json");
  var json = jsonDecode(temporary);
  return json;
}

Body_Name_Widget() {
  if (imp == "pods")
    return Text(
      "Pods",
      style: TextStyle(
        fontSize: 40,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

  if (imp == "nodes")
    return Text(
      "Nodes",
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );

  if (imp == "rs")
    return Text(
      "Replica Sets",
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

  if (imp == "rc")
    return Text(
      "Replication Controller",
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );

  if (imp == "pv")
    return Text(
      "Persistent Volumes",
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

  if (imp == "pvc")
    return Text(
      "Persistent Volume Claims",
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

  if (imp == "services")
    return Text(
      "Services",
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

  if (imp == "namespace")
    return Text(
      "Namespaces",
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

  if (imp == "secret")
    return Text(
      "Secrets",
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  if (imp == "deployments")
    return Text(
      "Deployments",
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  else
    return Container();
}

Widget body_pod_info() {
  return Stack(
    overflow: Overflow.visible,
    children: [
      isdone
          ? Container(
              height: double.infinity,
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.only(top: 250),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      actionPane: SlidableScrollActionPane(),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        elevation: 8.0,
                        color: Colors.grey.shade100,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 4.0),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      width: 1.0, color: Colors.white24),
                                ),
                              ),
                              child: Icon(Icons.autorenew, color: Colors.black),
                            ),
                            title: Text(
                              x_list[index],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                Icon(Icons.linear_scale,
                                    color: Colors.blueAccent),
                                imp != "namespace" && imp != "secret"
                                    ? Text(
                                        x_list2[index].values.toString(),
                                        style: TextStyle(color: Colors.black),
                                      )
                                    : Text(
                                        "",
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ],
                            ),
                            onLongPress: () async {
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
                                                backgroundColor:
                                                    Colors.redAccent,
                                                maxRadius: 20,
                                                child: IconButton(
                                                    alignment: Alignment.center,
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed:
                                                        Navigator.of(context)
                                                            .pop),
                                              ),
                                            ),
                                          ),
                                          Widget_for_resource_info(info_json),
                                        ],
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                      ),
                      secondaryActions: [
                        IconSlideAction(
                          icon: Icons.delete,
                          color: Colors.red,
                          onTap: () {
                            delete(x_list[index]);
                          },
                        )
                      ],
                      actions: [
                        IconSlideAction(
                          icon: Icons.description,
                          color: Colors.blueAccent,
                          onTap: () async {
                            var temporary;
                            temporary = await serverCredentials.client.execute(
                                "kubectl describe $imp ${x_list[index]}");

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Scaffold(
                                    body: Center(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 25),
                                        alignment: Alignment.topLeft,
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 15),
                                                child: RaisedButton(
                                                  disabledElevation: 0,
                                                  elevation: 0,
                                                  color: Colors.white,
                                                  disabledColor: Colors.white,
                                                  hoverColor: Colors.white,
                                                  highlightColor: Colors.white,
                                                  child: Center(
                                                    child: Text(
                                                      temporary,
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      ],
                    );
                  },
                  itemCount: x_list.length,
                ),
              ),
            )
          : Container(
              color: Colors.white,
              height: double.infinity,
            ),
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            color: Colors.blueAccent.shade700),
        height: 220,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              //margin: EdgeInsets.only(top: 66, left: 20),
              child: Image.asset(
                'images/kube1.png',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Body_Name_Widget(),
            )
          ],
        ),
      ),
    ],
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
    List<Map> raw_list2 = [];

    if (Commands.validation == "passed") {
      temporary =
          await serverCredentials.client.execute("kubectl get $imp -o json");

      var json = jsonDecode(temporary);
      print("REACHED HERE\nTEMp = $temporary");
      int count = 0;

      try {
        for (var item in json['items']) {
          raw_list.add(item['metadata']['name']);
          raw_list2.add(item['metadata']['labels']);
        }

        print("Done even till here");
        x_list = raw_list;
        Commands.res = x_list;
        x_list2 = raw_list2;

        setState(() {
          text = true;
        });
      } catch (e) {
        for (var item in json['items']) {
          raw_list.add(item['metadata']['name']);
        }

        print("Done even till here");
        x_list = raw_list;
        Commands.res = x_list;
        setState(() {
          text = false;
        });
      }

      setState(() {
        print("ALL DONE HERE");
        isdone = true;
      });
    } else
      AppToast("Server not connected");
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
        //
        //   appbar
        //
        appBar: AppBar(
          //title: Text("Resources"),
          elevation: 0,
          backgroundColor: Colors.blueAccent[700],
          actions: [
            IconButton(
                icon: Icon(Icons.refresh_outlined),
                onPressed: () {
                  setState(() {
                    Pod_list();
                  });
                }),
            IconButton(
                icon: Icon(Icons.add_box),
                onPressed: () {
                  if (imp == "pods")
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PodLaunch();
                    }));
                  if (imp == "deployments")
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Deployment();
                    }));
                  if (imp == "rs")
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ReplicaSet();
                    }));
                  if (imp == "rc")
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ReplicationController();
                    }));
                  if (imp == "services")
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ServiceSelector();
                    }));
                  if (imp == "namespace")
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Namespace();
                    }));
                  if (imp == "secrets")
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Secrets();
                    }));
                  if (imp == "pv" || imp == "pvc")
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Storage();
                    }));
                })
          ],
        ),

        //
        //   body
        //
        body: body_pod_info());
  }
}

/*ListTile(
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
        */

/*
                    showDialog(
                      context: context,
                      child: Container(
                        height: 400,
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Card(
                            color: Colors.black,
                            child: Text(
                              temporary,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        color: Colors.red,
                      ),
                    );
                    */
