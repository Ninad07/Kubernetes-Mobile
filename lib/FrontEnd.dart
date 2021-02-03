import 'package:KubernetesMobile/Resources/PV-PVC.dart';
import 'package:KubernetesMobile/Server/AWS.dart';
import 'package:KubernetesMobile/Server/BareMetal.dart';
import 'package:KubernetesMobile/ui/Config.dart';
import 'package:KubernetesMobile/ui/CopyPage.dart';
import 'package:KubernetesMobile/ui/ExecPage.dart';
import 'package:KubernetesMobile/ui/Expose.dart';
import 'package:KubernetesMobile/ui/KubeResources.dart';
import 'package:KubernetesMobile/ui/Pods.dart';
import 'package:KubernetesMobile/ui/Rollouts.dart';
import 'package:KubernetesMobile/ui/ScaleResources.dart';
import 'package:KubernetesMobile/ui/Secrets.dart';
import 'package:bmnav/bmnav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'DockerLaunch.dart';

import 'package:KubernetesMobile/ui/LaunchPods.dart';
import 'package:flutter/cupertino.dart';

import 'Server/Network.dart';
import 'Server/Volumes.dart';

int _currentindex = 1;

enum PageEnum {
  containers,
  images,
  active,
  all,
  lsnet,
  connect,
  volume,
  save,
  run,
  pods,
  replicaset,
  deployments,
  namespace,
  services,
  rc,
  pv,
  pvc,
  nodes,
  secret,
}

