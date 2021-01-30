import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../DockerLaunch.dart';

class Config extends StatefulWidget {
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configInfo();
  }

  setContext() async {
    if (Commands.validation == "passed") {
      Commands.result = await serverCredentials.client.connect();
      Commands.result = await serverCredentials.client
          .execute("kubectl config set-context ${Commands.name}  ");
      if (Commands.result == "")
        AppToast("Cannot switch context");
      else
        AppToast("Context Set");
    } else
      AppToast("Server not connected");
  }

  @override
  Widget build(BuildContext context) {
    var body = Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 10),
              alignment: Alignment.center,
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'images/kubernetes.png',
                height: 190,
                width: 290,
              ),
            ),
            Container(
              child: Text(
                "configuration",
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    letterSpacing: 2.9),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Text(
                      "Current-Context",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child: Text(
                      ":",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Text(
                      "${Commands.context.split('\n')[0]}",
                      style: TextStyle(
                          color: Colors.blueAccent.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height / 2.6,
              width: MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.width / 7,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 2.6,
                width: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width / 7,
                margin: EdgeInsets.all(15),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.all(15),
                      child: Text("${Commands.config}")),
                ),
              ),
            )
          ],
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: body,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => {Navigator.pop(context)}),
          actions: [
            IconButton(
                icon: Icon(
                  FlutterIcons.settings_mdi,
                  color: Colors.black,
                ),
                onPressed: () {
                  showAnimatedDialog(
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(seconds: 1),
                      barrierDismissible: true,
                      animationType: DialogTransitionType.slideFromTop,
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
                                  height: 200,
                                  width: 320,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 0, left: 0),
                                            child: Center(
                                              child: Text(
                                                "Set another Context",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 27,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Container(
                                                  height: 35,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                      color: Colors.lightBlue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        hintText:
                                                            "context-name",
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10)))),
                                                    onChanged: (value) =>
                                                        {Commands.name = value},
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            margin: EdgeInsets.all(25),
                                            child: Container(
                                              margin: EdgeInsets.all(0),
                                              height: 40,
                                              width: 180,
                                              child: FloatingActionButton(
                                                isExtended: true,
                                                backgroundColor:
                                                    Colors.blueAccent.shade700,
                                                child: Commands.isDone
                                                    ? Transform.scale(
                                                        scale: 0.6,
                                                        child:
                                                            CircularProgressIndicator(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white))
                                                    : Text("Set"),
                                                onPressed: () async {
                                                  setState(() {
                                                    Commands.isDone = true;
                                                  });
                                                  await setContext();
                                                  await configInfo();

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
                      });
                })
          ],
        ),
      ),
    );
  }
}
