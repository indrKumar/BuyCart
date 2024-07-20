import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vFASHU/screens/all_pages/notification_details.dart';

class Notification_Page extends StatefulWidget {
  const Notification_Page({super.key});

  static String id = "notifications";

  @override
  State<Notification_Page> createState() => _Notification_PageState();
}

class _Notification_PageState extends State<Notification_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
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
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, NotificationDetails.id);
              },
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "There are many variations of Lore.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text("10 min ago"),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Image(
                        image: AssetImage("assets/girl.png"),
                        height: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          "Dear user, As you are already aware, we have approached in the final stretch this year and We firmly acknowledge your...  ",
                          style:
                              TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    // indent: 16,
                    // endIndent: 20,
                    thickness: 2,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
