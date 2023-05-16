import 'package:flutter/material.dart';
import 'package:flutter_test_march17/Splashscreen.dart';
import 'package:flutter_test_march17/dbhelper.dart';
import 'package:sqflite/sqflite.dart';

import 'home.dart';

class Adduserdatapage extends StatefulWidget {
  const Adduserdatapage({Key? key}) : super(key: key);

  @override
  State<Adduserdatapage> createState() => _AdduserdatapageState();
}

class _AdduserdatapageState extends State<Adduserdatapage> {
  Database? db;
  String endweekday="";
  String startweekday="";
  int userid=0;
  List weekday=['nullmonth','monday','tuesday','wednesday','thursday','friday','saturaday','sunday'];
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
  int? sd;
  int? sm;
  int? sy;

  int? ed;
  int? em;
  int? ey;


  TextEditingController leavestart = TextEditingController();
  TextEditingController leaveend = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add data")),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextField(
                  controller: leavestart, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Leave Starting Date" //label text of field
                  ),
                  readOnly: true,  // when true user cannot edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate:DateTime.now(), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101)
                    );
                    var datee = DateTime.parse("$pickedDate");
                    var formattedDate = "${datee.day}-${datee.month}-${datee.year}";
                    setState(() {
                      sd=datee.day;
                      sm=datee.month;
                      sy=datee.year;
                      leavestart.text = formattedDate;
                      var a=datee.weekday;
                      startweekday=weekday[a];
                    });
                  }
              ),
              SizedBox(height: 10,),
              TextField(
                  controller: leaveend, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Leave Ending Date" //label text of field
                  ),
                  readOnly: true,  // when true user cannot edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate:DateTime.now(), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101)
                    );
                    var datee = DateTime.parse("$pickedDate");
                    var formattedDate = "${datee.day}-${datee.month}-${datee.year}";
                    setState(() {
                      ed=datee.day;
                      em=datee.month;
                      ey=datee.year;
                      leaveend.text = formattedDate;
                      var b=datee.weekday;
                      endweekday=weekday[b];
                    });
                  }
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () {

                final start = DateTime(sy as int, sm as int, sd as int);
                final end = DateTime(ey as int, em as int, ed as int);

                var difference = daysBetween(start, end);

                difference = difference+1;
                print("===${leavestart.text}===");
                print("===${leaveend.text}====");
                print("=====$difference======");

                  // String diff=difference as String;
                  String leavestartingdate = "${leavestart.text}";
                  String leaveendingdate = "${leaveend.text}";
                  int totalleaves = difference;

                int userid = Splashscreenpage.prefs!.getInt('id')??0;

                dbhelper().insertuserdata(leavestartingdate,leaveendingdate,totalleaves,startweekday,endweekday,userid,db!).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data Inserted")));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return Homepage();
                  },));
                });
              }, child: Text("Add data"))

            ],
          ),
        ),
      ),
    );
  }
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}