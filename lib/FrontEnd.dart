import 'package:KubernetesMobile/Server/AWS.dart';
import 'package:KubernetesMobile/Server/BareMetal.dart';
import 'package:KubernetesMobile/ui/Commit.dart';
import 'package:KubernetesMobile/ui/DeletePage.dart';
import 'package:KubernetesMobile/ui/DockerBuild.dart';
import 'package:KubernetesMobile/ui/ExecPage.dart';
import 'package:KubernetesMobile/ui/PullPage.dart';
import 'package:bmnav/bmnav.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file/file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'DockerLaunch.dart';
import 'package:KubernetesMobile/ui/DockerCopy.dart';
import 'package:KubernetesMobile/ui/LaunchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:KubernetesMobile/ui/DockerImages.dart';
import 'package:KubernetesMobile/ui/DockerFileWrite.dart';
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
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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
      case PageEnum.containers:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => ContainerDelete()));
        break;
      case PageEnum.images:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => DockerImages()));
        break;
      default:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => DockerImages()));
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
                        top: 40,
                        left: MediaQuery.of(context).size.width / 2 - 140),
                    child: Row(
                      children: <Widget>[
                        Container(
                          //margin: EdgeInsets.only(left: 20),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  scale: 40,
                                  image: AssetImage("images/kube1.png"))),
                        ),
                        Text(
                          'Kubernetes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                elevation: 0,
                centerTitle: true,
                /*title: Container(
                  
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                scale: 35,
                                image: AssetImage("images/kube1.png"))),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Kubernetes'),
                    ],
                  ),
                ),*/
                backgroundColor: Colors.blueAccent.shade700,
                /*bottom: TabBar(
                      indicatorWeight: 0.001,
                      indicatorColor: Colors.blue.shade600,
                      labelColor: Colors.white,
                      tabs: [
                        Tab(
                          icon: Icon(Icons.home),
                          //text: "Login",
                        ),
                        Tab(
                          icon: Icon(Icons.device_hub),
                          //text: " Docker Hub",
                        ),
                      ]),*/
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.desktop_windows),
                      onPressed: () {
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
                                                        child: Text("Install"),
                                                        onPressed: () {
                                                          KubectlInstall();
                                                        },
                                                      ),
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
                      }),
                  PopupMenuButton<PageEnum>(
                    //icon: Icon(Icons.desktop_windows),
                    onSelected: _onSelect,
                    itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
                      PopupMenuItem<PageEnum>(
                        value: PageEnum.containers,
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
                              "Active Containers",
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem<PageEnum>(
                        value: PageEnum.images,
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
                              "Available Images",
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Network();
                  }));
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
            drawer: Drawer(
              elevation: 10,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    curve: Curves.easeInCirc,
                    child: Image(
                      height: 20,
                      width: 20,
                      image: AssetImage('images/kube.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.dock),
                      title: Text('Launch Container'),
                      onTap: () {
                        setState(() {
                          contextCapture.context = context;
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ContainerLaunch();
                        }));
                      }),
                  ListTile(
                    leading: Icon(Icons.file_download),
                    title: Text('Pull Container Image'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ImagePull();
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
                    title: Text('Docker Copy'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Dockercp();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.library_books),
                    title: Text('Build Dockerfile'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DockerFile(); //DockerFile();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Write Dockerfile'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return WriteFile(); //DockerFile();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.copyright),
                    title: Text('Docker Commit'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Commit();
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
                      border: Border.all(color: Colors.grey.shade800, width: 1),
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
                      border: Border.all(color: Colors.grey.shade800, width: 1),
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
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/f2.png"), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 0, top: 25),
            child: Icon(
              Icons.laptop_windows,
              size: 170,
              color: Colors.grey.shade700,
            ),
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
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                isExtended: true,
                backgroundColor: Colors.blueAccent.shade700,
                child: Text("Server Login"),
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
                            },
                          ),

                          backgroundColor: Colors.white,
                        ),
                        body: LoginBody,
                      ),
                    );
                  }));

                  setState(() {
                    newWid = Commands.newWid;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          newWid
        ],
      )),
    );
  }
}

//################################################################################################################//

//################################################################################################################//
class DCHub extends StatefulWidget {
  final String title;
  DCHub({Key key, this.title}) : super(key: key);

  @override
  _DCHubState createState() => _DCHubState();
}

class _DCHubState extends State<DCHub> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blueAccent.shade700);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/d5.png"), fit: BoxFit.fill)),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 75),
              margin: EdgeInsets.only(top: 0),
              child: Wrap(
                children: <Widget>[
                  Text(
                    "Docker",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    "hub",
                    style: TextStyle(
                        color: Colors.lightBlue.shade200,
                        fontWeight: FontWeight.bold,
                        fontSize: 45),
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.only(left: 30, top: 15),
            width: MediaQuery.of(context).size.width - 25,
            child: Text(
              "Dockerhub is the world's easiest way to manage",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 50),
            width: MediaQuery.of(context).size.width - 30,
            child: Text(
              "deliver your team's container applications",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
          ),
          SizedBox(height: 95),
          Container(
            width: 150,
            child: FloatingActionButton(
              elevation: 10,
              backgroundColor: Colors.blueAccent.shade700,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              isExtended: true,
              onPressed: HubLaunch,
              child: Container(
                child: Text("Explore!"),
              ),
            ),
          )
        ],
      )),
    );
  }
}

