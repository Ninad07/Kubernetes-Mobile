import 'package:KubernetesMobile/Server/Network.dart';
import 'package:KubernetesMobile/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:flutter/material.dart';

import 'package:KubernetesMobile/DockerLaunch.dart';
import 'package:KubernetesMobile/FrontEnd.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class DockerImages extends StatefulWidget {
  @override
  _DockerImagesState createState() => _DockerImagesState();
}

class _DockerImagesState extends State<DockerImages> {
  bool isloading = false;
  bool isloading3 = false;

  @override
  void initState() {
    super.initState();
    Retrive();
  }

  DeleteImage(cont) async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();
      if (Commands.result == "session_connected") {
        print("Connected");

        List<String> container = cont.split("");
        container = container.toList();
        container.removeLast();
        print("NOW = ${container.join()}");
        Commands.result = await serverCredentials.client
            .execute("sudo docker rmi -f ${container.join()}");
      }
      if (Commands.result == "") {
        AppToast("Cannot Delete Image");
      } else {
        AppToast("Image Deleted");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  ImageInspect(cont) async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();
      if (Commands.result == "session_connected") {
        if (cont != null) {
          List<String> container = cont.split("");
          container = container.toList();
          container.removeLast();
          print(container.join());

          Commands.result = await serverCredentials.client
              .execute("sudo docker image inspect ${container.join()}");
          Commands.containerInspect = Commands.result;
        }
        if (Commands.result == "") {
          AppToast("Inspection failed");
        } else {
          AppToast("Inspecting Image");
        }
      } else {
        AppToast("Cannot inspect Image");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  Display() {
    if (Commands.validation == "passed") {
      int count = Commands.demo1.length - 1;
      //print("LENGTH INIT = ${Commands.demo.length}");
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          //ShrinkWrappingViewport: true,
          itemCount: count,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: ListTile(
                leading: Icon(
                  Icons.laptop_windows,
                  color: Colors.lightBlue,
                ),
                title: Text(
                  '${Commands.demo1[index]}',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Inspect',
                  color: Colors.blue.shade600,
                  icon: Icons.search,
                  onTap: () async {
                    await ImageInspect("${Commands.demo1[index]}");
                    FlutterStatusbarcolor.setStatusBarColor(
                        Colors.blue.shade700);
                    FlutterStatusbarcolor.setNavigationBarColor(
                        Colors.blue.shade700);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MaterialApp(
                        theme: ThemeData.dark(),
                        debugShowCheckedModeBanner: false,
                        home: Scaffold(
                            appBar: AppBar(
                              backgroundColor: Colors.blue.shade700,
                              title: Text("Image Inspect"),
                              leading: IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () async {
                                    await FlutterStatusbarcolor
                                        .setStatusBarColor(Colors.blue);
                                    await FlutterStatusbarcolor
                                        .setNavigationBarWhiteForeground(false);
                                    await FlutterStatusbarcolor
                                        .setNavigationBarColor(
                                            Colors.grey.shade200);
                                    await FlutterStatusbarcolor
                                        .setStatusBarWhiteForeground(true);
                                    Navigator.pop(context);
                                  }),
                            ),
                            body: SingleChildScrollView(
                              child: Text(Commands.containerInspect),
                            )),
                      );
                    }));
                  },
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => {
                    DeleteImage(Commands.demo1[index]),
                    setState(
                      () {
                        Retrive();
                      },
                    )
                  },
                ),
              ],
            );
          });
    } else {
      AppToast("Server not connected");
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.grey.shade200);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    DeleteImageState() {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 200,
                width: 200,
                child: Image.asset('images/dock.png'),
              ),
              Container(
                height: 40,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(top: 1),
                child: Center(
                  child: Text(
                    "Available Images",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Display()
            ])
          ],
        ),
      );
    }

    var body = DeleteImageState();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: isloading3
                ? Transform.scale(
                    scale: 0.6,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ))
                : Icon(
                    Icons.refresh,
                    size: 30,
                  ),
            onPressed: () async {
              setState(() {
                isloading3 = true;
              });
              await Retrive();
              setState(() {
                print(result1);
                Commands.stateChanger = Display();
                body = DeleteImageState();
              });
              setState(() {
                isloading3 = false;
              });
            },
          ),
        ],
        backgroundColor: Colors.blue,
        title: Text("Available Images"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context)}),
      ),
      body: body,
    );
  }
}
