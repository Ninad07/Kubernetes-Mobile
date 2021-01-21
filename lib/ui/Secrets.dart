import 'package:KubernetesMobile/Server/Network.dart';
import 'package:KubernetesMobile/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:flutter/material.dart';

import '../DockerLaunch.dart';
import '../FrontEnd.dart';

class Secrets extends StatefulWidget {
  @override
  _SecretsState createState() => _SecretsState();
}

class _SecretsState extends State<Secrets> {
  var isdone = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Commands.name = null;
    Commands.passwd = null;
  }

  createSecret() async {
    if (Commands.validation == "passed") {
      setState(() {
        isdone = true;
      });
      Commands.result = await serverCredentials.client.connect();
      if (Commands.passwd != null && Commands.name != null) {
        print("${Commands.name} ${Commands.passwd}");

        Commands.result = await serverCredentials.client.execute(
            "kubectl create secret generic ${Commands.name} --from-literal=${Commands.passwd} ");

        print("RS = ${Commands.result}");
        if (Commands.result != "")
          AppToast("Secret created Successfully");
        else
          AppToast("Could not create Secret");
      } else
        AppToast("No file found");
    } else
      AppToast("Server not connected");

    setState(() {
      isdone = false;
    });
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
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 25, left: 0, right: 0),
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
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 140, left: 15),
            height: MediaQuery.of(context).size.height - 140,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75))),
            child: Container(
              padding: EdgeInsets.all(17),
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                Container(
                  height: 40,
                  width: 320,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.shade700,
                      borderRadius: BorderRadius.circular(20)),
                  margin:
                      EdgeInsets.only(top: 15, left: 25, right: 0, bottom: 20),
                  child: Center(
                    child: Text(
                      "Create Secrets",
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
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
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
                        child: Text("Literals  : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
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
                              hintText: "for ex. p=password",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          onChanged: (value) => {Commands.passwd = value},
                        ),
                      )
                    ],
                  ),
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
                      child: Text("Launch"),
                      onPressed: createSecret,
                    ),
                  ),
                )
              ])),
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
            "Secrets",
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
