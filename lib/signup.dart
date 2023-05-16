import 'package:flutter/material.dart';
import 'package:flutter_test_march17/dbhelper.dart';
import 'package:flutter_test_march17/home.dart';
import 'package:flutter_test_march17/signin.dart';
import 'package:sqflite/sqflite.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({Key? key}) : super(key: key);

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {

  Database? db;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                  child: Text("SIGN UP",style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 50,),
                TextField(
                  controller: username,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),hintText: "Username"
                  ),
                ),
                SizedBox(height: 10,),
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
                    String usernamee = username.text;
                    String emaill = email.text;
                    String passwordd = password.text;

                    if(usernamee.isNotEmpty && emaill.isNotEmpty && passwordd.isNotEmpty){
                      dbhelper().insertdata(usernamee,emaill,passwordd,db!);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Completed")));
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return Signinpage();
                      },));
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("field is empty")));
                    }
                  }, child: Text("Sign up")),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return Signinpage();
                    },));
                  }, child: Text("Sign in")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