class Dashboard extends StatefulWidget {
  final String title;
  Dashboard({Key key, this.title}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

// ignore: camel_case_types
class contextCapture {
  static var context;
}

Future navigateToSubPage(context) async {
  Navigator.pop(context);
}

class _DashboardState extends State<Dashboard> {
  Future<bool> _onbackpressed() {
    return showAnimatedDialog(
        curve: Curves.fastOutSlowIn,
        duration: Duration(seconds: 1),
        barrierDismissible: true,
        animationType: DialogTransitionType.scale,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Are you sure ?'),
            content: Text('You will be exiting the app'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    //   Navigator.of(context).pop(true);
                    SystemNavigator.pop();
                  },
                  child: Text('Yes')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No')),
            ],
          );
        });
  }

  _onSelect(PageEnum value) {
    switch (value) {
      case PageEnum.pods:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Pod_Info(
                  s: "pods",
                )));
        break;

      case PageEnum.deployments:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Pod_Info(
                  s: "deployments",
                )));
        break;

      case PageEnum.rc:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Pod_Info(
                  s: "rc",
                )));
        break;

      case PageEnum.pv:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Pod_Info(
                  s: "pv",
                )));
        break;

      case PageEnum.pvc:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Pod_Info(
                  s: "pvc",
                )));
        break;

      case PageEnum.services:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Pod_Info(
                  s: "services",
                )));
        break;

      case PageEnum.replicaset:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Pod_Info(
                  s: "rs",
                )));
        break;

      case PageEnum.namespace:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Pod_Info(
                  s: "namespace",
                )));
        break;

      case PageEnum.nodes:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Pod_Info(
                  s: "nodes",
                )));
        break;

      case PageEnum.secret:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => Pod_Info(
                  s: "secret",
                )
            // ContainerDelete()
            ));
        break;

      default:
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (BuildContext context) => null));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blueAccent.shade700);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    setState(() {
      Commands.currentindex = 1;
    });
    print("CURRENT INDEX = ${Commands.currentindex}");
    return WillPopScope(
      onWillPop: _onbackpressed,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(130),
              child: AppBar(
                flexibleSpace: Container(
                  height: 450,
                  width: 250,
                  color: Colors.blueAccent.shade700,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 50,
                        left: MediaQuery.of(context).size.width / 2 - 135),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 1,
                        ),
                        Center(
                          child: Container(
                            //margin: EdgeInsets.only(left: 20),
                            height: 80,
                            width: 70,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    scale: 40,
                                    image: AssetImage("images/kube1.png"))),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Text(
                            'Kubernetes',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),

                    /*Row(
                      children: <Widget>[
                        Container(
                          //margin: EdgeInsets.only(left: 20),
                          height: 80,
                          width: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  scale: 45,
                                  image: AssetImage("images/kube1.png"))),
                        ),
                        Text(
                          'Kubernetes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),*/
                  ),
                ),
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.blueAccent.shade700,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.desktop_windows),
                      onPressed: () {
                        showAnimatedDialog(
                            curve: Curves.fastOutSlowIn,
                            duration: Duration(seconds: 1),
                            barrierDismissible: true,
                            animationType: DialogTransitionType.scale,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
                                          backgroundColor:
                                              Colors.blueAccent.shade700,
                                          maxRadius: 19,
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                              onPressed:
                                                  Navigator.of(context).pop),
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
                                                        top: 0, left: 25),
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "images/kube1.png"))),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 0, left: 5),
                                                    child: Center(
                                                      child: Text(
                                                        "Install Kubectl",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                    margin: EdgeInsets.all(25),
                                                    child: Container(
                                                      margin: EdgeInsets.all(0),
                                                      height: 40,
                                                      width: 180,
                                                      child:
                                                          FloatingActionButton(
                                                        isExtended: true,
                                                        backgroundColor: Colors
                                                            .blueAccent
                                                            .shade700,
                                                        child: Commands.isDone
                                                            ? Transform.scale(
                                                                scale: 0.6,
                                                                child: CircularProgressIndicator(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white))
                                                            : Text("Install"),
                                                        onPressed: () async {
                                                          setState(() {
                                                            Commands.isDone =
                                                                true;
                                                          });
                                                          KubectlInstall();
                                                          setState(() {
                                                            Commands.isDone =
                                                                false;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),

                                          //: Container()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }),
                  PopupMenuButton<PageEnum>(
                    //icon: Icon(Icons.desktop_windows),
                    onSelected: _onSelect,
                    itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
                      PopupMenuItem<PageEnum>(
                        value: PageEnum.pods,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.laptop,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "PODS",
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem<PageEnum>(
                        value: PageEnum.deployments,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.laptop,
                              color: Colors.grey.shade900,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              " Deployments",
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem<PageEnum>(
                        value: PageEnum.rc,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.laptop,
                              color: Colors.grey.shade900,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Replication controllers",
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem<PageEnum>(
                        value: PageEnum.pv,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.laptop,
                              color: Colors.grey.shade900,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Physical volumes",
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem<PageEnum>(
                        value: PageEnum.pvc,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.laptop,
                              color: Colors.grey.shade900,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Physical volume claims",
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem<PageEnum>(
                        value: PageEnum.services,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.laptop,
                              color: Colors.grey.shade900,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Services",
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem<PageEnum>(
                        value: PageEnum.replicaset,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.laptop,
                              color: Colors.grey.shade900,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Replicaset",
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem<PageEnum>(
                        value: PageEnum.namespace,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.laptop,
                              color: Colors.grey.shade900,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              " Namespaces",
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem<PageEnum>(
                        value: PageEnum.nodes,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.laptop,
                              color: Colors.grey.shade900,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Nodes",
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem<PageEnum>(
                        value: PageEnum.secret,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.security,
                              color: Colors.grey.shade900,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Secrets",
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Container(
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                    color: Colors.blueAccent.shade700,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35))),
                    margin: EdgeInsets.only(top: 0),
                    child: MyHomePage(),
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomNav(
              iconStyle: IconStyle(
                  onSelectSize: 30, onSelectColor: Colors.blueAccent.shade700),
              index: 1,
              labelStyle: LabelStyle(
                  showOnSelect: true,
                  onSelectTextStyle: TextStyle(
                    color: Colors.black,
                  )),
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
            drawer: Drawer(
              elevation: 10,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Image(
                      height: 20,
                      width: 20,
                      image: AssetImage('images/kube.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.dock),
                      title: Text('Launch Pods'),
                      onTap: () {
                        setState(() {
                          contextCapture.context = context;
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PodLaunch();
                        }));
                      }),
                  ListTile(
                    leading: Icon(Icons.file_download),
                    title: Text('Create Resources'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ResourcesMain();
                      }));
                    },
                  ),
                  ListTile(
                      leading: Icon(FlutterIcons.web_mco),
                      title: Text('Expose'),
                      onTap: () {
                        setState(() {
                          contextCapture.context = context;
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Expose();
                        }));
                      }),
                  ListTile(
                    leading: Icon(Icons.library_books),
                    title: Text('Manage Rollouts'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Rollout(); //DockerFile();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.device_hub),
                    title: Text('Scale Resources'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Scale(); //DockerFile();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.call_to_action),
                    title: Text('Execute Command'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Execute();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.content_copy),
                    title: Text('Copy Files'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CopyFiles();
                      }));
                    },
                  ),
                  ListTile(
                      leading: Icon(FlutterIcons.pencil_alt_faw5s),
                      title: Text('Create PV/PVC'),
                      onTap: () {
                        setState(() {
                          contextCapture.context = context;
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Storage();
                        }));
                      }),
                  ListTile(
                    leading: Icon(Icons.security),
                    title: Text('Secrets'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Secrets();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.copyright),
                    title: Text('Config'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Config();
                      }));
                    },
                  ),
                ],
              ),
            ),
            drawerEnableOpenDragGesture: true,
          )),
    );
  }
}

