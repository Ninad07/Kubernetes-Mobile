import 'dart:core';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ssh/ssh.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:KubernetesMobile/ui/LaunchPage.dart';

class Commands {
  static var pushWidget = Card();
  static var pushValidation;
  static var dir;
  static var uname;
  static var passwd;
  static String name;
  static String contName;
  static String netname;
  static String image;
  static String port;
  static String tag;
  static String version;
  static String command;
  static var newImage;
  static var env = List();
  static var result;
  static var pushresult;
  static bool active;
  static var demo;
  static var netInspect;
  static var containerInspect;
  static var demo1;
  static var netls;
  static var docker;
  static var netls2;
  static var netls3;
  static var netls4;
  static String validation;
  static var widgets = new List<Widget>();
  static var widgets1 = new List<Widget>();
  static var stateChanger;
  static var Repowidgets = new List<Widget>();
  static String del;
  static String loc1;
  static String loc2;
  static String repo;
  static List<DynamicText> TextfieldDynamic = [];
  static List<String> container2 = [];
  static var volumename;
  static var volumedriver;
  static var selectedVol;
  static var currentindex = 1;
  static var getCont = List<String>();
  static var execop;
  static var execresult = Container();
  static var ec2dir;
  static var ec2cont;
  static bool isaws = false;
  static var newWid = Container();
  static var filename;

  static var stat;
  static var ver1;
  static var selectedNet;
  static var restartAlways;
  static var deleteAlways;
  static List<String> path = [];
}

class Docker {
  static var version;
  static var docker;
  static var docker1;
  static var docker2;
  static var docker3;
}

class containerStats {
  static var containerId;
  static var Name;
  static var memusage;
  static var memPerc;
  static var pid;
  static var cpuPerc;
}

class ServerInfo {
  static var info;
  static var vmName;
  static var vmVersion;
  static var vmId;
  static var vmIdLike;
  static var platformId;
  static var cpName;
  static var vmUrl;
  static var result3;
  static var index;
  static var version;
  static var id;
  static var id0;
  static var id1;
  static var id2;
  static var id3;
  static var name;
  static var name1;
  static var name2;
  static var ver;
  static var ver1;
  static var url;
  static var url2;
}

class serverCredentials {
  static String ip;
  static String username;
  static String password;
  static var client;
}

bool retloading = false;

AppToast(String state) {
  Fluttertoast.showToast(
      msg: state,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade100,
      textColor: Colors.black,
      fontSize: 16.0);
}

HubLaunch() async {
  const url =
      "https://hub.docker.com/"; //"https://hub.docker.com/search?q=&type=image";
  if (await canLaunch(url)) {
    await launch(url,
        forceWebView: true, enableDomStorage: true, enableJavaScript: true);
  } else {
    throw 'Could not launch $url';
  }
}

var result1, result2;
Ret(state) async {
  if (state == "active") {
    result1 = await serverCredentials.client
        .execute("sudo docker ps --format {{.Names}}");
    Commands.getCont = await result1.split('\n').toList();
    print("OPHERE = ${Commands.getCont}");
  }
  if (state == "all") {
    result1 = await serverCredentials.client
        .execute("sudo docker ps -a -f 'status=exited' --format {{.Names}}");
  }
  print(result1);
  Commands.demo = await result1.split('\n').toList();
  return "done";
}

Retrive() async {
  var result1, result2;

  if (Commands.validation == "passed") {
    result1 = await serverCredentials.client
        .execute("sudo docker images --format '{{.Repository}}:{{.Tag}}' ");
    print(result1);
    Commands.demo1 = await result1.split('\n').toList();

    print(Commands.demo1.length);
  } else {
    AppToast("Server not connected");
  }
  print(Commands.demo1.toList());
}

NetListRet() async {
  if (Commands.validation == "passed") {
    Commands.result = await serverCredentials.client.connect();
    if (Commands.result == "session_connected") {
      Commands.result = await serverCredentials.client
          .execute("sudo docker network ls --format {{.Name}}");
      Commands.netls = await Commands.result.split('\n').toList();

      Commands.result = await serverCredentials.client
          .execute("sudo docker network ls --format {{.ID}}");
      Commands.netls2 = await Commands.result.split('\n').toList();

      Commands.result = await serverCredentials.client
          .execute("sudo docker network ls --format {{.Driver}}");
      Commands.netls3 = await Commands.result.split('\n').toList();

      Commands.result = await serverCredentials.client
          .execute("sudo docker network ls --format {{.Scope}}");
      Commands.netls4 = await Commands.result.split('\n').toList();
    }
  } else {
    AppToast("Server not connected");
  }
}

