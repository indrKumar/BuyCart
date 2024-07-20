import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/utils.dart';
import '../../widgets/common/textformfield.dart';

class Help_Center_page extends StatefulWidget {
  const Help_Center_page({super.key});
  static String id = "help center";

  @override
  State<Help_Center_page> createState() => _Help_Center_pageState();
}

class _Help_Center_pageState extends State<Help_Center_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        // leading: GestureDetector(
        //   onTap: (){
        //     Navigator.pop(context);
        //   },
        //   child: Icon( Icons.arrow_back_ios_new,
        //   ),
        // ),
        title: Text(
          "Help Center",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "How can we help you today?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 30,
          ),
          const SizedBox(height: 50,
            child: MyFormTextField(
              hintText: "Enter your search term here...",
              textAlign: TextAlign.start,
              suffixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Most popular questions",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),

                SizedBox(height: 20,),
                BulletListItem(
                bullet: Icon(Icons.circle, color: Colors.black,size: 12,),
        child: Text(
            "How can i place a return request in STYLI?",
            style: TextStyle(fontSize: 12),
        ),
      ),
                SizedBox(height: 15,),

                BulletListItem(
                bullet: Icon(Icons.circle, color: Colors.black,size: 12,),
        child: Text(
            "When do i get my refund after returning an item?",
            style: TextStyle(fontSize: 12),
        ),
      ),               SizedBox(height: 15,),

                BulletListItem(
                bullet: Icon(Icons.circle, color: Colors.black,size: 12,),
        child: Text(
            "Can i get a product size/color replaced?",
            style: TextStyle(fontSize: 12),
        ),
      ),              SizedBox(height: 15,),
                BulletListItem(
                bullet: Icon(Icons.circle, color: Colors.black,size: 12,),
        child: Text(
            "How can i track my order?",
            style: TextStyle(fontSize: 12),
        ),
      ),              SizedBox(height: 15,),
                BulletListItem(
                bullet: Icon(Icons.circle, color: Colors.black,size: 12,),
        child: Text(
            "How can i cancel my order?",
            style: TextStyle(fontSize: 12),
        ),
      ),              SizedBox(height: 15,),
                BulletListItem(
                bullet: Icon(Icons.circle, color: Colors.black,size: 12,),
        child: Text(
            "Contact Us",
            style: TextStyle(fontSize: 12),
        ),
      ),
               ],
            ),
          )
        ]),
      ),
    );
  }
}

class BulletListItem extends StatelessWidget {
  final Widget bullet;
  final Widget child;

  const BulletListItem({
    required this.bullet,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2), // Adjust the top padding value
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2, right: 8), // Adjust the top padding value
            child: bullet,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
