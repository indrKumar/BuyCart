import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/utils.dart';

class Contacts_Us extends StatefulWidget {
  const Contacts_Us({super.key});
  static String id = "contact";

  @override
  State<Contacts_Us> createState() => _Contacts_UsState();
}

class _Contacts_UsState extends State<Contacts_Us> {
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Contact Us",
          style: Utils.text20,
        ),
        centerTitle: false,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            )),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Contact Us",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 3,),
              Text("We are available on whatssapp as well",style: TextStyle(fontSize: 12),),
              SizedBox(height: 10,),



          Container(
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all()
              ),
              child:  Center(

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            ImageIcon(AssetImage("assets/whatsapp.png")),
                            SizedBox(
                              width: 10,
                            ),
                            Text("9889362783"),
                          ],),
                          Icon(Icons.arrow_forward_ios),]),
                  ))
          ),
            ]),
          ),
          SizedBox(height: 20,),
          Divider(thickness: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 5,),
              Text("Email",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 3,),
              Text("Please write to us at:",style: TextStyle(fontSize: 12),),
              SizedBox(height: 10,),

              Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all()
                ),
                child:  Center(

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(Icons.email_outlined) ,
                              SizedBox(
                                width: 10,
                              ),
                              Text("hello.uae@stylishopgmail.com"),
                            ],),
                 Icon(Icons.arrow_forward_ios),]),
                    ))



              )]),
          ),
        ],
      ),
    );
  }
}
