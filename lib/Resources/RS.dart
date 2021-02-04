import 'package:KubernetesMobile/Animation/animation.dart';
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

class ReplicaSet extends StatefulWidget {
  @override
  _ReplicaSetState createState() => _ReplicaSetState();
}

class _ReplicaSetState extends State<ReplicaSet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Path();
    Commands.name = null;
    Commands.isDone = false;
    isdone = false;
    Commands.text = null;
  }

  var isdone = false;

  CreateRS() async {
    if (Commands.validation == "passed") {
      setState(() {
        isdone = true;
      });
      Commands.result = await serverCredentials.client.connect();
      if (Commands.loc1 != null && Commands.name != null) {
        print("${Commands.loc1}/${Commands.name}.yml");

        Commands.result = await serverCredentials.client.execute(
            "kubectl create rs -f ${Commands.loc1}/${Commands.name}.yml");

        print("RS = ${Commands.result}");
        if (Commands.result != "")
          AppToast("RS created Successfully");
        else
          AppToast("Could not create RS");
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
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Column(
                    children: [
                      FadeAnimation(
                        1,
                        Container(
                            margin: EdgeInsets.only(
                                top: 5, bottom: 0, left: 0, right: 80),
                            alignment: Alignment.center,
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Replica",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      FadeAnimation(
                        1.2,
                        Container(
                            margin: EdgeInsets.only(
                                top: 0, bottom: 5, left: 0, right: 90),
                            alignment: Alignment.center,
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Set",
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
                      ),
                    ],
                  ),
                ),
                FadeAnimation(
                  1,
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
                ? Transform.scale(
                    scale: 0.6,
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.white))
                : IconButton(
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: CreateRS),
            SizedBox(width: 15),
          ],
        ),
        body: body,
      ),
    );
  }
}
