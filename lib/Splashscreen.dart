import 'package:flutter/material.dart';
import 'package:flutter_test_march17/Signup.dart';
import 'package:flutter_test_march17/home.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreenpage extends StatefulWidget {
  static SharedPreferences? prefs;
  const Splashscreenpage({Key? key}) : super(key: key);

  @override
  State<Splashscreenpage> createState() => _SplashscreenpageState();
}

class _SplashscreenpageState extends State<Splashscreenpage> {
  bool loginstatus=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      forsharepref();
    });
  }
forsharepref() async {
  Splashscreenpage.prefs = await SharedPreferences.getInstance();
  loginstatus = Splashscreenpage.prefs!.getBool('loginstatus')??false;

  if(loginstatus){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Homepage();
    },));
  }
  else{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Signuppage();
    },));
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: 100,
            width: 100,
            child: Lottie.asset('Animation/splashlottianimation.json')),
      ),
    );
  }
}
