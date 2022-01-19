import 'package:KubernetesMobile/Animation/animation.dart';
import 'package:KubernetesMobile/Server/Network.dart';
import 'package:KubernetesMobile/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../DockerLaunch.dart';
import '../FrontEnd.dart';

class Scale extends StatefulWidget {
  @override
  _ScaleState createState() => _ScaleState();
}

class _ScaleState extends State<Scale> {
  TextEditingController nametxt = new TextEditingController();
  TextEditingController selectortxt = new TextEditingController();
  TextEditingController replicatxt = new TextEditingController();
  TextEditingController imagetxt = new TextEditingController();
  TextEditingController currentreplicatxt = new TextEditingController();
  scaleResources() async {
    if (Commands.validation == "passed") {
      if (Commands.name != null) {
        //Validating current replicas
        if (Commands.currentreplicas == null) {
          Commands.currentreplicas = "";
        } else {
          Commands.currentreplicas =
              "--current-replicas=${Commands.currentreplicas} ";
        }

        //Validating replicas
        if (Commands.replicas == null) {
          Commands.replicas = "";
        } else {
          Commands.replicas = "--replicas=${Commands.replicas} ";
        }

        //Validating selector
        if (Commands.selector == null) {
          Commands.selector = "";
        } else {
          Commands.selector = "--selector=${Commands.selector} ";
        }

        //Validating Dry run
        if (Commands.image == null) {
          Commands.image = "";
        } else {
          Commands.image = "--dry-run=${Commands.image} ";
        }

        Commands.result = await serverCredentials.client.execute(
            "kubectl scale ${Commands.contName}/${Commands.name} ${Commands.currentreplicas} ${Commands.replicas} ${Commands.selector} ${Commands.image}");

        print(
            "kubectl scale ${Commands.contName}/${Commands.name} ${Commands.currentreplicas} ${Commands.replicas} ${Commands.selector} ${Commands.image}");

        if (Commands.result != "") {
          AppToast("Resources Scaled");
          Commands.contName = null;
          Commands.name = null;
          Commands.currentreplicas = null;
          Commands.replicas = null;
          Commands.selector = null;
          Commands.image = null;

          nametxt.clear();
          replicatxt.clear();
          imagetxt.clear();
          selectortxt.clear();
          currentreplicatxt.clear();
        } else
          AppToast("Cannot Scale Resource");
      } else {
        AppToast("No resource name provided");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Commands.contName = null;
    Commands.name = null;
    Commands.currentreplicas = null;
    Commands.replicas = null;
    Commands.selector = null;
    Commands.image = null;
  }

  @override
  Widget build(BuildContext context) {
    var body = Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        /*decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/kubernetes.png"), fit: BoxFit.cover)),*/
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
                    margin: EdgeInsets.only(top: 25, right: 20),
                    child: Center(
                      child: Text(
                        "Scale",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Column(children: <Widget>[
                  FadeAnimation(
                    1.4,
                    Container(
                      height: 50,
                      width: 350,
                      margin: EdgeInsets.only(
                        top: 25,
                        left: 10,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 85,
                            child: Text("Resource : ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            height: 45,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(left: 0, right: 10),
                            child: DropdownSearch(
                              popupBackgroundColor: Colors.white,
                              mode: Mode.MENU,
                              showSelectedItem: true,
                              items: [
                                "Pod",
                                "Deployment",
                                "Replica Set",
                                "Replication Controller",
                                "Service"
                              ],
                              onChanged: (value) {
                                setState(() {
                                  if (value == "Pod")
                                    Commands.contName = "pod";
                                  else if (value == "Deployment")
                                    Commands.contName = "deployment";
                                  else if (value == "Replica Set")
                                    Commands.contName = "rs";
                                  else if (value == "Service")
                                    Commands.contName = "svc";
                                  else
                                    Commands.contName = "rc";
                                  //dir = value;

                                  print("OPHERE01 = ${Commands.contName}");

                                  //print("ABCD = ${items}");
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
                    1.6,
                    Container(
                      height: 50,
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
                            height: 45,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(left: 15, right: 10),
                            child: TextField(
                              controller: nametxt,
                              autocorrect: false,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "resource name",
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
                    1.8,
                    Container(
                      height: 50,
                      width: 350,
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            child: Text(
                              "Current Replicas : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(left: 15, right: 10),
                            child: TextField(
                              controller: currentreplicatxt,
                              autocorrect: false,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "current replicas if any",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              onChanged: (value) =>
                                  {Commands.currentreplicas = value},
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
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            child: Text(
                              "Replicas : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(left: 15, right: 10),
                            child: TextField(
                              controller: replicatxt,
                              autocorrect: false,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "replicas",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              onChanged: (value) => {Commands.replicas = value},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    2.2,
                    Container(
                      height: 50,
                      width: 350,
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            child: Text("Selector  : ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            height: 45,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(left: 15, right: 10),
                            child: TextField(
                              controller: selectortxt,
                              autocorrect: false,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "ex. env=prod (comma separated)",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              onChanged: (value) => {Commands.selector = value},
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    2.4,
                    Container(
                      height: 50,
                      width: 350,
                      margin: EdgeInsets.only(
                        top: 25,
                        left: 10,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 85,
                            child: Text("Dry run  : ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            height: 45,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(left: 0, right: 10),
                            child: DropdownSearch(
                              popupBackgroundColor: Colors.white,
                              mode: Mode.MENU,
                              showSelectedItem: true,
                              items: ["Server", "Client", "None"],
                              onChanged: (value) {
                                setState(() {
                                  Commands.image = value;
                                });
                              },
                              selectedItem: Commands.image,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    2.6,
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      margin: EdgeInsets.all(30),
                      child: Container(
                        margin: EdgeInsets.all(0),
                        height: 50,
                        width: 180,
                        child: FloatingActionButton(
                          isExtended: true,
                          backgroundColor: Colors.blueAccent.shade700,
                          child: Text("Scale"),
                          onPressed: scaleResources,
                        ),
                      ),
                    ),
                  )
                ])
              ],
            )),
          )
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
            "Scale Resources",
            style: TextStyle(color: Colors.white),
          ),
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
