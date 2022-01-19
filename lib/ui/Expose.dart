import 'package:KubernetesMobile/Animation/animation.dart';
import 'package:KubernetesMobile/Server/Network.dart';
import 'package:KubernetesMobile/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:KubernetesMobile/DockerLaunch.dart';
import 'package:KubernetesMobile/FrontEnd.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class Expose extends StatefulWidget {
  @override
  _ExposeState createState() => _ExposeState();
}

bool launchLoading = false;
TextEditingController _value;
String environment = "";
var i;
TextEditingController nametxt = new TextEditingController();
TextEditingController selectortxt = new TextEditingController();
TextEditingController porttxt = new TextEditingController();
TextEditingController targetporttxt = new TextEditingController();
TextEditingController objnametxt = new TextEditingController();

class _ExposeState extends State<Expose> {
  //EXPOSE FUNCTION
  exposeResources() async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();

      if (Commands.name != null && Commands.contName != null) {
        //Validating selector
        if (Commands.selector == null) {
          Commands.selector = "";
        } else {
          Commands.selector = "--selector=${Commands.selector}";
        }

        //Validating port and Target port
        if (Commands.port == null) {
          Commands.port = "";
        } else {
          Commands.port = "--port=${Commands.port} ";
        }

        if (Commands.targetPort == null) {
          Commands.targetPort = "";
        } else {
          Commands.targetPort = "--target-port=${Commands.targetPort} ";
        }

        //Validating Object Name
        if (Commands.image == null) {
          Commands.image = "";
        } else {
          Commands.image = "--name=${Commands.image} ";
        }

        //Validating protocol
        if (Commands.protocol == null) {
          Commands.protocol = "";
        } else {
          Commands.protocol = "--protocol=${Commands.protocol} ";
        }

        //validating type
        if (Commands.type == null) {
          Commands.type = "";
        } else {
          Commands.type = "--type=${Commands.type} ";
        }

        Commands.result = await serverCredentials.client.execute(
            "kubectl expose ${Commands.contName}/${Commands.name} ${Commands.port} ${Commands.targetPort} ${Commands.image} ${Commands.protocol} ${Commands.type}");

        print(
            "kubectl expose ${Commands.contName}/${Commands.name} ${Commands.port} ${Commands.targetPort} ${Commands.image} ${Commands.protocol} ${Commands.type}");
        print("RESULT = ${Commands.result}");

        if (Commands.result != "") {
          AppToast("Exposed");
          Commands.name = null;
          Commands.contName = null;
          Commands.selector = null;
          Commands.port = null;
          Commands.targetPort = null;
          Commands.image = null;
          Commands.protocol = null;
          Commands.type = null;
          nametxt.clear();
          selectortxt.clear();
          porttxt.clear();
          targetporttxt.clear();
          objnametxt.clear();
        } else
          AppToast("Failed to expose");
      } else {
        AppToast("Cannot Expose");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VolumeListRet();
    Retrive();
    Commands.name = null;
    Commands.contName = null;
    Commands.selector = null;
    Commands.port = null;
    Commands.targetPort = null;
    Commands.image = null;
    Commands.protocol = null;
    Commands.type = null;
  }

  bool isChecked = false;
  bool isValue = false;
  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue.shade600);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);

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
                            "Expose Resources",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
                                    //dir = value;
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
                                    print("RES = ${Commands.contName}");

                                    //print("ABCD = ${Commands.contName}");
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
                                onChanged: (value) => {
                                  Commands.name = value,
                                  print("ABCD = ${Commands.contName}")
                                },
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
                              child: Text("Selector  : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
                                onChanged: (value) =>
                                    {Commands.selector = value},
                              ),
                            )
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
                          top: 20,
                          left: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 85,
                              child: Text(
                                "Port      : ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 0, right: 10),
                              child: TextField(
                                controller: porttxt,
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
                      2.2,
                      Container(
                        height: 50,
                        width: 350,
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 85,
                              child: Text(
                                "Target   : ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 0, right: 0),
                              child: TextField(
                                controller: targetporttxt,
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
                      2.4,
                      Container(
                        height: 50,
                        width: 350,
                        margin: EdgeInsets.only(top: 20, left: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 70,
                              child: Text("Object Name  : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 45,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 15, right: 10),
                              child: TextField(
                                controller: objnametxt,
                                autocorrect: false,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "object name flag",
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
                      2.6,
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
                              child: Text("Protocol : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
                                items: ["TCP", "UDP", "SCTP"],
                                onChanged: (value) {
                                  setState(() {
                                    //dir = value;
                                    Commands.protocol = value;
                                    print("OPHERE01 = ${Commands.protocol}");

                                    //print("ABCD = ${items}");
                                  });
                                },
                                selectedItem: Commands.protocol,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeAnimation(
                      2.8,
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
                              child: Text("Type : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
                                  "LoadBalancer",
                                  "ClusterIP",
                                  "NodePort",
                                  "ExternalName",
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    //dir = value;
                                    Commands.type = value;
                                    print("OPHERE01 = ${Commands.type}");

                                    //print("ABCD = ${items}");
                                  });
                                },
                                selectedItem: Commands.type,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                      3,
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
                            child: launchLoading
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  )
                                : Text("Expose"),
                            onPressed: exposeResources,
                          ),
                        ),
                      ),
                    ),
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
            "Expose Resources",
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
