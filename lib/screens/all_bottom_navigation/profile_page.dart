import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vFASHU/screens/all_pages/reviews.dart';
import 'package:vFASHU/widgets/card_profile.dart';

import '../../utils/apis.dart';
import '../all_pages/contact_us.dart';
import '../all_pages/help_center.dart';
import '../all_pages/my_acoount/my_account.dart';
import '../all_pages/my_order.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({super.key});

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  Map<String, dynamic> _costumerDetails = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiServisces().addList().then((value) {
      setState(() {
        _costumerDetails = value;
      });
      print(_costumerDetails);
    });
  }
  // final controller = StreamController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: Colors.black, size: 25),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: SizedBox(
              height: 30,
              child: ImageIcon(
                AssetImage("assets/profile.png"),
              )),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(25),
          child: Divider(
            color: Colors.grey.shade300,
            height: 2,
            thickness: 3,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(
            right: 5,
            top: 20,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              "Hello, INDER"
              // "${_costumerDetails["firstname"].toString()}"
              "",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              "View & edit your profile",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
            ),
            trailing: const ImageIcon(
              AssetImage("assets/right-arrow.png"),
              size: 35,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pushNamed(context, My_Account_Page.id);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            card(),
            const SizedBox(
              height: 20,
            ),
             Divider(
              color: Colors.grey.shade300,
              height: 2,
              thickness:6,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, My_Order_page.id);
                    },
                    child: const Column(
                      children: [
                        ImageIcon(
                          AssetImage(
                            "assets/order.png",
                          ),
                          size: 18,
                          color: Colors.black,
                        ),
                        Text(
                          "My Orders",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 18,
                      ),
                      Text(
                        "My Wishlist",
                        style:
                            TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      ImageIcon(
                        AssetImage(
                          "assets/order.png",
                        ),
                        size: 18,
                        color: Colors.black,
                      ),
                      Text(
                        "Offers",
                        style:
                            TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey.shade300,
              height: 2,
              thickness:6,
            ),
            // ListTile(
            //   contentPadding: const EdgeInsets.only(right: 5),
            //   leading: const Padding(
            //     padding: EdgeInsets.only(left: 4),
            //     child: ImageIcon(
            //       AssetImage("assets/help.png"),
            //       size: 20,
            //       color: Colors.black,
            //     ),
            //   ),
            //   title: const Text(
            //     "Help Center",
            //     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            //   ),
            //   trailing: const Icon(
            //     Icons.arrow_forward_ios_rounded,
            //     size: 20,
            //     color: Colors.grey,
            //   ),
            //   onTap: () {
            //     Navigator.pushNamed(context, Help_Center_page.id);
            //   },
            // ),
            ListTile(
              contentPadding: const EdgeInsets.only(right: 5),
              leading: const Padding(
                padding: EdgeInsets.only(left: 4),
                child: ImageIcon(
                  AssetImage("assets/help.png"),
                  size: 20,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                "Invite Friends",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.pushNamed(context, Help_Center_page.id);
              },
            ),
            const Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(right: 5),
              leading: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: ImageIcon(
                  AssetImage("assets/thumbs-up.png"),
                  size: 12,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                "Review VfashU",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewsPage(),));
              },
            ),
            const Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(right: 5),
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: ImageIcon(
                  AssetImage("assets/call.png"),
                  size: 18,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                "Contact Us",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.pushNamed(context, Contacts_Us.id);
              },
            ),
            const Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(right: 5),
              leading: const Padding(
                padding: EdgeInsets.only(left: 4),
                child: ImageIcon(
                  AssetImage("assets/help.png"),
                  size: 20,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                "Measurement Details",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.pushNamed(context, Help_Center_page.id);
              },
            ),
            const Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            ),

            const SizedBox(
              height: 40,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/instagram.png"),
                  height: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Image(
                  image: AssetImage("assets/tiktok.png"),
                  height: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Image(
                  image: AssetImage("assets/youtube.png"),
                  height: 30,
                )
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            const Text(
              "Privacy Policy",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "App Version 3.9.3 (726)",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "VAT #328289382449323 ",
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.blue.shade900,
                      decoration: TextDecoration.underline),
                ),
                Container(
                  height: 12,
                  width: 1,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    " CR #328289 ",
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.blue.shade900,
                        decoration: TextDecoration.underline),
                  ),
                ),
                Container(
                  height: 12,
                  width: 1,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Text(
                    "SFDA #3282893",
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.blue.shade900,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "@2020 Retail World Limited. All right reserved",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }
}
