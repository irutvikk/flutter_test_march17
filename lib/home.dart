import 'package:flutter/material.dart';
import 'package:flutter_test_march17/Signup.dart';
import 'package:flutter_test_march17/Splashscreen.dart';
import 'package:flutter_test_march17/adduserdata.dart';
import 'package:flutter_test_march17/dbhelper.dart';
import 'package:sqflite/sqflite.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Database? db;
  List<Map> userdata = [];
  bool isadmin=false;
  int? userid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     setState(() {
       userid = Splashscreenpage.prefs!.getInt('id')??0;
       isadmin = Splashscreenpage.prefs!.getBool('isadmin')??false;
     });
     Callingdatabase();
  }
  Callingdatabase(){
    dbhelper().getdatabase().then((value) {
      setState(() {
        db = value;
        if(isadmin){
          dbhelper().viewalluserdata(db!).then((value) {
            setState(() {
              userdata = value;
            });
          });
        }
        else{
          dbhelper().viewuserdata(userid!,db!).then((value) {
            setState(() {
              userdata = value;
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isadmin ? null : IconButton(
        padding: EdgeInsets.only(right: 20,bottom: 20),
        iconSize: 60,
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return Adduserdatapage();
          },));
        }, icon: Container(decoration: BoxDecoration(color: Colors.blue,shape: BoxShape.circle),child: Icon(Icons.add,color: Colors.white,),),),
      appBar: AppBar(
        title: Text(isadmin?"Home (Admin)" : "Home"),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                Splashscreenpage.prefs!.setBool('loginstatus', false);
                if(isadmin){
                  Splashscreenpage.prefs!.setBool('isadmin', false);
                }
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return Signuppage();
                },));
              });
            },
            child: Icon(Icons.logout),
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: ListView.builder(
        itemCount: userdata.length,
        itemBuilder: (context, index) {
        return Card(
          color: isadmin?null:userdata.length==index+1 ? Colors.green:null,
          elevation: 4,
          child: Container(
            margin: EdgeInsets.all(10),
            height: 110,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(child: Text("User ID : ${userdata[index]['userid']}",style: TextStyle(fontSize: 16,),),),
                    Expanded(child: Text("Total Leaves : ${userdata[index]['totalleaves']}",style: TextStyle(fontSize: 16),),),
                  ],
                ),
                Divider(color: Colors.black54,),
                Row(
                  children: [
                    Expanded(child: Text("Leave Start : ${userdata[index]['leavestartdate']}",style: TextStyle(fontSize: 16),)),
                    Expanded(child: Text("Leave End : ${userdata[index]['leaveenddate']}",style: TextStyle(fontSize: 16),)),
                  ],
                ),
                Divider(color: Colors.black54,),
                Row(
                  children: [
                    Expanded(child: Text("Start day: ${userdata[index]['startweekday']}",style: TextStyle(fontSize: 16),)),
                    Expanded(child: Text("End day : ${userdata[index]['endweekday']}",style: TextStyle(fontSize: 16),)),
                  ],
                ),
              ],
            ),
          ),
        );
      },),
    );
  }
}
