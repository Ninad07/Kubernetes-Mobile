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
  kubeExec() async {
    if (Commands.validation == "passed") {
      Commands.result = serverCredentials.client.connect();

      if (Commands.name != null &&
          Commands.command != null &&
          Commands.contName != null) {
        Commands.result = serverCredentials.client.execute(
            "kubectl exec ${Commands.contName}/${Commands.name} -- ${Commands.command} ");
      } else {
        AppToast("Cannot execute");
      }
    } else {
      AppToast("Server not connected");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Ret("active");
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
        Column(
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
                  children: [
                    Container(
                      height: 40,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent.shade400,
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(top: 25),
                      child: Center(
                        child: Text(
                          "Execute Command",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 350,
                          margin: EdgeInsets.only(top: 20, left: 15),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 85,
                                child: Text(
                                  "Pod   : ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
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
                            left: 15,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 85,
                                child: Text(
                                  "Command  : ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
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
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                "Execute",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: kubeExec,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Center(
                        child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: Container(
                        height: 250,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.grey.shade700, width: 1)),
                        child: SingleChildScrollView(
                          child: Center(
                              child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Commands.execop != null
                                      ? Text("${Commands.execop}")
                                      : Text(""))),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueAccent.shade700,
          title: Text("Execute Command"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
        ),
        body: body,
      ),
    );
  }
}
