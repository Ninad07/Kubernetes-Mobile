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
    Commands.replicas = null;
    Commands.port = null;
  }

  bool isChecked = false;
  bool isValue = false;
  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue.shade600);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    print("COMMANDS.ENV = ${Commands.env}");

    for (i = 0; i < Commands.env.length; i++) {
      print(Commands.env[i]);
      environment = environment + " -e " + Commands.env[i];
      print("ENVIRONMENT = $environment");
    }

    DynamicAdd() {
      Commands.TextfieldDynamic.add(new DynamicText());
      print(Commands.TextfieldDynamic.length);
      setState(() {
        PodLaunch();
      });
    }

    DynamicRemove() {
      Commands.TextfieldDynamic.removeLast();
      if (Commands.env.length > 0) {
        Commands.env.removeLast();
      }
      print(Commands.TextfieldDynamic.length);
      setState(() {
        PodLaunch();
      });
    }

    LaunchPods() async {
      setState(() {
        launchLoading = true;
      });

      if (Commands.validation == "passed") {
        Commands.result = await serverCredentials.client.connect();

        if (Commands.name != null && Commands.image != null) {
          print(Commands.name + "  " + Commands.image);
          print(Commands.deleteAlways);
          //##### DELETE #####//
          if (Commands.deleteAlways == false) {
            print(Commands.deleteAlways);
            //##### RESTART #####//
            if (Commands.restartAlways == false) {
              print(Commands.restartAlways);
              //##### ENV #####//
              if (Commands.env.length == 0) {
                print(Commands.env.length);
                //##### PORT #####//
                if (Commands.port == null) {
                  print(Commands.port);
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --image=${Commands.image}");

                  print("HERE = ${Commands.result}");
                } else {
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --port=${Commands.port}  --image=${Commands.image}");
                }
                //##### PORT #####//

              } else {
                if (Commands.port == null) {
                  /////////////////PENDING///////////////////////////////
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --env --image=${Commands.image}");
                } else {
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --env  --port=${Commands.port}  --image=${Commands.image}");
                }
              }
              //################# ENV ###############################//

            } else {
              if (Commands.env.length == 0) {
                //##### PORT #####//
                if (Commands.port == null) {
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --restart='Always' --image=${Commands.image}");
                } else {
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --port=${Commands.port} --restart='Always'  --image=${Commands.image}");
                }
                //##### PORT #####//

              } else {
                if (Commands.port == null) {
                  /////////////////PENDING///////////////////////////////
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --restart='Always' --env --image=${Commands.image}");
                } else {
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --restart='Always'  --env  --port=${Commands.port}  --image=${Commands.image}");
                }
              }
            }

            //###################### RESTART #################################//

          } else {
            if (Commands.restartAlways == false) {
              //##### ENV #####//
              if (Commands.env.length == 0) {
                //##### PORT #####//
                if (Commands.port == null) {
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --rm=true --image=${Commands.image}");
                } else {
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --rm=true --port=${Commands.port}  --image=${Commands.image}");
                }
                //##### PORT #####//

              } else {
                if (Commands.port == null) {
                  /////////////////PENDING///////////////////////////////
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --rm=true --env --image=${Commands.image}");
                } else {
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --rm=true --env --port=${Commands.port}  --image=${Commands.image}");
                }
              }
              //################# ENV ###############################//

            } else {
              if (Commands.env.length == 0) {
                //##### PORT #####//
                if (Commands.port == null) {
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --restart='Always' --image=${Commands.image}");
                } else {
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --port=${Commands.port} --restart='Always'  --image=${Commands.image}");
                }
                //##### PORT #####//

              } else {
                if (Commands.port == null) {
                  /////////////////PENDING///////////////////////////////
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --restart='Always' --env --image=${Commands.image}");
                } else {
                  Commands.result = await serverCredentials.client.execute(
                      "kubectl run ${Commands.name} --restart='Always'  --env  --port=${Commands.port}  --image=${Commands.image}");
                }
              }
            }
          }
        } else {
          AppToast("Please enter Name and Image");
        }
      }

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
                          "Pods",
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
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            child: Text("Image  : ",
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
                    Container(
                      height: 50,
                      width: 350,
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            child: Text("Ports    : ",
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
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            child: Text("Labels  : ",
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
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "For ex. env=prod(comma separated)",
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
                    SizedBox(
                      height: 10,
                    ),
                    Column(children: <Widget>[
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
                                : Text("Launch"),
                            onPressed: LaunchPods,
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

class DynamicText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 250,
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(left: 10, right: 0, top: 10),
      child: TextField(
        controller: _value,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "labels",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        autocorrect: false,
        enableInteractiveSelection: true,
        enableSuggestions: true,
        onSubmitted: (String value) => {Commands.env.add(value)},
        //onChanged: (String value) => {Commands.env.add(value)},
      ),
    );
  }
}
