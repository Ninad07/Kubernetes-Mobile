import 'dart:collection';

import 'package:KubernetesMobile/Resources/RC.dart';
import 'package:KubernetesMobile/Server/Network.dart';
import 'package:KubernetesMobile/Server/Volumes.dart';
import 'package:KubernetesMobile/main.dart';
import 'package:bmnav/bmnav.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:KubernetesMobile/DockerLaunch.dart';
import 'package:KubernetesMobile/FrontEnd.dart';

class Storage extends StatefulWidget {
  @override
  StorageState createState() => StorageState();
}

class StorageState extends State<Storage> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    var body = Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 35),
              alignment: Alignment.center,
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'images/kubernetes.png',
                height: 190,
                width: 290,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Card(
              color: Colors.white,
              //margin: EdgeInsets.only(right: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Container(
                height: 160,
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FloatingActionButton(
                  heroTag: "1",
                  isExtended: true,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PersistentVolume();
                    }));
                  },
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            "PV",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          //Deployment//
                          child: Text(
                            "Persistent Volume",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Card(
              color: Colors.white,
              //margin: EdgeInsets.only(right: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Container(
                height: 160,
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FloatingActionButton(
                  heroTag: "2",
                  isExtended: true,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PersistentVolumeClaim();
                    }));
                  },
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            "PVC",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          //Deployment//
                          child: Text(
                            "Persistent Volume Claim",
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

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
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.blueAccent.shade700,
              ),
              onPressed: () async {
                await FlutterStatusbarcolor.setStatusBarColor(
                    Colors.blueAccent.shade700);
                Navigator.pop(context);
              }),
        ),
        body: body,
      ),
    );
  }
}

class PersistentVolumeClaim extends StatefulWidget {
  @override
  _PersistentVolumeClaimState createState() => _PersistentVolumeClaimState();
}

class _PersistentVolumeClaimState extends State<PersistentVolumeClaim> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Ret("active");
    Path();
    Commands.name = null;
    Commands.isDone = false;
    isdone = false;
    Commands.text = null;
  }

  var isdone = false;

  CreatePVC() async {
    if (Commands.validation == "passed") {
      setState(() {
        isdone = true;
      });
      Commands.result = await serverCredentials.client.connect();
      if (Commands.loc1 != null && Commands.name != null) {
        print("${Commands.loc1}/${Commands.name}.yml");

        Commands.result = await serverCredentials.client.execute(
            "kubectl create pvc -f ${Commands.loc1}/${Commands.name}.yml");

        print("RS = ${Commands.result}");
        if (Commands.result != "")
          AppToast("Persistent Volume Claim created Successfully");
        else
          AppToast("Could not create Persistent Volume Claim");
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
    FlutterStatusbarcolor.setStatusBarColor(Colors.blueAccent.shade700);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    ScrollController controller = ScrollController();

    var body = Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.blueAccent.shade700),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Row(
              children: [
                /*Center(
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      'images/kube1.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),*/
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 0, left: 0, right: 120),
                          alignment: Alignment.center,
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Persistent",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              top: 0, bottom: 5, left: 0, right: 0),
                          alignment: Alignment.center,
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Volume Claim",
                            style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          )

                          /*Image.asset(
                        'images/kubernetes.png',
                        height: 190,
                        width: 290,
                      ),*/
                          ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width / 4.5,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 15, right: 15),
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'images/kube1.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 251,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 125, left: 10, right: 10),
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
                top: 5,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: SingleChildScrollView(
                child: Container(

                    //height: 600,
                    height: MediaQuery.of(context).size.height - 300,
                    margin: EdgeInsets.all(20),
                    width: 380,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.white,
                    )),
                    child: DraggableScrollbar.rrect(
                        backgroundColor: Colors.lightBlue,
                        labelTextBuilder: (offset) => Text("${offset.floor()}"),
                        controller: controller,
                        child: ListView(
                          controller: controller,
                          children: <Widget>[
                            SingleChildScrollView(
                                child: TextField(
                              keyboardType: TextInputType.multiline,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              maxLines: null,
                              minLines: 27,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Start writing here",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 13)),
                              onChanged: (value) {
                                Commands.text = value;
                                print(value);
                              },
                            )),
                          ],
                        ))),
              ),
            )
          ],
        ));

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
                return KubernetesMobile();
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
          //title: Text("Write RC"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: () async {
                  showAnimatedDialog(
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(seconds: 1),
                      barrierDismissible: true,
                      animationType: DialogTransitionType.slideFromTop,
                      context: context,
                      builder: (BuildContext context) {
                        return SaveResource();
                      });
                }),
            SizedBox(
              width: 5,
            ),
            Commands.isDone
                ? CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )
                : IconButton(
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: CreatePVC),
            SizedBox(width: 15),
          ],
        ),
        body: body,
      ),
    );
  }
}

