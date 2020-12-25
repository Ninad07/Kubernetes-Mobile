import 'package:KubernetesMobile/Server/Network.dart';
import 'package:KubernetesMobile/Server/Volumes.dart';
import 'package:bmnav/bmnav.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:KubernetesMobile/DockerLaunch.dart';
import '../FrontEnd.dart';

class WriteFile extends StatefulWidget {
  @override
  _WriteFileState createState() => _WriteFileState();
}

TextEditingController control = TextEditingController();

class MyTextController extends TextEditingController {
  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    List<InlineSpan> children = [];
    if (text.contains(' ')) {
      children.add(TextSpan(
          style: TextStyle(color: Colors.lightBlue),
          text: text.substring(0, text.indexOf(' '))));

      children.add(TextSpan(text: text.substring(text.indexOf(" "))));

      print(text.indexOf(text.substring(text.indexOf(' '))));
    } else {
      children
          .add(TextSpan(style: TextStyle(color: Colors.lightBlue), text: text));
    }
    return TextSpan(style: style, children: children);
  }
}

class _WriteFileState extends State<WriteFile> {
  var data;
  int max = 1;
  bool path2 = false;
  String dir = " ";
  int y = 0, l = 1;
  bool isloading1 = false;

  List<String> container;
  List<String> container2 = ["/"];

  var result2;

  Fun() async {
    if (container2.length == 0) {
      container2.add("/");
    }
    result2 = await serverCredentials.client.execute("ls ${container2.join()}");
    setState(() {
      Commands.dir = result2.split('\n').toList();
    });
  }

  void Path() async {
    setState(() {
      isloading1 = true;
    });

    print('path function called');

    if (Commands.validation == "passed") {
      if (Commands.isaws == true) {
        setState(() {
          dir = Commands.ec2dir;
        });
      }

      if (dir == " ") {
        l--;
      }

      if (l > 2) {
        //container = dir.split("");

        container = dir.split("");
        print("SPLIT = $container");
        container.removeLast();
        print("LAST = ${container.length}");

        if (container.join() != container2.join()) {
          String p = "/";
          if (y == 0) {
            y = 1;
          } else {
            if (container2.length > 1) {
              container2.add(p);
            }
          }
          container2.add(container.join());

          Commands.ec2cont = container2.join();

          result2 =
              await serverCredentials.client.execute("ls ${container2.join()}");
          Commands.dir = await result2.split('\n').toList();
        }
        print("tttt");
      } else if (l == 0) {
        print('ffff');
        result2 = await serverCredentials.client.execute("ls /$dir");
        Commands.dir = await result2.split('\n').toList();
        l = 3;
      }

      print("DIR = ");
      for (var i in Commands.dir) {
        print(i);
      }
    } else {
      AppToast("Server not connected");
    }
    //print(Commands.demo1);
    setState(() {
      isloading1 = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Path();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.blue);
    ScrollController controller = ScrollController();
    var body = SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
                height: 600,
                margin: EdgeInsets.all(27),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 5),
                ),
                width: 380,
                child: DraggableScrollbar.rrect(
                    backgroundColor: Colors.lightBlue,
                    labelTextBuilder: (offset) => Text("${offset.floor()}"),
                    controller: controller,
                    child: ListView(
                      controller: controller,
                      children: <Widget>[
                        TextField(
                          controller: MyTextController(),
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(color: Colors.black),
                          maxLines: null,
                          minLines: 29,
                          decoration: InputDecoration(
                            focusColor: Colors.black,
                            hoverColor: Colors.black,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Write DockerFile Here",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                            ),
                          ),
                          onChanged: (value) {
                            print(value);
                            data = value;
                          },
                        ),
                      ],
                    ))),
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        container2.removeLast();
                        container2.removeLast();

                        Fun();
                      });
                    }),
                Container(
                  height: 35,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(left: 0, right: 10),
                  child: DropdownSearch(
                    maxHeight: 280,
                    showSearchBox: true,
                    searchBoxDecoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                      suffixIcon: Icon(Icons.search),
                    ),
                    popupBackgroundColor: Colors.white,
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    items: Commands.dir,
                    onChanged: (value) {
                      setState(() {
                        dir = value;

                        Path();
                        print("ABCD = ${container2.join()}");
                      });
                    },
                    selectedItem: container2.join(),
                  ),
                ),
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              margin: EdgeInsets.only(top: 0, left: 25, right: 25, bottom: 0),
              child: Container(
                margin: EdgeInsets.all(0),
                height: 50,
                width: 180,
                child: FloatingActionButton(
                  isExtended: true,
                  backgroundColor: Colors.lightBlue,
                  child: Text("Save"),
                  onPressed: () async {
                    serverCredentials.client.connect();
                    Commands.result = await serverCredentials.client
                        .execute('echo $l >> ${container2.join()}/dockerfile');
                    print(Commands.result);
                    print('hii');
                  },
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
        bottomNavigationBar: BottomNav(
          iconStyle: IconStyle(onSelectSize: 30),
          index: Commands.currentindex,
          labelStyle: LabelStyle(showOnSelect: true),
          onTap: (index) {
            if (index == 0) {
              setState(() {
                Commands.currentindex = 0;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Network();
                  },
                ),
              );
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
          backgroundColor: Colors.lightBlue,
          title: Text("Executing Container"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)}),
        ),
        body: body,
      ),
    );
  }
}
