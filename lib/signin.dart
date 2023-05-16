import 'package:flutter/material.dart';
import 'package:flutter_test_march17/Signup.dart';
import 'package:flutter_test_march17/Splashscreen.dart';
import 'package:flutter_test_march17/dbhelper.dart';
import 'package:flutter_test_march17/home.dart';
import 'package:sqflite/sqflite.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({Key? key}) : super(key: key);

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  Database? db;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbhelper().getdatabase().then((value) {
      setState(() {
        db = value;
      });
    });
  }
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 50,),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Text("SIGN IN",style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 50,),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),hintText: "Email"
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),hintText: "Password"
                  ),
                ),
                SizedBox(height: 50,),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(onPressed: () {
                    String emaill=email.text;
                    String passwordd=password.text;

                    if(emaill=="rutvik@email.com" && passwordd =="rutvik"){
                      setState(() {
                        Splashscreenpage.prefs!.setBool('isadmin', true);
                      });

                    }
                    if(emaill.isNotEmpty && passwordd.isNotEmpty){
                      dbhelper().selectdata(emaill,passwordd,db!).then((value){
                        bool islogin = value.length==1;
                        if(islogin){
                          print("==========${value[0]['ID']}");
                          Splashscreenpage.prefs!.setBool('loginstatus', true);
                          Splashscreenpage.prefs!.setInt('id', value[0]['ID']);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign in Successfully")));
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return Homepage();
                          },));
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("some error")));
                        }
                      });
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("some error")));
                    }
                  }, child: Text("Sign in")),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return Signuppage();
                    },));
                  }, child: Text("Sign up")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
