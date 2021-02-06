import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'FrontEnd.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:KubernetesMobile/Server/BareMetal.dart';
import 'package:flutter/material.dart';
import 'DockerLaunch.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  var islogged = false;
  var authc = FirebaseAuth.instance;
  // var fsconnect = FirebaseFirestore.instance;
  bool error = false;
  bool error1 = false;
  String username;
  String pass;
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    var AuthBody = Center(
        child: Container(
      alignment: Alignment.topCenter,
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 25, top: 100),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w800,
                      fontSize: 35),
                ),
              ),
            ),
            Container(
              height: 30,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 25, top: 25),
              child: Text(
                "Username",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Container(
              height: 60,
              width: 370,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade700, width: 2)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                  //labelText: "Email or Phone number",
                  hintText: "email or phone number",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  errorText: error ? 'Invalid user' : null,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.grey.shade500,
                    size: 20,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    error = false;
                  });
                  username = value;
                },
              ),
            ),
            Container(
              height: 30,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 25, top: 20),
              child: Text(
                "Password",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Container(
              width: 370,
              height: 60,
              child: TextField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade700, width: 2)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                  hintText: "password",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  errorText: error1 ? 'Invalid password' : null,
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.grey.shade500,
                    size: 20,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    error1 = false;
                  });
                  pass = value;
                },
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                disabledColor: Colors.white,
                child: Text("Forgot password?",
                    style: TextStyle(color: Colors.grey.shade600)),
                onPressed: null,
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              margin: EdgeInsets.all(15),
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 50,
                width: 350,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  isExtended: true,
                  backgroundColor: Colors.blue.shade700,
                  child: islogged
                      ? Transform.scale(
                          scale: 0.6,
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.white))
                      : Text("Login"),
                  onPressed: () async {
                    /*var result2;
                    setState(() {
                      islogged = true;
                    });
                    try {
                      result2 = await authc.signInWithEmailAndPassword(
                          email: username, password: pass);
                    } catch (e) {
                      print(e);
                      setState(
                        () {
                          error1 = true;
                        },
                      );
                    }
                    print(result2);
                    if (result2 != null) {
                      islogged = false;
                      AppToast("Logged in");
                      print('logged in');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Dashboard();
                      }));
                    }*/

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Dashboard();
                    }));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              child: Center(
                child: Text(
                  "Or Login through",
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: Image.asset(
              "images/gfg.jpg",
              height: 50,
              width: 120,
            )),
            SizedBox(
              height: 120,
            ),
            Container(
              child: Center(
                child: Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.grey.shade400),
                ),
              ),
            ),
            Container(
              child: RaisedButton(
                disabledColor: Colors.white,
                color: Colors.white,
                focusColor: Colors.white,
                highlightColor: Colors.white,
                elevation: 0,
                child: Center(
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                            body: Center(
                          child: Container(
                            alignment: Alignment.topCenter,
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 25, top: 100),
                                    child: Center(
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            color: Colors.blue.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 25, top: 25),
                                    child: Text(
                                      "Name",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: 370,
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade700,
                                                width: 2)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200)),
                                        //labelText: "Email or Phone number",
                                        hintText: "full name",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400),
                                        //errorText: error ? 'Invalid user' : null,
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.grey.shade500,
                                          size: 20,
                                        ),
                                      ),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 25, top: 15),
                                    child: Text(
                                      "Phone",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: 370,
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade700,
                                                width: 2)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200)),
                                        //labelText: "Email or Phone number",
                                        hintText: "phone number",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400),
                                        //errorText: error ? 'Invalid user' : null,
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.phone,
                                          color: Colors.grey.shade500,
                                          size: 20,
                                        ),
                                      ),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 25, top: 15),
                                    child: Text(
                                      "Email",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: 370,
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade700,
                                                width: 2)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200)),
                                        //labelText: "Email or Phone number",
                                        hintText: "email",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400),
                                        errorText:
                                            error ? 'Invalid user' : null,
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Colors.grey.shade500,
                                          size: 20,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          error = false;
                                        });
                                        username = value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 25, top: 20),
                                    child: Text(
                                      "Password",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: 370,
                                    height: 60,
                                    child: TextField(
                                      obscureText: true,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade700,
                                                width: 2)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade200)),
                                        hintText: "password",
                                        hintStyle: TextStyle(
                                            color: Colors.grey.shade400),
                                        errorText:
                                            error1 ? 'Invalid password' : null,
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.grey.shade500,
                                          size: 20,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          error1 = false;
                                        });
                                        pass = value;
                                      },
                                    ),
                                  ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    margin: EdgeInsets.all(15),
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 50,
                                      width: 350,
                                      child: FloatingActionButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        isExtended: true,
                                        backgroundColor: Colors.blue.shade700,
                                        child: islogged
                                            ? Transform.scale(
                                                scale: 0.6,
                                                child:
                                                    CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.white))
                                            : Text("Sign up"),
                                        onPressed: () async {
                                          print(username);
                                          print(pass);
                                          var result;
                                          setState(() {
                                            islogged = true;
                                          });
                                          try {
                                            result = await authc
                                                .createUserWithEmailAndPassword(
                                                    email: username,
                                                    password: pass);
                                            // fsconnect.collection("user").add({
                                            // "name": "shreyash",
                                            //"age": 18,
                                            //});
                                          } catch (e) {
                                            print(e);
                                            setState(() {
                                              error = true;
                                            });
                                          }
                                          print(result);
                                          if (result != null) {
                                            print("logged in");
                                            islogged = false;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    child: RaisedButton(
                                      disabledElevation: 0,
                                      elevation: 0,
                                      color: Colors.white,
                                      disabledColor: Colors.white,
                                      hoverColor: Colors.white,
                                      highlightColor: Colors.white,
                                      child: Center(
                                        child: Text(
                                          "Go back to login page",
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));

    return Scaffold(body: AuthBody);
  }
}