VolumeListRet() async {
  if (Commands.validation == "passed") {
    Commands.result = await serverCredentials.client.connect();
    if (Commands.result == "session_connected") {
      Commands.result = await serverCredentials.client
          .execute("sudo docker volume ls --format {{.Name}}");
      if (Commands.result != "") {
        Commands.volumename = await Commands.result.split('\n').toList();
        Commands.volumename.removeLast();
      }

      Commands.result = await serverCredentials.client
          .execute("sudo docker volume ls --format {{.Driver}}");
      if (Commands.result != "") {
        Commands.volumedriver = await Commands.result.split('\n').toList();
      }
    }
  } else {
    AppToast("Server not connected");
  }
}

//#####################################################################################################//
//Server Details//
//#####################################################################################################//
ServerBody() async {
  Commands.result = await serverCredentials.client.connect();

  if (Commands.validation == "passed") {
    Commands.result = await serverCredentials.client.connect();
    if (Commands.result == "session_connected") {
      print("Connected");

      ServerInfo.info = await serverCredentials.client
          .execute("cat /etc/*release* | grep NAME");
      ServerInfo.result3 = ServerInfo.info.split('\n').toList();
      ServerInfo.name = ServerInfo.result3[0].split('\n').toString();
      ServerInfo.name1 = ServerInfo.result3[1].split('\n').toString();
      ServerInfo.name2 = ServerInfo.result3[2].split('\n').toString();
      //print("name=${ServerInfo.name.substring(7, ServerInfo.name.length - 3)}");
      //print("name=${ServerInfo.name1.substring(14, 50)}");

      ServerInfo.vmId = await serverCredentials.client
          .execute("cat /etc/*release* | grep ID");
      ServerInfo.id = ServerInfo.vmId.split('\n').toList();
      ServerInfo.id0 = ServerInfo.id[0].split('\n').toString();
      ServerInfo.id1 = ServerInfo.id[1].split('\n').toString();
      ServerInfo.id2 = ServerInfo.id[2].split('\n').toString();
      ServerInfo.id3 = ServerInfo.id[3].split('\n').toString();
      //print("id=${ServerInfo.id0.substring(5, ServerInfo.id0.length - 3)}");
      /*print("id=${ServerInfo.id1.substring(10, 16)}");
      print("id=${ServerInfo.id2.substring(13, 16)}");
      print("id=${ServerInfo.id3.substring(14, 26)}");*/

      ServerInfo.vmVersion = await serverCredentials.client
          .execute("cat /etc/*release* | grep VERSION");
      ServerInfo.version = ServerInfo.vmVersion.split('\n').toList();
      ServerInfo.ver = ServerInfo.vmVersion.split('\n').toList();
      ServerInfo.ver1 = ServerInfo.ver[0].split('\n').toString();
      //print(
      //   "Version=${ServerInfo.ver1.substring(10, ServerInfo.ver1.length - 3)}");
    }
  } else {
    AppToast("Server not connected");
  }
}

Connect() async {
  var result;
  if (serverCredentials.ip != null &&
      serverCredentials.username != null &&
      serverCredentials.password != null) {
    if (Commands.isaws == true) {
      serverCredentials.client = SSHClient(
          host: serverCredentials.ip,
          port: 22,
          username: serverCredentials.username,
          //passwordOrKey: serverCredentials.password
          passwordOrKey: {
            "privateKey": """${Commands.ec2cont}""",
            "passphrase": "${serverCredentials.password}",
          });
    } else {
      serverCredentials.client = SSHClient(
          host: serverCredentials.ip,
          port: 22,
          username: serverCredentials.username,
          //passwordOrKey: serverCredentials.password
          passwordOrKey: serverCredentials.password);
    }

    result = await serverCredentials.client.connect();

    print(result);
    if (result == "session_connected") {
      Commands.validation = "passed";
      print(Commands.validation);
      print("START");
      await Ret("active");
      print("RET");
      await NetListRet();
      print("NETLSRET");
      await VolumeListRet();
      print("VOLRET");
      await Retrive();
      print("IMGRET");
      //await ServerBody();
      //print("SERVBODY");
      print("END");
      AppToast("Connection Established");
      //Navigator.pop(contextCapture.context);
    }
    if (result == "") {
      AppToast("Connection Failed");
      Commands.validation = "failed";
    }
  } else {
    AppToast("No Credentials Provided");
  }

  print(serverCredentials.ip);
  //print(serverCredentials.port);
  print(serverCredentials.username);
  print(serverCredentials.password);
}

