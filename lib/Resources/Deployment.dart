import 'package:KubernetesMobile/Animation/animation.dart';
import 'package:KubernetesMobile/Resources/RC.dart';
import 'package:KubernetesMobile/Server/Network.dart';
import 'package:KubernetesMobile/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../DockerLaunch.dart';
import '../FrontEnd.dart';

class Deployment extends StatefulWidget {
  @override
  _DeploymentState createState() => _DeploymentState();
}

class _DeploymentState extends State<Deployment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Commands.name = null;
    Commands.image = null;
    Commands.replicas = null;
    Commands.port = null;
  }

  @override
  Widget build(BuildContext context) {
    var isDeployed = false;
    var isdone = false;

    //################ Deployment Function ######################//
    Deploy() async {
      setState(() {
        isDeployed = true;
      });

      if (Commands.validation == "passed") {
        Commands.result = await serverCredentials.client.connect();

        if (Commands.name != null && Commands.image != null) {
          //PORT

          //if (Commands.port != null) Commands.port = "--port=${Commands.port}";

          if (Commands.port == null) {
            //REPLICAS
            if (Commands.replicas == null) {
              Commands.result = await serverCredentials.client.execute(
                  "kubectl create deployment ${Commands.name} --image=${Commands.image} ");
            } else {
              Commands.result = await serverCredentials.client.execute(
                  "kubectl create deployment ${Commands.name} --image=${Commands.image} --replicas=${Commands.replicas}");
            }
            //REPLICAS
          } else {
            if (Commands.replicas == null) {
              Commands.result = await serverCredentials.client.execute(
                  "kubectl create deployment ${Commands.name} --image=${Commands.image} --port=${Commands.port}");
            } else {
              print(
                  "kubectl create deployment ${Commands.name} --image=${Commands.image} --replicas=${Commands.replicas} --port=${Commands.port}");
              Commands.result = await serverCredentials.client.execute(
                  "kubectl create deployment ${Commands.name} --image=${Commands.image} --replicas=${Commands.replicas} --port=${Commands.port}");
            }
          }
          //PORT

        } else {
          AppToast("Please specify name and image");
        }

        if (Commands.result != "")
          AppToast("Deployment Created Successfully");
        else
          AppToast("Failed to create Deployment");
      } else
        AppToast("Server not connected");

      setState(() {
        isDeployed = false;
      });
    }

    var body = Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(overflow: Overflow.visible, children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.blueAccent.shade700,
          ),
          FadeAnimation(
            1,
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 25, left: 0, right: 35),
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
            margin: EdgeInsets.only(top: 140),
            height: MediaQuery.of(context).size.height - 140,
            width: MediaQuery.of(context).size.width - 15,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(75))),
            child: Container(
              padding: EdgeInsets.all(17),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.2,
                      Container(
                        height: 40,
                        width: 320,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent.shade700,
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.only(
                            top: 25, left: 0, right: 25, bottom: 20),
                        child: Center(
                          child: Text(
                            "Deployment",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1.4,
                      Container(
                        height: 48,
                        width: 350,
                        margin: EdgeInsets.only(top: 20, left: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 70,
                              child: Text(
                                "Name   : ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 48,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: TextField(
                                autocorrect: false,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    isDense: true,
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
                        height: 48,
                        width: 350,
                        margin: EdgeInsets.only(top: 20, left: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 70,
                              child: Text("Image  : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 48,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: TextField(
                                autocorrect: false,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "image",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                onChanged: (value) => {Commands.image = value},
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1.8,
                      Container(
                        height: 48,
                        width: 350,
                        margin: EdgeInsets.only(top: 20, left: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 70,
                              child: Text("Port     : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 48,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    isDense: true,
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
                      2,
                      Container(
                        height: 48,
                        width: 350,
                        margin: EdgeInsets.only(top: 20, left: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 75,
                              child: Text("Replicas : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 48,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 15, right: 10),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "replicas",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                onChanged: (value) =>
                                    {Commands.replicas = value},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                      2.2,
                      Column(children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          margin: EdgeInsets.all(25),
                          child: Container(
                            margin: EdgeInsets.all(0),
                            height: 45,
                            width: 180,
                            child: FloatingActionButton(
                              isExtended: true,
                              backgroundColor: Colors.blueAccent.shade700,
                              child: isDeployed
                                  ? Transform.scale(
                                      scale: 0.6,
                                      child: CircularProgressIndicator(
                                          backgroundColor: Colors.white))
                                  : Text("Deploy"),
                              onPressed: Deploy,
                            ),
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNav(
          iconStyle: IconStyle(onSelectSize: 30),
          index: Commands.currentindex,
          labelStyle: LabelStyle(showOnSelect: true),
          onTap: (index) {
            if (index == 0) {
              setState(() {
                Commands.currentindex = 0;
              });
            }
            if (index == 1) {
              setState(() {
                Commands.currentindex = 1;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Dashboard();
              }));
            }
            if (index == 2) {
              setState(() {
                Commands.currentindex = 2;
              });
            }
          },
          items: [
            BottomNavItem(Icons.cloud, label: 'Networks'),
            BottomNavItem(Icons.home, label: 'Home'),
            BottomNavItem(Icons.storage, label: 'Volumes')
          ],
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueAccent.shade700,
          title: Text(
            "Create Deployment",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  FlutterIcons.pencil_ent,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ReplicationController(s: "Dep");
                  }));
                })
          ],
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => {Navigator.pop(context)}),
        ),
        body: body,
      ),
    );
  }
}
