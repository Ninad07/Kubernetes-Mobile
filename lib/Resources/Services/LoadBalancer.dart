import 'package:KubernetesMobile/Animation/animation.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../../DockerLaunch.dart';

class LoadBalancer extends StatefulWidget {
  @override
  _LoadBalancerState createState() => _LoadBalancerState();
}

class _LoadBalancerState extends State<LoadBalancer> {
  //CREATE LOADBALANCER SERVICE FUNCTION
  var isdone = false;
  createLB() async {
    if (Commands.validation == "passed") {
      setState(() {
        isdone = true;
      });
      Commands.result = await serverCredentials.client.connect();

      if (Commands.name != null &&
          Commands.port != null &&
          Commands.targetPort != null) {
        if (Commands.contName == null) {
          Commands.result = await serverCredentials.client.execute(
              "kubectl create service loadbalancer ${Commands.name} --tcp=${Commands.port}:${Commands.targetPort}");

          print(
              "kubectl create service loadbalancer ${Commands.name} --tcp=${Commands.port}:${Commands.targetPort}");
        } else {
          Commands.result = await serverCredentials.client.execute(
              "kubectl create service loadbalancer ${Commands.name} --tcp=${Commands.port}:${Commands.targetPort} --dry-run=${Commands.contName}");
        }
      } else {
        AppToast("Cannot create the service");
      }

      if (Commands.result != "") {
        AppToast("Service created Successfully");
        Commands.name = null;
        Commands.port = null;
        Commands.targetPort = null;
        Commands.contName = null;
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
    Commands.contName = null;
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Colors.blueAccent.shade700);
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    var body = Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.blueAccent.shade700),
      child: Stack(
        children: [
          FadeAnimation(
            2.4,
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
                  FadeAnimation(
                    1,
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Load Balancer",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.2,
                    Container(
                      height: 40,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent.shade400,
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(top: 50, bottom: 20),
                      child: Center(
                        child: Text(
                          "Create LB",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      FadeAnimation(
                        1.4,
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
                                  onChanged: (value) => {Commands.name = value},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1.6,
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
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "port",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                  onChanged: (value) => {Commands.port = value},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1.8,
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
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "target port",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                  onChanged: (value) =>
                                      {Commands.targetPort = value},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        2,
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
                      ),
                      FadeAnimation(
                        2.2,
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
                              onPressed: createLB,
                            ),
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
