import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/common/buttons.dart';
import '../mainactivity.dart';

class Suceesfull_PlacedOredr extends StatefulWidget {
  const Suceesfull_PlacedOredr({Key? key}) : super(key: key);
  static String id ='succes';

  @override
  State<Suceesfull_PlacedOredr> createState() => _Suceesfull_PlacedOredrState();
}

class _Suceesfull_PlacedOredrState extends State<Suceesfull_PlacedOredr> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                      height: 150,
                      width: 150,
                      child: Image(image:AssetImage("assets/imgpsh_fullsize_anim.png"))),
                  SizedBox(height: 25,),
                  Text("Your order is complete!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                  SizedBox(height: 16,),
                  const Center(child: Text("You will be receiving confirmation email with order details.",style: TextStyle(color: Colors.grey,fontSize: 15),textAlign: TextAlign.center,)),

                ],),
              ),
             SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: LoginButtonWithGradient(
                  onTap:() {
                    Navigator.pushNamedAndRemoveUntil(context, MainActivity_page.id, (route) => false);
                  },
                  borderRadius: BorderRadius.circular(5),
height: 45,
                  width: double.infinity,
                  color: Colors.amber,
                  child: const Center(child: Text("CONTINUE SHOPPING",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),),
              )

        ]),
      ),
    );
  }
}
