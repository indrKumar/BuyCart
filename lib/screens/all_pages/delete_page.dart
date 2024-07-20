import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widgets/common/buttons.dart';

class Delete_Page extends StatelessWidget {
  const Delete_Page({super.key});
  static String id = "deletepage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: GestureDetector(
        //   onTap: (){
        //     Navigator.pop(context);
        //   },
        //   child: Icon( Icons.arrow_back_ios_new,
        //   ),
        // ),
        centerTitle: false,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "Delete Account",
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Colors.black,
            height: 0,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                Image(
                  // width: 50,
                  // height: 50,
                  image: AssetImage("assets/heart.png"),height: 75,width: 75,
                ),
                SizedBox(height: 30,),
                Text(
                  "Are you sure you want to leave?",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "You have 500 Styli coins and we have a new collection with fresh styli and discount. if it`s us call our costumer care and we can work this out.",style: TextStyle(fontSize: 11),textAlign: TextAlign.justify,),
                SizedBox(
                  height: 25,
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    "If you still wish to delete your account your account please ensure that there are",style: TextStyle(fontSize: 10),textAlign: TextAlign.justify,),
                SizedBox(height: 25,),
                Row(children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: 27,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: const ImageIcon(
                                AssetImage("assets/return-delivery.png"),
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                            Positioned(
                              child: Align(
                                alignment: Alignment.center,
                                child: Transform.rotate(
                                  angle: 135 * 3.1415927 / 180,
                                  child: Container(
                                    height: 60,
                                    width: 2,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 20,),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text("No open order or returns",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                          SizedBox(height: 3,),
                          Text(
                            "This includes order that are being procrssed for delevery of returns aredue",style: TextStyle(fontSize: 12),textAlign: TextAlign.start,),
                        ]),
                  )
                ],),

                SizedBox(height: 10,),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(height: 10,),
                Row(children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: 27,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: const ImageIcon(
                                AssetImage("assets/return-delivery.png"),
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                            Positioned(
                              child: Align(
                                alignment: Alignment.center,
                                child: Transform.rotate(
                                  angle: 135 * 3.1415927 / 180,
                                  child: Container(
                                    height: 60,
                                    width: 2,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 20,),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text("No open order or returns",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                          SizedBox(height: 3,),
                          Text(
                            "This includes order that are being procrssed for delevery of returns are  due",style: TextStyle(fontSize: 12),textAlign: TextAlign.start,),
                        ]),
                  )
                ],),
                SizedBox(height: 10,),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
              ]),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Divider(
              color: Colors.grey,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: LoginButtonWithGradient(
                width: double.infinity,
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF0B7708),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: const Text("DELETE MY ACCOUNT",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
