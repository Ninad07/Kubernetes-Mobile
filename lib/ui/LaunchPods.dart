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

    StartContainer() async {
      setState(() {
        launchLoading = true;
      });
      if (Commands.validation == "passed") {
        Commands.result = await serverCredentials.client.connect();

        if (Commands.name != null && Commands.image != null) {
          if (Commands.deleteAlways == false) {
            if (Commands.restartAlways == false) {
              if (Commands.port != null) {
                if (Commands.env.length != 0) {
                  if (Commands.selectedVol != null) {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} --network ${Commands.selectedNet} $environment ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} $environment ${Commands.image}");
                    }
                  } else {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} --network ${Commands.selectedNet} $environment ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port}  $environment ${Commands.image}");
                    }
                  }
                } else {
                  if (Commands.selectedVol == null) {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} --network ${Commands.selectedNet} ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} ${Commands.image}");
                    }
                  } else {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} --network ${Commands.selectedNet} ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} ${Commands.image}");
                    }
                  }
                }
              }

              //HERE
              else {
                print("PASSED 1");
                if (Commands.env.length != 0) {
                  if (Commands.selectedVol == null) {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} --network ${Commands.selectedNet} $environment ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} $environment ${Commands.image}");
                    }
                  } else {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} --network ${Commands.selectedNet} $environment ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} $environment ${Commands.image}");
                    }
                  }
                } else {
                  print("PASSED 2");
                  if (Commands.selectedVol == null) {
                    print("PASSED 3");
                    //THIS***********************
                    if (Commands.selectedNet != null) {
                      print("PASSED 4");
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} --network ${Commands.selectedNet} ${Commands.image}");
                      print("NETWORK RESULT = ${Commands.result}");
                    }
                    //END***************************************
                    else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} ${Commands.image}");
                    }
                  } else {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} --network ${Commands.selectedNet} ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} ${Commands.image}");
                    }
                  }
                }
              }
            } else {
              if (Commands.port != null) {
                if (Commands.env.length != 0) {
                  if (Commands.selectedVol != null) {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} --network ${Commands.selectedNet} $environment --restart always ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} $environment --restart always ${Commands.image}");
                    }
                  } else {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} --network ${Commands.selectedNet} $environment --restart always ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port}  $environment --restart always ${Commands.image}");
                    }
                  }
                } else {
                  if (Commands.selectedVol == null) {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} --network ${Commands.selectedNet} --restart always ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} --restart always ${Commands.image}");
                    }
                  } else {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} --network ${Commands.selectedNet} --restart always ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} --restart always ${Commands.image}");
                    }
                  }
                }
              }

              //HERE
              else {
                print("PASSED 1");
                if (Commands.env.length != 0) {
                  if (Commands.selectedVol == null) {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} --network ${Commands.selectedNet} $environment --restart always ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} $environment --restart always ${Commands.image}");
                    }
                  } else {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} --network ${Commands.selectedNet} $environment --restart always ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} $environment --restart always ${Commands.image}");
                    }
                  }
                } else {
                  print("PASSED 2");
                  if (Commands.selectedVol == null) {
                    print("PASSED 3");
                    //THIS***********************
                    if (Commands.selectedNet != null) {
                      print("PASSED 4");
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} --network ${Commands.selectedNet} --restart always ${Commands.image}");
                      print("NETWORK RESULT = ${Commands.result}");
                    }
                    //END***************************************
                    else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} --restart always ${Commands.image}");
                    }
                  } else {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} --network ${Commands.selectedNet} --restart always ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} --restart always ${Commands.image}");
                    }
                  }
                }
              }
            }
          }
          //FALSE TILL HERE

          else {
            if (Commands.restartAlways == false) {
              if (Commands.port != null) {
                if (Commands.env.length != 0) {
                  if (Commands.selectedVol != null) {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} --network ${Commands.selectedNet} $environment --rm ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} $environment --rm ${Commands.image}");
                    }
                  } else {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} --network ${Commands.selectedNet} $environment --rm ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port}  $environment --rm ${Commands.image}");
                    }
                  }
                } else {
                  if (Commands.selectedVol == null) {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} --network ${Commands.selectedNet} --rm ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} --rm ${Commands.image}");
                    }
                  } else {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} --network ${Commands.selectedNet} --rm ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -p ${Commands.port} -v ${Commands.selectedVol} --rm ${Commands.image}");
                    }
                  }
                }
              }

              //HERE
              else {
                print("PASSED 1");
                if (Commands.env.length != 0) {
                  if (Commands.selectedVol == null) {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} --network ${Commands.selectedNet} $environment --rm ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} $environment --rm ${Commands.image}");
                    }
                  } else {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} --network ${Commands.selectedNet} $environment --rm ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} $environment --rm ${Commands.image}");
                    }
                  }
                } else {
                  print("PASSED 2");
                  if (Commands.selectedVol == null) {
                    print("PASSED 3");
                    //THIS***********************
                    if (Commands.selectedNet != null) {
                      print("PASSED 4");
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} --network ${Commands.selectedNet} --rm ${Commands.image}");
                      print("NETWORK RESULT = ${Commands.result}");
                    }
                    //END***************************************
                    else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} ${Commands.image}");
                    }
                  } else {
                    if (Commands.selectedNet != null) {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} --network ${Commands.selectedNet} --rm ${Commands.image}");
                    } else {
                      Commands.result = await serverCredentials.client.execute(
                          "sudo docker run -dit --name ${Commands.name} -v ${Commands.selectedVol} --rm ${Commands.image}");
                    }
                  }
                }
              }
            }
          }

          print("NETWORK RESULT = ${Commands.result}");
          if (Commands.result == "") {
            AppToast("${Commands.name} : Failed to launch the container");
          } else {
            print("RESULT = ${Commands.result}");
            AppToast("Container Launched");
          }
        } else {
          AppToast("No input provided");
        }
      } else {
        print("RESULT = ${Commands.result}");
        AppToast("Server not connected");
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
                      height: 40,
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
                            height: 35,
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
                                  hintText: "Container",
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
                      height: 40,
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
                            height: 35,
                            width: 245,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(left: 20, right: 10),
                            child: DropdownSearch(
                              popupBackgroundColor: Colors.white,
                              mode: Mode.MENU,
                              showSelectedItem: true,
                              items: Commands.demo1,
                              onChanged: (value) {
                                setState(() {
                                  var newValue = value.split("");
                                  newValue.removeLast();

                                  print(
                                      "###VALUE LENGTH = ${newValue.join().length}#####");
                                  //dir = value;
                                  Commands.image = newValue.join();
                                  print("OPHERE01 = ${Commands.image}");

                                  //print("ABCD = ${items}");
                                });
                              },
                              selectedItem: Commands.image,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
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
                            height: 35,
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
                      height: 40,
                      width: 350,
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            child: Text("Volumes: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            height: 35,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(left: 20, right: 10),
                            child: DropdownSearch(
                              popupBackgroundColor: Colors.white,
                              mode: Mode.MENU,
                              showSelectedItem: false,
                              items: Commands.volumename,
                              onChanged: (value) {
                                Commands.selectedVol = value;
                                setState(() {
                                  VolumeListRet();
                                });
                              },
                              selectedItem: Commands.selectedVol,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 350,
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            child: Text("Network: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            height: 35,
                            width: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(left: 20, right: 10),
                            child: DropdownSearch(
                              popupBackgroundColor: Colors.white,
                              mode: Mode.MENU,
                              showSelectedItem: false,
                              items: Commands.netls,
                              onChanged: (value) {
                                var newValue = value.split("");
                                newValue.removeLast();
                                Commands.selectedNet = newValue.join();
                                print(
                                    "NETWORK HERE = ${Commands.selectedNet.length}");
                                setState(() {
                                  NetListRet();
                                });
                              },
                              selectedItem: Commands.selectedNet,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 20, left: 30),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            child: Text("Env        : ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Column(
                            children: Commands.TextfieldDynamic,
                          ),
                          Column(
                            children: <Widget>[
                              IconButton(
                                iconSize: 30,
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.lightBlue,
                                ),
                                onPressed: DynamicAdd,
                              ),
                              Commands.TextfieldDynamic.length >= 1
                                  ? IconButton(
                                      iconSize: 30,
                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: Colors.lightBlue,
                                      ),
                                      onPressed: DynamicRemove,
                                    )
                                  : SizedBox(),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(children: <Widget>[
                      Container(
                        child: Row(children: <Widget>[
                          SizedBox(
                            width: 15,
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
                          width: 15,
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
                            onPressed: StartContainer,
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
      height: 35,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(left: 20, right: 0, top: 10),
      child: TextField(
        controller: _value,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Environment Variables",
            hintStyle: TextStyle(color: Colors.grey),
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
