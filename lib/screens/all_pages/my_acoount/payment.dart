import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vFASHU/utils/constant_color.dart';

import '../../../utils/apis.dart';
import '../../../utils/utils.dart';
import '../../../widgets/common/buttons.dart';
import '../help_center.dart';
import '../order_succes_page.dart';
import 'my_address.dart';

class Payment_Page extends StatefulWidget {
  static String id = "payment";
  const Payment_Page({Key? key}) : super(key: key);

  @override
  State<Payment_Page> createState() => _Payment_PageState();
}

class _Payment_PageState extends State<Payment_Page> {
  bool isLoading = false;
  final bool _savePaymentInfo = false;
  final String _paymentType = 'debit';
  String _paymentPlan = 'full';
  Map<String,dynamic> _getTotalDtails = {};
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    // TODO: implement initState
    ApiServisces().estimateShippingMethods().then((value) {
      if (kDebugMode) {
        print("estimated$value");
      }

      if(value!=null){
        ApiServisces().shippingInformation().then((value) {
         if(kDebugMode){
           print("shipping$value");
           print(_getTotalDtails);
           setState(() {
             _getTotalDtails = value["totals"];
             isLoading = false;
           });
         }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        actions: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: InkWell(
               onTap: () {
                 Navigator.pushNamed(context, Help_Center_page.id);
               },
               child: const ImageIcon(AssetImage("assets/help.png"),)),
         )
        ],
        title: const Text(
          "Payment ",
          style: TextStyle(color: Colors.black),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Colors.black,
            height: 0,
          ),
        ),
        elevation: 0,
      ),
      body: isLoading? Constants.loadingIndicator():SingleChildScrollView(
        child: Column(children: [
          Container(height: 30,
          color:Color(0xFFFFF3CD),
            child: const Center(child: Text("Order Now Get it  by  Mon, 10th apr,2023",style: TextStyle(fontSize: 12),)),
          ),
           ListTile(
            onTap: (){
              Navigator.pushNamed(context, My_AddressPage.id);
            },
            leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: ImageIcon(AssetImage("assets/truck (1).png"),size: 25,),
          ),
          title: Text("Arvind, +91 98328723",style: TextStyle(fontSize: 13),),
            subtitle: const Text("hshs,dubai,dubai,united arab emirates",style: TextStyle(fontSize: 12)),
            trailing: Icon(Icons.arrow_forward_ios,size: 20,),
          ),

// Container(
//   decoration: BoxDecoration(),
//   width: double.infinity,
// child: Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 20),
//   child:   Column(
//       children: [
//     Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//        Row(children: [
//          CircleAvatar(radius:9,
//             backgroundColor: Colors.transparent,
//
//            child: Radio<String>(
//              value: 'Debit',
//              groupValue: _paymentType,
//              onChanged: (value) {
//                setState(() {
//                  _paymentType = value!;
//                });
//              },
//            ),
//          ),
//          SizedBox(width: 5,),
//
//          Text('Pay by Debit / Credit Card'),
//        ],),
//         Row(children: [
//           Container(
//               height: 20,width: 20,
//         child: Image(image:AssetImage("assets/visa.png"))),
//           SizedBox(width: 5,),
//           Container(
//               height: 20,
//               width: 20,
//               child: Image(image: AssetImage("assets/mastercard.png"),))
//         ],)
//         ]),
//
//     SizedBox(height: 16.0),
//     Row(children: [
//       Text("Enter Card Information",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
//
//     ],),
//         SizedBox(height: 10),
//
//         MyFormTextField(
//       textInputType: TextInputType.number,
//       textAlign: TextAlign.start,
//       hintText: "Card Number ",
//     ),
//     SizedBox(height: 16.0),
//     Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children:const [
//         Flexible(
//             child:MyFormTextField(
//               textInputType: TextInputType.datetime,
//               textAlign: TextAlign.start,
//               hintText: "Expiry (MM/YY)",)
//         ),
//         SizedBox(width: 16.0),
//         Flexible(
//             child: MyFormTextField(
//               textInputType: TextInputType.number,
//               textAlign: TextAlign.start,
//
//               hintText: "CVV",)
//         ),
//       ],
//     ),
//     SizedBox(height: 10,),
//     Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 20,
//           height: 20,
//           child: Checkbox(
//             value: _savePaymentInfo,
//             onChanged: (value) {
//               setState(() {
//                 _savePaymentInfo = value!;
//               });
//             },
//           ),
//         ),
//         const SizedBox(width: 5,),
//         const Text('Save Now . Pay faster next time '),
//         const SizedBox(
//             height: 20,
//             width: 20,
//             child: Image(image: AssetImage("assets/rocket.png"),))
//       ],
//     ),
//
//
//   ]),
// ),
//
// ),
//           const Divider(
//             // height: 0,
//             thickness: 2,
//           ),
//           const SizedBox(height: 16.0),
//           ListTile(
//             contentPadding: const EdgeInsets.all(5),
//             leading: Radio<String>(
//               value: 'instalment',
//               groupValue: _paymentPlan,
//               onChanged: (value) {
//                 setState(() {
//                   _paymentPlan = value!;
//                 });
//               },
//             ),
//
//             title:const Text("Easy interest-free installments ")
//             ,
//           subtitle: const Text("PAy AED now & rest in 3 easy inetrest-free installments"),
//             trailing:  const ImageIcon(AssetImage("assets/help.png"),)
//             ,
//           ),
//           const Divider(
//             // height: 0,
//             thickness: 2,
//           ),
//           ListTile(
//             contentPadding: EdgeInsets.all(5),
//
//             leading: Radio<String>(
//               value: '4payment',
//               groupValue: _paymentPlan,
//               onChanged: (value) {
//                 setState(() {
//                   _paymentPlan = value!;
//                 });
//               },
//             ),
//
//             title:const Text("ESplit into 4 payments ")
//             ,
//             subtitle: const Text("Pay AED now & the rest over three months"),
//             trailing:  const ImageIcon(AssetImage("assets/help.png"),)
//             ,
//           ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            contentPadding: EdgeInsets.all(5),
            leading: Radio<String>(
              value: 'cash',
              groupValue: _paymentPlan,
              onChanged: (value) {
                setState(() {
                  _paymentPlan = value!;
                });
              },
            ),

            title:const Text("Use Cash on Delevery ")
            ,
            trailing:  const Padding(
              padding: EdgeInsets.all(8.0),
              child: ImageIcon(AssetImage("assets/help.png"),size: 25,),
            )
            ,
          ),
          Divider(thickness: 7,color: Colors.grey.shade300,),
Container(width: double.infinity,
color: Colors.white,
child: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child:   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:  [
    const Text("Sub Total ",style: TextStyle(color: Colors.grey),),
      Text("SAR ${_getTotalDtails["subtotal"].toString()}",style: const TextStyle(fontSize:11, ),)
    ],),
        const SizedBox(height: 3,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
          const Text("Shipping Fee",style: TextStyle(color: Colors.grey),),
          Text(_getTotalDtails["shipping_amount"].toString() == "0"?"Free":_getTotalDtails["shipping_amount"].toString(),style: TextStyle(fontSize:11,color: Colors.green ),)
  ],),
        const SizedBox(height: 3,),
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,children:  [
          const Text("Total",style: TextStyle(fontSize:15 ),),
          Text("SAR ${_getTotalDtails["grand_total"].toString()}")
        ],),
      ]),
) ,
),
          Divider(thickness: 7,color: Colors.grey.shade300,),
          const SizedBox(height: 10,),

          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 20,
                  width: 20,
                  child: Image(image:AssetImage("assets/sheild.png"),)),
              Text("Safe & Secure payment. Easy returns 100% Authentic product",style: TextStyle(fontSize: 10,color: Colors.grey),)
            ],),
const SizedBox(height: 20,)
        ]),
      ),
      bottomNavigationBar:isLoading? Constants.loadingIndicator(): Container(
        height: 100,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),

          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total",style: TextStyle(fontSize:15 ),),
                 Text("SAR ${_getTotalDtails["grand_total"].toString()}",style: TextStyle(fontSize:15 ),),

              ],
            ),
            const SizedBox(height: 15,),
            LoginButtonWithGradient(
              width: double.infinity,
              borderRadius: BorderRadius.circular(5),
              onTap: () {
                ApiServisces().paymentInformation().then((value) {
                  if (kDebugMode) {
                    print(value);
                  }
                  if(value != null){
                    Navigator.pushNamed(context, Suceesfull_PlacedOredr.id);
                  }
                });
              },
              height: 45,
              color: AppColors.darkGreenColor,
              child: const Center(child: Text("PLACE ORDER",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),)),)
                ,
                const SizedBox(height: 10,)
          ]),
        ),
      ),
    );
  }
}
