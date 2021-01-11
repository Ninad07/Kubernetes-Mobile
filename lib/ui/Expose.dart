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

class _ExposeState extends State<Expose> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VolumeListRet();
    Retrive();
    Commands.name = null;
    Commands.contName = null;
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
                                  //dir = value;
                                  Commands.contName = value;
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
                              onChanged: (value) => {Commands.image = value},
                            ),
                          )
                        ],
                      ),
                    ),
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
                    Container(
                      height: 50,
                      width: 350,
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            child: Text("Object Name  : ",
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
                              items: ["TCP", "UDP", "SCTP"],
                              onChanged: (value) {
                                setState(() {
                                  //dir = value;
                                  Commands.contName = value;
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
                                "LoadBalancer",
                                "Cluster IP",
                                "Node Port",
                                "External Name",
                              ],
                              onChanged: (value) {
                                setState(() {
                                  //dir = value;
                                  Commands.contName = value;
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
                          child: launchLoading
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                )
                              : Text("Expose"),
                          onPressed: null,
                        ),
                      ),
                    ),
                    /*Column(children: <Widget>[
                      Container(
                        child: Row(children: <Widget>[
                          SizedBox(
                            width: 5,
                          ),
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool value) => {
                              setState(() {
                                isChecked = value;
                                isValue = false;
                              }),
                              print(isChecked),
                              if (isChecked == true)
                                {
                                  setState(() {
                                    Commands.restartAlways = true;
                                  })
                                }
                              else
                                {
                                  setState(() {
                                    Commands.restartAlways = false;
                                  })
                                }
                            },
                          ),
                          Container(
                            child: Text("Always Restart"),
                          ),
                        ]),
                      ),
                      Row(children: <Widget>[
                        SizedBox(
                          width: 5,
                        ),
                        Checkbox(
                          value: isValue,
                          onChanged: (bool value) => {
                            setState(() {
                              isValue = value;
                              isChecked = false;
                            }),
                            print(isValue),
                            if (isChecked == true)
                              {
                                setState(() {
                                  Commands.deleteAlways = true;
                                })
                              }
                            else
                              {
                                setState(() {
                                  Commands.deleteAlways = false;
                                })
                              }
                          },
                        ),
                        Text('Always Delete')
                      ]),
                      
                    ])*/
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Network();
              }));
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Volume();
              }));
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
