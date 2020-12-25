import 'package:KubernetesMobile/Server/Network.dart';
import 'package:KubernetesMobile/Server/Volumes.dart';
import 'package:KubernetesMobile/main.dart';
import 'package:bmnav/bmnav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:KubernetesMobile/DockerLaunch.dart';
import 'package:KubernetesMobile/FrontEnd.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class ContainerDelete extends StatefulWidget {
  @override
  _ContainerDeleteState createState() => _ContainerDeleteState();
}

var state = "active";

bool isloading2 = false;
bool isloading = false;
var i;
//List<String> mystr = ['Start', 'Stop'];
//var item1 = 'Start';
//var item2 = 'Stop';

class _ContainerDeleteState extends State<ContainerDelete> {
  //Color _iconColor = Colors.white;
  bool isdone2 = false;
  var isdone = List<bool>();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.grey.shade200);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    var result1;
    for (i = 0; i < Commands.demo.length - 1; i++) {
      isdone.add(false);
    }
    RuntimeStats(cont) async {
      if (Commands.validation == "passed") {
        Commands.result = await serverCredentials.client.connect();

        if (Commands.result == "session_connected") {
          print("Connected");
          List<String> container = cont.split("");
          container = container.toList();
          container.removeLast();
          print(container.join());

          containerStats.containerId = await serverCredentials.client.execute(
              "sudo docker stats ${container.join()} --no-stream --format {{.ID}}");

          containerStats.Name = await serverCredentials.client.execute(
              "sudo docker stats ${container.join()} --no-stream --format {{.Name}}");

          containerStats.pid = await serverCredentials.client.execute(
              "sudo docker stats ${container.join()} --no-stream --format {{.PIDs}}");

          containerStats.memusage = await serverCredentials.client.execute(
              "sudo docker stats ${container.join()} --no-stream --format {{.MemUsage}}");

          containerStats.memPerc = await serverCredentials.client.execute(
              "sudo docker stats ${container.join()} --no-stream --format {{.MemPerc}}");

          containerStats.cpuPerc = await serverCredentials.client.execute(
              "sudo docker stats ${container.join()} --no-stream --format {{.CPUPerc}}");
        }
      } else {
        AppToast("Server not connected");
      }
    }

    GetStats(cont) async {
      setState(() {
        isloading = true;
      });

      await RuntimeStats("$cont");
      setState(() {
        isloading = false;
      });
    }

    DeleteContainer(cont) async {
      if (Commands.validation == "passed") {
        Commands.result = await serverCredentials.client.connect();
        if (Commands.result == "session_connected") {
          print("Connected");

          List<String> container = cont.split("");
          container = container.toList();
          container.removeLast();
          print(container.join());

          Commands.result = await serverCredentials.client
              .execute("sudo docker rm -f ${container.join()}");
        }
        if (Commands.result == "") {
          AppToast("Cannot Delete Container");
        } else {
          AppToast("Container Deleted");
        }
      } else {
        AppToast("Server not connected");
      }
    }

    Start(cont) async {
      if (Commands.validation == "passed") {
        Commands.result = await serverCredentials.client.connect();
        if (Commands.result == "session_connected") {
          print(Commands.result);
          print("Connected");

          List<String> container = cont.split("");
          container = container.toList();
          container.removeLast();
          print(container.join());

          Commands.result = await serverCredentials.client
              .execute("sudo docker start ${container.join()}");

          AppToast("Container Started");
        }
        if (Commands.result == "") {
          AppToast("Cannot Starting Container");
        }
      } else {
        AppToast("Server not connected");
      }
    }

    Stop(cont) async {
      if (Commands.validation == "passed") {
        Commands.result = await serverCredentials.client.connect();
        if (Commands.result == "session_connected") {
          print("Connected");

          List<String> container = cont.split("");
          container = container.toList();
          container.removeLast();
          print(container.join());

          Commands.result = await serverCredentials.client
              .execute("sudo docker stop ${container.join()}");
        }
        if (Commands.result == "") {
          AppToast("Cannot Stoping Container");
        } else {
          AppToast("Container Stopped");
        }
      } else {
        AppToast("Server not connected");
      }
    }

    ContainerInspect(cont) async {
      if (Commands.validation == "passed") {
        Commands.result = await serverCredentials.client.connect();
        if (Commands.result == "session_connected") {
          if (cont != null) {
            List<String> container = cont.split("");
            container = container.toList();
            container.removeLast();
            print(container.join());

            Commands.result = await serverCredentials.client
                .execute("sudo docker inspect ${container.join()}");
            Commands.containerInspect = Commands.result;
          }
          if (Commands.result == "") {
            AppToast("Container has been deleted");
          } else {
            AppToast("Inspecting Container");
          }
        } else {
          AppToast("Cannot inspect Container");
        }
      } else {
        AppToast("Server not connected");
      }
    }

    Display() {
      if (Commands.validation == "passed") {
        int count = Commands.demo.length - 1;
        print("COMM DEMO = ${Commands.demo[0]}");
        //print("LENGTH INIT = ${Commands.demo.length}");
        return ListView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            //separatorBuilder: (context, index) => Divider(),
            shrinkWrap: true,
            children: <Widget>[
              ListView.builder(
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
                          Icons.dock,
                          color: Colors.lightBlue,
                        ),
                        title: Text('${Commands.demo[index]}'),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Inspect',
                          color: Colors.blue,
                          icon: Icons.search,
                          onTap: () async {
                            await ContainerInspect("${Commands.demo[index]}");
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
                                      title: Text("Container Inspect"),
                                      leading: IconButton(
                                          icon: Icon(Icons.arrow_back),
                                          onPressed: () => {
                                                FlutterStatusbarcolor
                                                    .setStatusBarColor(
                                                        Colors.blue),
                                                FlutterStatusbarcolor
                                                    .setNavigationBarColor(
                                                        Colors.blue),
                                                Navigator.pop(context)
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
                          key: UniqueKey(),
                          caption: state == "active" ? 'Stop' : 'Start',
                          color: Colors.blue,
                          icon:
                              state == "active" ? Icons.stop : Icons.play_arrow,
                          onTap: () async {
                            state == "active"
                                ? Stop(Commands.demo[index])
                                : Start(Commands.demo[index]);

                            setState(() {
                              isdone[index] = !isdone[index];
                            });
                          },
                        ),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Stats',
                          color: Colors.black45,
                          icon: Icons.signal_cellular_4_bar,
                          onTap: () async {
                            await GetStats("${Commands.demo[index]}");
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
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
                                              backgroundColor: Colors.lightBlue,
                                              maxRadius: 19,
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed:
                                                      Navigator.of(context)
                                                          .pop),
                                            ),
                                          ),
                                        ),
                                        Form(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 0),
                                                        child: Text(
                                                          "Container ID : ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 20,
                                                            bottom: 0,
                                                            left: 10),
                                                        child: Text(
                                                          containerStats
                                                              .containerId,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 0, bottom: 15),
                                                        child: Text(
                                                          "Name : ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 1,
                                                                  bottom: 0,
                                                                  left: 10),
                                                          child: Text(
                                                            containerStats.Name,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ))
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 0, bottom: 15),
                                                        child: Text(
                                                          "MEM % : ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 1,
                                                            bottom: 0,
                                                            left: 10),
                                                        child: Text(
                                                          containerStats
                                                              .memPerc,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 0, bottom: 15),
                                                        child: Text(
                                                          "MEM Usage : ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 1,
                                                            bottom: 0,
                                                            left: 5),
                                                        child: Text(
                                                          containerStats
                                                              .memusage,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 0, bottom: 10),
                                                        child: Text(
                                                          "CPU % : ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 1,
                                                            bottom: 0,
                                                            left: 10),
                                                        child: Text(
                                                          containerStats
                                                              .cpuPerc,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () async {
                            DeleteContainer(Commands.demo[index]);
                          },
                        ),
                      ],
                    );
                  })
            ]);
      } else {
        AppToast("Server not connected");
        setState(() {
          isloading2 = false;
        });
        return Container();
      }
    }

    Commands.stateChanger = Display();

    RetrieveActiveContainers() async {
      state = "active";
      await Ret(state);
      setState(() {
        Commands.stateChanger = Display();
      });
    }

    RetrieveStoppedContainers() async {
      state = "all";
      await Ret(state);
      setState(() {
        Commands.stateChanger = Display();
      });
    }

    DeleteBodyState() {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 200,
                width: 200,
                child: Image.asset(
                  'images/dock.png',
                ),
              ),
              Container(
                height: 40,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(top: 1),
                child: Center(
                  child: state == "active"
                      ? Text(
                          "Active Containers",
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          "Stopped Containers",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              Commands.stateChanger
            ])
          ],
        ),
      );
    }

    var body = DeleteBodyState();

    _onSelect(PageEnum value) {
      switch (value) {
        case PageEnum.active:
          RetrieveActiveContainers();
          break;
        case PageEnum.all:
          RetrieveStoppedContainers();
          break;

        default:
          RetrieveActiveContainers();
          break;
      }
    }

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
          backgroundColor: Colors.blue,
          title: Text("Active Containers"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => {navigateToSubPage(context)},
          ),
          actions: <Widget>[
            IconButton(
              icon: isloading2
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
                  isloading2 = true;
                });
                await Ret(state);
                setState(() {
                  print(result1);
                  Commands.stateChanger = Display();
                  body = DeleteBodyState();
                });
                setState(() {
                  isloading2 = false;
                });
              },
            ),
            PopupMenuButton<PageEnum>(
              //icon: Icon(Icons.desktop_windows),
              onSelected: _onSelect,
              itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
                PopupMenuItem<PageEnum>(
                  value: PageEnum.active,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.laptop,
                        color: Colors.lightBlue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Running Containers",
                      )
                    ],
                  ),
                ),
                PopupMenuItem<PageEnum>(
                  value: PageEnum.all,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.laptop,
                        color: Colors.lightBlue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Stopped Containers",
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: body,
      ),
    );
  }
}
