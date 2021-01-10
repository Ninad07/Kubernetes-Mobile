import 'package:KubernetesMobile/Server/Network.dart';
import 'package:KubernetesMobile/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../DockerLaunch.dart';
import '../FrontEnd.dart';

class Scale extends StatefulWidget {
  @override
  _ScaleState createState() => _ScaleState();
}

class _ScaleState extends State<Scale> {
  @override
  Widget build(BuildContext context) {
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
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  width: 320,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent.shade700,
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.only(top: 25, right: 20),
                  child: Center(
                    child: Text(
                      "Scale",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Column(children: <Widget>[
                  Container(
                    height: 40,
                    width: 350,
                    margin: EdgeInsets.only(top: 25, left: 20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 85,
                          child: Text("Base Location   : ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  FlutterIcons.arrow_circle_left_faw5s,
                                  color: Colors.blueAccent.shade700,
                                  size: 27,
                                ),
                                onPressed: () {
                                  setState(() {});
                                }),
                            Container(
                              height: 45,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 0, right: 10),
                              /*child: DropdownSearch(
                                maxHeight: 280,
                                showSearchBox: true,
                                searchBoxDecoration: InputDecoration(
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                  suffixIcon: Icon(Icons.search),
                                ),
                                popupBackgroundColor: Colors.white,
                                mode: Mode.MENU,
                                showSelectedItem: true,
                                items: Commands.dir,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                selectedItem: null,
                              ),*/
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 25),
                    elevation: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        color: Colors.grey.shade100,
                      ),
                      //margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            "  ",
                            style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 350,
                    margin: EdgeInsets.only(
                      top: 25,
                      left: 20,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 85,
                          child: Text("Container  : ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
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
                                Commands.contName = value;
                                print("OPHERE01 = ${Commands.contName}");

                                //print("ABCD = ${items}");
                              });
                            },
                            selectedItem: Commands.contName,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 350,
                    margin: EdgeInsets.only(
                      top: 25,
                      left: 20,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 85,
                          child: Text("Location  : ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
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
                                hintText: "Location inside container",
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            onChanged: (value) => {Commands.loc2 = value},
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
                        backgroundColor: Colors.blueAccent.shade700,
                        child: Text("Copy"),
                        onPressed: null,
                      ),
                    ),
                  )
                ])
              ],
            )),
          )
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
            "Scale Resources",
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