class PersistentVolume extends StatefulWidget {
  @override
  _PersistentVolumeState createState() => _PersistentVolumeState();
}

class _PersistentVolumeState extends State<PersistentVolume> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Ret("active");
    Path();
    Commands.name = null;
    Commands.isDone = false;
    isdone = false;
    Commands.text = null;
  }

  var isdone = false;

  CreatePV() async {
    if (Commands.validation == "passed") {
      setState(() {
        isdone = true;
      });
      Commands.result = await serverCredentials.client.connect();
      if (Commands.loc1 != null && Commands.name != null) {
        print("${Commands.loc1}/${Commands.name}.yml");

        Commands.result = await serverCredentials.client.execute(
            "kubectl create pv -f ${Commands.loc1}/${Commands.name}.yml");

        print("RS = ${Commands.result}");
        if (Commands.result != "")
          AppToast("Persistent Volume created Successfully");
        else
          AppToast("Could not create Persistent Volume");
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
    FlutterStatusbarcolor.setStatusBarColor(Colors.blueAccent.shade700);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    ScrollController controller = ScrollController();

    var body = Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.blueAccent.shade700),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Row(
              children: [
                /*Center(
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Image.asset(
                      'images/kube1.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),*/
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 0, left: 0, right: 80),
                          alignment: Alignment.center,
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Persistent",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              top: 0, bottom: 5, left: 0, right: 90),
                          alignment: Alignment.center,
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Volume",
                            style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          )

                          /*Image.asset(
                        'images/kubernetes.png',
                        height: 190,
                        width: 290,
                      ),*/
                          ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 15, right: 30),
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'images/kube1.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 251,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 125, left: 10, right: 10),
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
                top: 5,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: SingleChildScrollView(
                child: Container(

                    //height: 600,
                    height: MediaQuery.of(context).size.height - 300,
                    margin: EdgeInsets.all(20),
                    width: 380,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.white,
                    )),
                    child: DraggableScrollbar.rrect(
                        backgroundColor: Colors.lightBlue,
                        labelTextBuilder: (offset) => Text("${offset.floor()}"),
                        controller: controller,
                        child: ListView(
                          controller: controller,
                          children: <Widget>[
                            SingleChildScrollView(
                                child: TextField(
                              keyboardType: TextInputType.multiline,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              maxLines: null,
                              minLines: 27,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Start writing here",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 13)),
                              onChanged: (value) {
                                Commands.text = value;
                                print(value);
                              },
                            )),
                          ],
                        ))),
              ),
            )
          ],
        ));

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
                return KubernetesMobile();
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
          //title: Text("Write RC"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: () async {
                  showAnimatedDialog(
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(seconds: 1),
                      barrierDismissible: true,
                      animationType: DialogTransitionType.slideFromTop,
                      context: context,
                      builder: (BuildContext context) {
                        return SaveResource();
                      });
                }),
            SizedBox(
              width: 5,
            ),
            Commands.isDone
                ? CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )
                : IconButton(
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: CreatePV),
            SizedBox(width: 15),
          ],
        ),
        body: body,
      ),
    );
  }
}
