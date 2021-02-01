import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:KubernetesMobile/DockerLaunch.dart';
import 'package:KubernetesMobile/FrontEnd.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'Pods.dart';

class CopyFiles extends StatefulWidget {
  @override
  _CopyFilesState createState() => _CopyFilesState();
}

class _CopyFilesState extends State<CopyFiles> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Pod_Info(s: "pods");
    Path();
  }

  bool isloading1 = false;
  String dir = " ";
  int l = 1, y = 0;

  List<String> container;
  List<String> container2 = ["/"];

  KubeCopy() async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();
      //if (result== 'Session connected'){
      if (container2 != null &&
          Commands.contName != null &&
          Commands.loc2 != null) {
        var nolast = Commands.contName.split("").toList();
        //nolast.removeLast();
        var newName = nolast.join();
        print("NOLAST = ${newName.length}");

        Commands.result = await serverCredentials.client.execute(
            "kubectl cp ${container2.join()} ${newName}:${Commands.loc2}");

        print("kubectl cp ${container2.join()} ${newName}:${Commands.loc2}");
        print("CP COMMAND = ${Commands.result}");

        if (Commands.result == "") {
          AppToast("Copy Successful");
        } else {
          AppToast("Cannot copy inside the Pod");
        }
      } else {
        AppToast("No input Provided");
      }
    } else {
      print("RESULT = ${Commands.result}");
      AppToast("Server not connected");
    }
  }

  var result2;

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

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blueAccent.shade700);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    var items = [''];
    setState(() => {items.add('${Commands.name}')});
    //items.join('${Commands.name}');

    var body = Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.blueAccent.shade700),
      child: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 5, left: 0, right: 35),
                alignment: Alignment.center,
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'images/kubernetes.png',
                  height: 190,
                  width: 290,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 217,
                margin: EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent.shade700,
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(top: 25),
                      child: Center(
                        child: Text(
                          "Copy Files",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Column(children: <Widget>[
                      Container(
                        height: 40,
                        width: 350,
                        margin: EdgeInsets.only(top: 25, left: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 85,
                              child: Text("Base Location   : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(
                                      FlutterIcons.arrow_circle_left_faw5s,
                                      color: Colors.blueAccent.shade700,
                                      size: 27,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        container2.removeLast();
                                        container2.removeLast();

                                        Fun();
                                      });
                                    }),
                                Container(
                                  height: 45,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(left: 0, right: 10),
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
                            )
                          ],
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 25),
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
                      Container(
                        height: 40,
                        width: 350,
                        margin: EdgeInsets.only(
                          top: 25,
                          left: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 85,
                              child: Text("Container  : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 45,
                              width: 230,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: DropdownSearch(
                                popupBackgroundColor: Colors.white,
                                mode: Mode.MENU,
                                //showSelectedItem: true,
                                items: Commands.res,
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
                        height: 40,
                        width: 350,
                        margin: EdgeInsets.only(
                          top: 25,
                          left: 20,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 85,
                              child: Text("Location  : ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: 45,
                              width: 230,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Location inside container",
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                onChanged: (value) => {Commands.loc2 = value},
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
                          height: 50,
                          width: 180,
                          child: FloatingActionButton(
                            isExtended: true,
                            backgroundColor: Colors.blueAccent.shade700,
                            child: Text("Copy"),
                            onPressed: KubeCopy,
                          ),
                        ),
                      )
                    ])
                  ],
                )),
              ),
            ],
          ),
        ),
      ]),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueAccent.shade700,
          title: Text("Copy Files"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
        ),
        body: body,
      ),
    );
  }
}
