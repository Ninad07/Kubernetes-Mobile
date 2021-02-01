import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../../DockerLaunch.dart';

class ClusterIP extends StatefulWidget {
  @override
  _ClusterIPState createState() => _ClusterIPState();
}

class _ClusterIPState extends State<ClusterIP> {
  var isdone = false;
  //CREATE CLUSTERIP SERVICE FUNCTION
  createClusterIP() async {
    setState(() {
      isdone = true;
    });
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();

      if (Commands.name != null &&
          Commands.port != null &&
          Commands.targetPort != null) {
        if (Commands.ip != null) {
          if (Commands.contName != null) {
            Commands.result = await serverCredentials.client.execute(
                "kubectl create service clusterip ${Commands.name} --tcp=${Commands.port}:${Commands.targetPort} --clusterip=${Commands.ip} --dry-run=${Commands.contName}");
          } else {
            Commands.result = await serverCredentials.client.execute(
                "kubectl create service clusterip ${Commands.name} --tcp=${Commands.port}:${Commands.targetPort} --clusterip=${Commands.ip} ");
          }
        } else {
          if (Commands.contName != null) {
            Commands.result = await serverCredentials.client.execute(
                "kubectl create service clusterip ${Commands.name} --tcp=${Commands.port}:${Commands.targetPort} --dry-run=${Commands.contName} ");
          } else {
            Commands.result = await serverCredentials.client.execute(
                "kubectl create service clusterip ${Commands.name} --tcp=${Commands.port}:${Commands.targetPort} ");
          }
        }
      } else {
        AppToast("Cannot create the Service");
      }

      if (Commands.result != "") {
        AppToast("Service Created successfully");
        Commands.port = Commands.name =
            Commands.targetPort = Commands.ip = Commands.contName = null;
      } else
        AppToast("Cannot create the service");
    } else {
      AppToast("Server not connected");
    }
    setState(() {
      isdone = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Commands.name = null;
    Commands.port = null;
    Commands.targetPort = null;
    Commands.ip = null;
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Colors.blueAccent.shade700);
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    var isDisabled = false; //don't refer the meaning
    var isEnabled = false;
    var body = Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.blueAccent.shade700),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height - 200,
                bottom: 5,
                left: 0,
                right: 35),
            alignment: Alignment.center,
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'images/kubernetes.png',
              height: 190,
              width: 290,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Cluster IP",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent.shade400,
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.only(top: 50, bottom: 20),
                    child: Center(
                      child: Text(
                        "Create ClusterIP",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 350,
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 15,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 85,
                              child: Text(
                                "Name  : ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 230,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "name",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                onChanged: (value) {
                                  Commands.name = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 350,
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 15,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 85,
                              child: Text(
                                "Port  : ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 230,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    enabled: isEnabled ? false : true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "port",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                onChanged: (value) {
                                  Commands.port = value;
                                  setState(() {
                                    isDisabled = true;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 350,
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 15,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 105,
                              child: Text(
                                "Target Port  : ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 230,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 0, right: 0),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    enabled: isEnabled ? false : true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "target port",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                onChanged: (value) {
                                  Commands.targetPort = value;
                                  setState(() {
                                    isDisabled = true;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 350,
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 15,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 85,
                              child: Text(
                                "Cluster IP  : ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 230,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    enabled: isDisabled ? false : true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "IP",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                onChanged: (value) {
                                  Commands.ip = value;
                                  setState(() {
                                    isEnabled = true;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 350,
                        margin: EdgeInsets.only(
                          top: 25,
                          left: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 85,
                              child: Text("Dry run  : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 45,
                              width: 230,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 15, right: 10),
                              child: DropdownSearch(
                                popupBackgroundColor: Colors.white,
                                mode: Mode.MENU,
                                showSelectedItem: true,
                                items: ["Server", "Client", "None"],
                                onChanged: (value) {
                                  setState(() {
                                    Commands.contName = value;
                                  });
                                },
                                selectedItem: Commands.contName,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        margin: EdgeInsets.all(45),
                        child: Container(
                          margin: EdgeInsets.all(0),
                          height: 50,
                          width: 180,
                          child: FloatingActionButton(
                            isExtended: true,
                            backgroundColor: Colors.blueAccent.shade700,
                            child: isdone
                                ? Transform.scale(
                                    scale: 0.6,
                                    child: CircularProgressIndicator(
                                        backgroundColor: Colors.white))
                                : Text(
                                    "Create",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                            onPressed: createClusterIP,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.blueAccent.shade700,
                size: 28,
              ),
              onPressed: () async {
                await FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
                await FlutterStatusbarcolor.setStatusBarColor(Colors.white);
                await FlutterStatusbarcolor.setNavigationBarWhiteForeground(
                    false);
                await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
                Navigator.pop(context);
              }),
        ),
        body: body,
      ),
    );
  }
}
