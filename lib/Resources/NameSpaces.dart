import 'package:KubernetesMobile/Server/Network.dart';
import 'package:KubernetesMobile/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../DockerLaunch.dart';
import '../FrontEnd.dart';

class Namespace extends StatefulWidget {
  @override
  _NamespaceState createState() => _NamespaceState();
}

class _NamespaceState extends State<Namespace> {
  var isdone = false;
  //CREATE NAMESPACE FUNCTION
  createNS() async {
    setState(() {
      isdone = true;
    });
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();

      if (Commands.name != null) {
        if (Commands.contName != null) {
          Commands.result = await serverCredentials.client.execute(
              "kubectl create namespace ${Commands.name} --dry-run=${Commands.contName}");
        } else {
          Commands.result = await serverCredentials.client
              .execute("kubectl create namespace ${Commands.name}");
        }
      } else {
        AppToast("Cannot create NS. Please enter a valid Name");
      }
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
    Commands.contName = null;
  }

  @override
  Widget build(BuildContext context) {
    var isDeployed = false;

    var body = Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
            margin: EdgeInsets.only(top: 140, left: 15),
            height: MediaQuery.of(context).size.height - 140,
            width: MediaQuery.of(context).size.width - 15,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75))),
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
                          top: 25, left: 25, right: 0, bottom: 20),
                      child: Center(
                        child: Text(
                          "Namespace",
                          style: TextStyle(color: Colors.white),
                        ),
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
                            margin: EdgeInsets.only(left: 20, right: 10),
                            child: TextField(
                              autocorrect: false,
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
                    Container(
                      height: 50,
                      width: 350,
                      margin: EdgeInsets.only(
                        top: 25,
                        left: 0,
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
                            margin: EdgeInsets.only(left: 5, right: 10),
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
                          onPressed: createNS,
                        ),
                      ),
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
            "Create Namespace",
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