//################################################################################################################//
//Server Login//
//################################################################################################################//
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _backgroundImage;
  String _setImage() {
    String _mTitle = "${ServerInfo.name.substring(7, 31)}";

    if (_mTitle == "Red Hat Enterprise Linux") {
      _backgroundImage = "images/redhat.jpg";
    } else if (_mTitle == "Ubuntu") {
      _backgroundImage = "assets/ubuntu.jpg";
    } else if (_mTitle == "Amazon Linux") {
      _backgroundImage = "images/awslogo.png";
    } else if (_mTitle == "") {
      _backgroundImage = 'images/dock.png';
    }
    print("_mTitle: $_mTitle");
    print("_backgroundImage: $_backgroundImage");
    return _backgroundImage; // here it returns your _backgroundImage value
  }

  _MyHomePageState() {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
  }
  var newWid = Container();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    //FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    FlutterStatusbarcolor.setStatusBarColor(Colors.blueAccent.shade700);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    MyHomePage();
    newWid = Commands.newWid;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      contextCapture.context = context;
      //FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      //FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    });

    var LoginBody = SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Center(
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.only(top: 35),
                  elevation: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.grey.shade800, width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(10, 10),
                        bottomLeft: Radius.elliptical(10, 10),
                        topRight: Radius.elliptical(10, 10),
                        bottomRight: Radius.elliptical(10, 10),
                      ),
                    ),
                    width: 300,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "images/aws.png",
                          height: 120,
                          width: 120,
                        ),
                        Container(
                          child: Text(
                            "Amazon EC2 Instance",
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "Connect to any running AWS EC2 instance",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Wrap(
                              children: <Widget>[
                                Text(
                                  "Requirements : ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Public IP, Username, Key Pair, Passphrase",
                                  style: TextStyle(
                                      color: Colors.blue.shade800,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.all(0),
                              height: 25,
                              width: 130,
                              child: FloatingActionButton(
                                heroTag: 1,
                                isExtended: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                                backgroundColor: Colors.blueAccent.shade700,
                                child: Text("Select"),
                                onPressed: () {
                                  setState(() {
                                    Commands.isaws = true;
                                  });
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return AWSEC2();
                                  }));
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  elevation: 8,
                  margin: EdgeInsets.only(top: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.grey.shade800, width: 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(10, 10),
                        bottomLeft: Radius.elliptical(10, 10),
                        topRight: Radius.elliptical(10, 10),
                        bottomRight: Radius.elliptical(10, 10),
                      ),
                    ),
                    width: 300,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.laptop_chromebook,
                          size: 140,
                          color: Colors.grey.shade700,
                        ),
                        Container(
                          child: Text(
                            "Bare metal",
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "Connect to any running Base Operating System or Virtual machine",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          margin: EdgeInsets.only(top: 12),
                          child: Text(
                            "Requirements : ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Host IP, Username, Password",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.all(0),
                              height: 25,
                              width: 130,
                              child: FloatingActionButton(
                                heroTag: 2,
                                isExtended: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                                backgroundColor: Colors.blueAccent.shade700,
                                child: Text("Select"),
                                onPressed: () {
                                  setState(() {
                                    Commands.isaws = false;
                                  });
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return BareMetal();
                                  }));
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              height: 170,
              width: 240,
              margin: EdgeInsets.only(bottom: 0, top: 35),
              child: Image.asset(
                "images/lap01.gif",
                //fit: BoxFit.cover,
                height: 170,
                width: 170,
              )

              /*Icon(
              Icons.laptop_windows,
              size: 170,
              color: Colors.grey.shade700,
            ),*/
              ),
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            margin: EdgeInsets.only(top: 0, left: 30, right: 20, bottom: 20),
            child: Container(
              margin: EdgeInsets.all(0),
              height: 40,
              width: 200,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                isExtended: true,
                backgroundColor: Colors.blueAccent.shade400,
                child: Text(
                  "Server Login",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
                    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
                    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
                    FlutterStatusbarcolor.setNavigationBarWhiteForeground(
                        false);
                    return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      home: Scaffold(
                        appBar: AppBar(
                          elevation: 0,
                          //title: Text("Server"),
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.blueAccent.shade700,
                            ),
                            onPressed: () async {
                              await FlutterStatusbarcolor.setStatusBarColor(
                                  Colors.blueAccent.shade700);
                              await FlutterStatusbarcolor
                                  .setNavigationBarWhiteForeground(false);
                              await FlutterStatusbarcolor.setNavigationBarColor(
                                  Colors.white);
                              await FlutterStatusbarcolor
                                  .setStatusBarWhiteForeground(true);

                              navigateToSubPage(context);
                              setState(() {});
                              print("NEWWID = ${Commands.newWid}");
                            },
                          ),

                          backgroundColor: Colors.white,
                        ),
                        body: LoginBody,
                      ),
                    );
                  }));
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Commands.newWid
        ],
      )),
    );
  }
}

//################################################################################################################//

//################################################################################################################//
