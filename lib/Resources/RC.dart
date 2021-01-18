import 'package:KubernetesMobile/Server/Network.dart';
import 'package:KubernetesMobile/Server/Volumes.dart';
import 'package:KubernetesMobile/main.dart';
import 'package:bmnav/bmnav.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import '../DockerLaunch.dart';
import '../FrontEnd.dart';

class ReplicationController extends StatefulWidget {
  @override
  _ReplicationControllerState createState() => _ReplicationControllerState();
}

class _ReplicationControllerState extends State<ReplicationController> {
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

  CreateRC() async {
    if (Commands.validation == "passed") {
      setState(() {
        isdone = true;
      });
      Commands.result = await serverCredentials.client.connect();
      if (Commands.loc1 != null && Commands.name != null) {
        print("${Commands.loc1}/${Commands.name}.yml");

        Commands.result = await serverCredentials.client.execute(
            "kubectl create rc -f ${Commands.loc1}/${Commands.name}.yml");

        print("RC = ${Commands.result}");
        if (Commands.result != "")
          AppToast("RC created Successfully");
        else
          AppToast("Could not create RC");
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
                              top: 5, bottom: 0, left: 0, right: 60),
                          alignment: Alignment.center,
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Replication",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )

                          /*Image.asset(
                        'images/kubernetes.png',
                        height: 190,
                        width: 290,
                      ),*/
                          ),
                      Container(
                          margin: EdgeInsets.only(
                              top: 0, bottom: 5, left: 0, right: 0),
                          alignment: Alignment.center,
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Controller",
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
                  showDialog(
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
                    onPressed: CreateRC),
            SizedBox(width: 15),
          ],
        ),
        body: body,
      ),
    );
  }
}

class SaveResource extends StatefulWidget {
  @override
  _SaveResourceState createState() => _SaveResourceState();
}

class _SaveResourceState extends State<SaveResource> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Ret("active");
    Path();
    Commands.name = null;
    Commands.text = null;
  }

  bool isloading1 = false;
  String dir = " ";
  int l = 1, y = 0;

  List<String> container;
  List<String> container2 = ["/"];

  int max = 1;

  Fun() async {
    if (container2.length == 0) {
      container2.add("/");
    }
    result2 = await serverCredentials.client.execute("ls ${container2.join()}");
    setState(() {
      Commands.dir = result2.split('\n').toList();
    });
  }

  void Path() async {
    setState(() {
      isloading1 = true;
    });

    print('path function called');

    if (Commands.validation == "passed") {
      if (Commands.isaws == true) {
        setState(() {
          dir = Commands.ec2dir;
        });
      }

      if (dir == " ") {
        l--;
      }

      if (l > 2) {
        container = dir.split("");
        print("SPLIT = $container");
        container.removeLast();
        print("LAST = ${container.length}");

        if (container.join() != container2.join()) {
          String p = "/";
          if (y == 0) {
            y = 1;
          } else {
            if (container2.length > 1) {
              container2.add(p);
            }
          }
          container2.add(container.join());

          Commands.ec2cont = container2.join();

          result2 =
              await serverCredentials.client.execute("ls ${container2.join()}");
          Commands.dir = await result2.split('\n').toList();
        }
        print("tttt");
      } else if (l == 0) {
        print('ffff');
        result2 = await serverCredentials.client.execute("ls /$dir");
        Commands.dir = await result2.split('\n').toList();
        l = 3;
      }

      print("DIR = ");
      for (var i in Commands.dir) {
        print(i);
      }
    } else {
      AppToast("Server not connected");
    }
    //print(Commands.demo1);
    setState(() {
      isloading1 = false;
    });
  }

  Save() async {
    if (Commands.validation == "passed") {
      Commands.result = serverCredentials.client.connect();
      if (Commands.name != null && container2.join() != null) {
        print("\n\n\nTEXT = " + Commands.text);
        print("\nLOC = " + container2.join());
        print("\n\Name " + Commands.name);
        print(
            '\necho """${Commands.text}""" > ${container2.join()}/${Commands.name}.yml');
        Commands.loc1 = container2.join();
        Commands.result = serverCredentials.client.execute(
            'echo """${Commands.text}""" > ${container2.join()}/${Commands.name}.yml ');

        if (Commands.result != "")
          AppToast("File saved");
        else
          AppToast("Cannot save the file");

        print("SAVED = ${Commands.result}");
      } else {
        AppToast("Cannot Save the file");
      }
    } else
      AppToast("Server not connected");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            right: -35.0,
            top: -30.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                backgroundColor: Colors.blueAccent.shade700,
                maxRadius: 19,
                child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: Navigator.of(context).pop),
              ),
            ),
          ),
          Form(
            child: Container(
              height: 370,
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 0),
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 27,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 300,
                        margin: EdgeInsets.only(
                          top: 25,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 85,
                              child: Text("Name  :",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 35,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Name of the rc",
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
                        height: 150,
                        width: 300,
                        margin: EdgeInsets.only(
                          top: 25,
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 200, bottom: 10),
                              alignment: Alignment.centerLeft,
                              width: 85,
                              child: Text("Location: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      FlutterIcons.arrow_circle_left_faw5s,
                                      color: Colors.blueAccent.shade700,
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        container2.removeLast();
                                        container2.removeLast();

                                        Fun();
                                      });
                                    }),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 35,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownSearch(
                                    maxHeight: 280,
                                    showSearchBox: true,
                                    searchBoxDecoration: InputDecoration(
                                      hintText: "Search",
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                      suffixIcon: Icon(Icons.search),
                                    ),
                                    popupBackgroundColor: Colors.white,
                                    mode: Mode.MENU,
                                    showSelectedItem: true,
                                    items: Commands.dir,
                                    onChanged: (value) {
                                      setState(() {
                                        dir = value;

                                        Path();
                                        print("ABCD = ${container2.join()}");
                                      });
                                    },
                                    selectedItem: container2.join(),
                                  ),
                                ),
                              ],
                            ),
                            Card(
                              margin:
                                  EdgeInsets.only(left: 15, right: 15, top: 10),
                              elevation: 5,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  color: Colors.grey.shade100,
                                ),
                                //margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                      "  " + "${container2.join()}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        margin: EdgeInsets.all(25),
                        child: Container(
                          margin: EdgeInsets.all(0),
                          height: 40,
                          width: 180,
                          child: FloatingActionButton(
                            isExtended: true,
                            backgroundColor: Colors.blueAccent.shade700,
                            child: Commands.isDone
                                ? Transform.scale(
                                    scale: 0.6,
                                    child: CircularProgressIndicator(
                                        backgroundColor: Colors.white))
                                : Text("Save"),
                            onPressed: () async {
                              setState(() {
                                Commands.isDone = true;
                              });
                              await Save();
                              setState(() {
                                Commands.isDone = false;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),

                  //: Container()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
