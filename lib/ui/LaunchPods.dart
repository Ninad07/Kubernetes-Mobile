import 'package:KubernetesMobile/Animation/animation.dart';
import 'package:KubernetesMobile/Server/Network.dart';
import 'package:KubernetesMobile/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:KubernetesMobile/DockerLaunch.dart';
import 'package:KubernetesMobile/FrontEnd.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class PodLaunch extends StatefulWidget {
  @override
  _PodLaunchState createState() => _PodLaunchState();
}

bool launchLoading = false;
TextEditingController _value;
String environment = "";
var i;

class _PodLaunchState extends State<PodLaunch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VolumeListRet();
    Retrive();
    Commands.name = null;
    Commands.image = null;
    Commands.port = null;
    Commands.loc1 = null;
    Commands.loc2 = null;
    Commands.env = null;
  }

  bool isChecked = false;
  bool isValue = false;
  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue.shade600);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    print("COMMANDS.ENV = ${Commands.env}");

    TextEditingController nametxt = new TextEditingController();
    TextEditingController imagetxt = new TextEditingController();

    TextEditingController porttxt = new TextEditingController();
    TextEditingController envtxt = new TextEditingController();

    LaunchPods() async {
      setState(() {
        launchLoading = true;
      });

      if (Commands.validation == "passed") {
        Commands.result = await serverCredentials.client.connect();

        if (Commands.name != null && Commands.image != null) {
          if (Commands.port != null)
            Commands.port = "--port=" + Commands.port;
          else
            Commands.port = "";

          if (Commands.env != null)
            Commands.env = "--labels=" + Commands.env;
          else
            Commands.env = "";

          if (Commands.restartAlways == true)
            Commands.loc1 = "--restart='Always";
          else
            Commands.loc1 = "";

          if (Commands.deleteAlways == true)
            Commands.loc2 = "--rm=true";
          else
            Commands.loc2 = "";

          Commands.result = await serverCredentials.client.execute(
              "kubectl run  ${Commands.name} --image=${Commands.image} ${Commands.port} ${Commands.env} ${Commands.loc1} ${Commands.loc2} ");

          if (Commands.result != "") {
            AppToast("Pod launched successfully");
            Commands.image = Commands.loc1 = Commands.loc2 =
                Commands.port = Commands.env = Commands.name = null;

            nametxt.clear();
            imagetxt.clear();
            porttxt.clear();
            envtxt.clear();
          } else
            AppToast("Cannot Launch pod");
        } else {
          AppToast("Please enter Name and Image");
        }
      } else
        AppToast("Server Not connected");

      setState(() {
        launchLoading = false;
      });
    }

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
                            "Pods",
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
                                controller: nametxt,
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
                              child: Text("Image  : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 45,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: TextField(
                                controller: imagetxt,
                                autocorrect: false,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
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
                        height: 50,
                        width: 350,
                        margin: EdgeInsets.only(top: 20, left: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 70,
                              child: Text("Ports    : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 45,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: TextField(
                                controller: porttxt,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Ports",
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
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 20, left: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 70,
                              child: Text("Labels  : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 45,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: TextField(
                                controller: envtxt,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText:
                                        "For ex. env=prod(comma separated)",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                onChanged: (value) => {Commands.env = value},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(children: <Widget>[
                      FadeAnimation(
                        2.2,
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
                      ),
                      FadeAnimation(
                        2.4,
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
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        2.6,
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
                                  : Text("Launch"),
                              onPressed: LaunchPods,
                            ),
                          ),
                        ),
                      )
                    ])
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
            "Launch Pods",
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