Status() async {
  Commands.result = await serverCredentials.client.connect();

  if (Commands.validation == "passed") {
    Commands.result = await serverCredentials.client.connect();
    if (Commands.result == "session_connected") {
      print("Connected");

      Commands.docker = await serverCredentials.client
          .execute("kubectl version --short=true --client=true");
      Commands.stat = Commands.docker.split('\n').toString();

      //print("Doc:${Commands.stat.substring(1, 24)}");
      //print("Doc1:${Commands.stat.substring(16, Commands.stat.length - 1)}");
      Fluttertoast.showToast(
          msg: "Kubectl ${Commands.stat} is installed in your system",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 100,
          backgroundColor: Colors.lightBlue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  } else {
    Fluttertoast.showToast(
        msg:
            "Docker is not installed in your system please click here to install it.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 10000,
        backgroundColor: Colors.lightBlue,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

KubectlInstall() async {
  if (Commands.validation == "passed") {
    Commands.result = await serverCredentials.client.connect();
    if (Commands.result == "session_connected") {
      print("Connected");

      if (ServerInfo.name.substring(7, ServerInfo.name.length - 3) ==
          "Ubuntu") {
        Docker.docker =
            await serverCredentials.client.execute("sudo apt-get update");
        Docker.docker1 = await serverCredentials.client.execute(
            "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -");
        Docker.docker2 = await serverCredentials.client.execute(
            "sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu (lsb_release -cs) stable -y ' ");
        Docker.docker3 = await serverCredentials.client.execute(
            "sudo apt-get install docker-ce docker-ce-cli containerd.io");
        AppToast(" Installing Docker");
        print("Inst=${Docker.docker}");
        print("Inst=${Docker.docker1}");
        print("Inst=${Docker.docker2}");
        print("Inst=${Docker.docker3}");
      }

      if (ServerInfo.name.substring(7, ServerInfo.name.length - 3) ==
          "Red Hat Enterprise Linux") {
        Docker.docker = await serverCredentials.client.execute(
            "sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo");
        Docker.docker1 = await serverCredentials.client
            .execute("sudo dnf install docker-ce --nobest -y");
        AppToast(" Installing Docker");
        print("Inst=${Docker.docker}");
        print("Inst=${Docker.docker1}");
      }

      if (ServerInfo.name.substring(7, ServerInfo.name.length - 3) ==
          "Amazon Linux") {
        Docker.docker1 = await serverCredentials.client
            .execute("sudo yum install docker -y");
        AppToast(" Installing Docker");
        print("Inst=${Docker.docker}");
      }
    } else {
      AppToast("Docker Installation Failed");
    }
  } else {
    AppToast("Server Not Connected");
  }
}

ExecuteContainer(String container, String command) async {
  if (Commands.validation == "passed") {
    Commands.result = await serverCredentials.client.connect();
    //if (result== 'Session connected'){
    if (Commands.name != null && Commands.command != null) {
      var nolast = Commands.name.split("").toList();
      nolast.removeLast();
      var newName = nolast.join();
      print("NOLAST = ${newName.length}");

      Commands.result = await serverCredentials.client
          .execute("sudo docker exec ${newName} ${Commands.command}");
      // }

      print("RESULT = ${Commands.result}");
      Commands.execop = Commands.result;

      if (Commands.result == "") {
        AppToast("Cannot Execute Command");
      } else {
        AppToast("Command Executed");
        Commands.command = null;
      }
    } else {
      AppToast("No input Provided");
    }
  } else {
    print("RESULT = ${Commands.result}");
    AppToast("Server not connected");
  }
}