/*int _currentindex = 1;

enum PageEnum {
  containers,
  images,
  active,
  all,
  lsnet,
  connect,
  volume,
}

class MyApp extends StatefulWidget {
  final String title;
  MyApp({Key key, this.title}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

// ignore: camel_case_types
class contextCapture {
  static var context;
}

Future navigateToSubPage(context) async {
  Navigator.pop(context);
}

class _MyAppState extends State<MyApp> {
  _onSelect(PageEnum value) {
    switch (value) {
      case PageEnum.containers:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => ContainerDelete()));
        break;
      case PageEnum.images:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => DockerImages()));
        break;
      default:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => DockerImages()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      Commands.currentindex = 1;
    });
    print("CURRENT INDEX = ${Commands.currentindex}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 50),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/dock2.png"))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('KubernetesMobile',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                ],
              ),
              backgroundColor: Colors.blue,
              bottom: TabBar(
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.device_hub,
                        color: Colors.white,
                      ),
                    ),
                  ]),
              actions: <Widget>[
                PopupMenuButton<PageEnum>(
                  //icon: Icon(Icons.desktop_windows),
                  onSelected: _onSelect,
                  itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
                    PopupMenuItem<PageEnum>(
                      value: PageEnum.containers,
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
                            "Active Containers",
                          )
                        ],
                      ),
                    ),
                    PopupMenuItem<PageEnum>(
                      value: PageEnum.images,
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
                            "Available Images",
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            body: Container(
              child: TabBarView(children: [
                MyHomePage(),
                DCHub(),
              ]),
            ),
            bottomNavigationBar: BottomNav(
              iconStyle: IconStyle(onSelectSize: 30),
              index: 1,
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
            drawer: Drawer(
              elevation: 10,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Image(
                      image: AssetImage('images/docker.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.dock),
                      title: Text('Launch Container'),
                      onTap: () {
                        setState(() {
                          contextCapture.context = context;
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ContainerLaunch();
                        }));
                      }),
                  ListTile(
                    leading: Icon(Icons.file_download),
                    title: Text('Pull Container Image'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ImagePull();
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
                    title: Text('Docker Copy'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Dockercp();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.library_books),
                    title: Text('Build Dockerfile'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DockerFile(); //DockerFile();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Write Dockerfile'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return WriteFile(); //DockerFile();
                      }));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.copyright),
                    title: Text('Docker Commit'),
                    onTap: () {
                      setState(() {
                        contextCapture.context = context;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Commit();
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.grey.shade200);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }
  var newWid = Container();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.grey.shade200);
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
                      border: Border.all(color: Colors.grey.shade800, width: 1),
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
                          "images/awslogo.png",
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
                                backgroundColor: Colors.lightBlue,
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
                      border: Border.all(color: Colors.grey.shade800, width: 1),
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
                                backgroundColor: Colors.lightBlue,
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
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/f2.png"), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 0, top: 20),
            child: Icon(
              Icons.laptop_windows,
              size: 170,
              color: Colors.grey.shade700,
            ),
          ),
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            margin: EdgeInsets.only(top: 0, left: 30, right: 20, bottom: 20),
            child: Container(
              margin: EdgeInsets.all(0),
              height: 30,
              width: 180,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                isExtended: true,
                backgroundColor: Colors.blue,
                child: Text("Server Login"),
                onPressed: () {
                  FlutterStatusbarcolor.setStatusBarColor(Colors.white);
                  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
                  FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
                  FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                                  Colors.blue);
                              await FlutterStatusbarcolor
                                  .setStatusBarWhiteForeground(true);
                              await FlutterStatusbarcolor.setNavigationBarColor(
                                  Colors.blue);
                              await FlutterStatusbarcolor
                                  .setNavigationBarWhiteForeground(true);
                              navigateToSubPage(context);
                            },
                          ),

                          backgroundColor: Colors.white,
                        ),
                        body: LoginBody,
                      ),
                    );
                  }));

                  setState(() {
                    newWid = Commands.newWid;
                  });
                },
              ),
            ),
          ),
          newWid
        ],
      )),
    );
  }
}

class DCHub extends StatefulWidget {
  final String title;
  DCHub({Key key, this.title}) : super(key: key);

  @override
  _DCHubState createState() => _DCHubState();
}

class _DCHubState extends State<DCHub> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.grey.shade200);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/d5.png"), fit: BoxFit.fill)),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 75),
              margin: EdgeInsets.only(top: 0),
              child: Wrap(
                children: <Widget>[
                  Text(
                    "Docker",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    "hub",
                    style: TextStyle(
                        color: Colors.lightBlue.shade200,
                        fontWeight: FontWeight.bold,
                        fontSize: 45),
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.only(left: 30, top: 15),
            width: MediaQuery.of(context).size.width - 25,
            child: Text(
              "Dockerhub is the world's easiest way to manage",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 50),
            width: MediaQuery.of(context).size.width - 30,
            child: Text(
              "deliver your team's container applications",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
          ),
          SizedBox(height: 95),
          Container(
            width: 150,
            child: FloatingActionButton(
              elevation: 10,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              isExtended: true,
              onPressed: HubLaunch,
              child: Container(
                child: Text("Explore!"),
              ),
            ),
          )
        ],
      )),
    );
  }
}
*/
