import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:KubernetesMobile/DockerLaunch.dart';
import 'package:KubernetesMobile/FrontEnd.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class Execute extends StatefulWidget {
  @override
  _ExecuteState createState() => _ExecuteState();
}

class _ExecuteState extends State<Execute> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Ret("active");
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    var items = [''];
    setState(() => {items.add('${Commands.name}')});
    //items.join('${Commands.name}');

    var body = Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/b2.png'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 200,
                      child: Image.asset('images/dock.png'),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 13, right: 13, top: 15),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/04.png"),
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
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 350,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.only(top: 15),
                            child: Center(
                              child: Text(
                                "Execute Command",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Column(children: <Widget>[
                            Container(
                              height: 40,
                              width: 350,
                              margin: EdgeInsets.only(top: 20, left: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 85,
                                    child: Text(
                                      "Name   : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin:
                                        EdgeInsets.only(left: 20, right: 10),
                                    child: DropdownSearch(
                                      popupBackgroundColor: Colors.white,
                                      mode: Mode.MENU,
                                      showSelectedItem: true,
                                      items: Commands.getCont,
                                      onChanged: (value) {
                                        setState(() {
                                          //dir = value;
                                          Commands.name = value;

                                          //print("ABCD = ${items}");
                                        });
                                      },
                                      selectedItem: Commands.name,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 350,
                              margin: EdgeInsets.only(
                                top: 20,
                                left: 20,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 85,
                                    child: Text(
                                      "Command  : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin:
                                        EdgeInsets.only(left: 20, right: 10),
                                    child: TextField(
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: "command",
                                          hintStyle: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))),
                                      onChanged: (value) =>
                                          {Commands.command = value},
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
                                  child: Text("Execute"),
                                  onPressed: () async {
                                    ExecuteContainer(("${Commands.name}"),
                                        ("${Commands.command}"));
                                  },
                                ),
                              ),
                            )
                          ])
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Execute Command"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(contextCapture.context)}),
        ),
        body: body,
      ),
    );
  }
}
