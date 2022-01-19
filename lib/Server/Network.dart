/*import 'package:bmnav/bmnav.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:KubernetesMobile/DockerLaunch.dart';
import 'package:KubernetesMobile/FrontEnd.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'Volumes.dart';

class Network extends StatefulWidget {
  @override
  _NetworkState createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  _onSelect(PageEnum value) {
    switch (value) {
      case PageEnum.connect:
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (BuildContext context) => NetworkList()),
        );
        break;
      default:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => NetworkList()));
        break;
    }
  }

  NetworkCreate() async {
    if (Commands.validation == "passed") {
      if (Commands.protocol != null) {
        Commands.result = await serverCredentials.client.connect();
        if (Commands.result == "session_connected") {
          Commands.result = await serverCredentials.client
              .execute("sudo docker network create ${Commands.protocol}");
          print(Commands.result);
        }
        if (Commands.result == "") {
          AppToast("Cannot create network");
        } else {
          AppToast("Network created");
        }
      } else {
        AppToast("No input provided");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.grey.shade200);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    var body = SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    height: 200,
                    width: 200,
                    child: Transform.scale(
                      scale: 1.8,
                      child: Image.asset(
                        'images/net5.jpg',
                      ),
                    )),
                Container(
                    margin: EdgeInsets.only(left: 13, right: 13),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/card1.png"),
                            fit: BoxFit.cover),
                        border:
                            Border.all(color: Colors.grey.shade800, width: 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(15, 15),
                          bottomLeft: Radius.elliptical(15, 15),
                          topRight: Radius.elliptical(15, 15),
                          bottomRight: Radius.elliptical(15, 15),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 15.0,
                          ),
                        ]),
                    child: Column(children: <Widget>[
                      Container(
                        height: 40,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.only(top: 15),
                        child: Center(
                          child: Text(
                            "Create Network",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 350,
                            margin: EdgeInsets.only(top: 20, left: 20),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 85,
                                  child: Text(
                                    "Network   : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(left: 20, right: 10),
                                  child: TextField(
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Name",
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 13),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)))),
                                    onChanged: (value) =>
                                        {Commands.protocol = value},
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
                                backgroundColor: Colors.lightBlue,
                                child: Text("Create"),
                                onPressed: () async {
                                  NetworkCreate();
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    ]))
              ],
            ),
          ),
        ],
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNav(
          iconStyle: IconStyle(onSelectSize: 30),
          index: 0,
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
          title: Text("Docker Networks"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
          actions: <Widget>[
            PopupMenuButton<PageEnum>(
              icon: Icon(Icons.cloud_queue),
              //icon: Icon(Icons.desktop_windows),
              onSelected: _onSelect,
              itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
                PopupMenuItem<PageEnum>(
                  value: PageEnum.containers,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.network_cell, color: Colors.grey.shade700),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "List Network",
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

//List Networks Class
class NetworkList extends StatefulWidget {
  @override
  _NetworkListState createState() => _NetworkListState();
}

class _NetworkListState extends State<NetworkList> {
  static NetworkDelete(net) async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();
      if (Commands.result == "session_connected") {
        if (net != "bridge" || net != "host" || net != "none") {
          List<String> network = net.split("");
          network = network.toList();
          network.removeLast();
          print(network.join());

          Commands.result = await serverCredentials.client
              .execute("sudo docker network rm ${network.join()}");
        }
        if (Commands.result == "") {
          AppToast("Cannot Delete Network");
        } else {
          AppToast("Network Removed");
        }
      } else {
        AppToast("Cannot Delete Pre-defined Networks");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  static NetworkInspect(netname) async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();
      if (Commands.result == "session_connected") {
        if (netname != null) {
          List<String> network = netname.split("");
          network = network.toList();
          network.removeLast();
          print(network.join());

          Commands.result = await serverCredentials.client
              .execute("sudo docker network inspect ${network.join()}");
          Commands.netInspect = Commands.result;
        }
        if (Commands.result == "") {
          AppToast("Unknown Network");
        } else {
          AppToast("Inspecting Network");
        }
      } else {
        AppToast("Cannot inspect Network");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.grey.shade200);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    ConnectContainerToNetwork(cont, netname) async {
      Commands.result = await serverCredentials.client.connect();
      if (Commands.result == "session_connected") {
        if (cont != null && netname != null) {
          List<String> network = netname.split("");
          network = network.toList();
          network.removeLast();
          print(network.join());

          List<String> containerName = cont.split("");
          containerName = containerName.toList();
          containerName.removeLast();
          print(containerName.join());

          Commands.result = await serverCredentials.client.execute(
              "sudo docker network connect ${network.join()} ${containerName.join()}");

          print("CONNECTED? = ${Commands.result}");
        }
        if (Commands.result == "") {
          AppToast("Connected");
        } else {
          AppToast("Unknown Container");
        }
      } else {
        AppToast("Cannot connect to the Network");
      }
    }

    Display() {
      if (Commands.validation == "passed") {
        int count = Commands.netls.length - 1;
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
                    return Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: 250,
                        width: 350,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 300,
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    '${Commands.netls[index]}',
                                    style: TextStyle(
                                        color: Colors.lightBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  child: Transform.scale(
                                      scale: 1.3,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.grey.shade500,
                                        ),
                                        onPressed: () async {
                                          NetworkDelete(
                                              "${Commands.netls[index]}");
                                        },
                                      )),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Network ID  :  ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "",
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Driver  :  ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "",
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "Scope  :  ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "",
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text("Connect Container  : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  height: 35,
                                  width: 180,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(left: 20, right: 10),
                                  child: DropdownSearch(
                                    popupBackgroundColor: Colors.white,
                                    mode: Mode.MENU,
                                    showSelectedItem: true,
                                    items: Commands.getCont,
                                    onChanged: (value) async {
                                      setState(() {
                                        //dir = value;
                                        Commands.contName = value;

                                        print(
                                            "OPHERE01 = ${Commands.contName}");

                                        //print("ABCD = ${items}");
                                      });
                                      await ConnectContainerToNetwork(
                                          "${Commands.contName}",
                                          "${Commands.netls[index]}");
                                    },
                                    selectedItem: Commands.contName,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              alignment: Alignment.topLeft,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  height: 25,
                                  width: 130,
                                  child: FloatingActionButton(
                                    heroTag: index,
                                    isExtended: true,
                                    backgroundColor: Colors.lightBlue,
                                    child: Wrap(
                                      children: <Widget>[
                                        Text("Inspect"),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    onPressed: () async {
                                      await NetworkInspect(
                                          "${Commands.netls[index]}");
                                      FlutterStatusbarcolor.setStatusBarColor(
                                          Colors.blue.shade700);
                                      FlutterStatusbarcolor
                                          .setNavigationBarColor(
                                              Colors.blue.shade700);
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return MaterialApp(
                                          theme: ThemeData.dark(),
                                          debugShowCheckedModeBanner: false,
                                          home: Scaffold(
                                              appBar: AppBar(
                                                backgroundColor:
                                                    Colors.blue.shade700,
                                                title: Text("Network Inspect"),
                                                leading: IconButton(
                                                    icon:
                                                        Icon(Icons.arrow_back),
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
                                                child: Text(Commands.result),
                                              )),
                                        );
                                      }));
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ));
                  })
            ]);
      } else {
        AppToast("Server not connected");
        return Container();
      }
    }

    var statelist = Display();

    ScaffoldBodyState() {
      return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/f2.png"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Center(
              child: Column(children: <Widget>[
            Container(
                alignment: Alignment.center,
                height: 200,
                width: 200,
                child: Transform.scale(
                  scale: 1.8,
                  child: Image.asset(
                    'images/net5.jpg',
                  ),
                )),
            Container(
              height: 40,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(top: 1),
              child: Center(
                child: Text(
                  "Available Networks",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            statelist
          ]))
        ])),
      );
    }

    var listNetworks = ScaffoldBodyState();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Available Networks"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
          actions: <Widget>[
            IconButton(
                icon: loading
                    ? Transform.scale(
                        scale: 0.6,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : Icon(
                        Icons.refresh,
                        size: 30,
                      ),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });

                  setState(() {
                    statelist = Display();
                    listNetworks = ScaffoldBodyState();
                  });
                  setState(() {
                    loading = false;
                  });
                })
          ],
        ),
        body: listNetworks,
      ),
    );
  }
}
*/
