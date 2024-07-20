import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/utils.dart';
import '../auth_Screen/login_sendotp_screen.dart';
import '../mainactivity.dart';

class SplashScreen extends StatefulWidget {
  static String id = "splash ";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), ()  async{
      sharedPreferences = await SharedPreferences.getInstance();
      if(sharedPreferences.getBool(Constants.SP_ISLOGIN) ?? false){
       Constants.accessToken = sharedPreferences.getString(Constants.SP_ACCESS_TOKEN) ?? "";
        log("Access Toke :: ${Constants.accessToken}");
        Navigator.pushReplacementNamed(context, MainActivity_page.id);
      }
      else {
        Navigator.pushReplacementNamed(context, Login_SendOtp_page.id);
      }
    }
    );
     return Scaffold(
       body: Container(
         decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/splash.png"),fit: BoxFit.cover)),
       ),
     );

  }
}
