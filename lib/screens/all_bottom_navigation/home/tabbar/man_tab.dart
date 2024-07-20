// import 'dart:developer';
//
// import 'package:flutter/material.dart';
//
// class NnitificationTabs extends StatefulWidget {
//   const NnitificationTabs({Key? key}) : super(key: key);
//
//   @override
//   State<NnitificationTabs> createState() => _NnitificationTabsState();
// }
//
// class _NnitificationTabsState extends State<NnitificationTabs> {
//   /*List notiUPList = [
//     {
//       "noti": "Veera’s bus arriving in 5 mins",
//       "date": "today",
//       "time": "2:30 am"
//     },{
//       "noti": "Aman’s bus arriving in 5 mins",
//       "date": "10/10/2022",
//       "time": "3:30 am"
//     },{
//       "noti": "Kapil’s bus arriving in 5 mins",
//       "date": "12/10/2022",
//       "time": "1:30 am"
//     },{
//       "noti": "Aman’s bus arriving in 5 mins",
//       "date": "21/10/2022",
//       "time": "12:30 am"
//     },{
//       "noti": "Veera’s bus arriving in 5 mins",
//       "date": "today",
//       "time": "2:30 am"
//     },{
//       "noti": "Aman’s bus arriving in 5 mins",
//       "date": "10/10/2022",
//       "time": "3:30 am"
//     },{
//       "noti": "Kapil’s bus arriving in 5 mins",
//       "date": "12/10/2022",
//       "time": "1:30 am"
//     },{
//       "noti": "Aman’s bus arriving in 5 mins",
//       "date": "21/10/2022",
//       "time": "12:30 am"
//     },{
//       "noti": "Veera’s bus arriving in 5 mins",
//       "date": "today",
//       "time": "2:30 am"
//     },{
//       "noti": "Aman’s bus arriving in 5 mins",
//       "date": "10/10/2022",
//       "time": "3:30 am"
//     },{
//       "noti": "Kapil’s bus arriving in 5 mins",
//       "date": "12/10/2022",
//       "time": "1:30 am"
//     },{
//       "noti": "Aman’s bus arriving in 5 mins",
//       "date": "21/10/2022",
//       "time": "12:30 am"
//     },
//   ];*/
//
//   bool loader = false;
//   List notifications = [];
//   //String lastDateTime = '';
//   List<String> dateList = [];
//
//
//   getData(){
//     setState(() {
//       loader = true;
//     });
//     ApiServices().parentNotificationList().then((response) {
//       log("parent Notification History $response");
//       ApiServices().handleResponse(
//           response: response,
//           onSuccess: (){
//             setState(() {
//               loader = false;
//               notifications = response!['notification'];
//               //showToast(response!['message']);
//             });
//           },
//           onError: (){
//             setState(() {
//               loader = false;
//               //notifications = response!['notification'];
//             });
//             showToast(response!['message']);
//           }
//       );
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getData();
//     super.initState();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.orange.shade300,
//           title: const Align(
//             alignment: Alignment.bottomLeft,child: Text("Notifications",
//             style: TextStyle(color: Colors.black, fontSize: 21),),
//           ),
//
//         ),
//
//         body:   loader?Constants.loadingIndicator():
//         SingleChildScrollView(
//           child: Column(
//             children: notifications.map((element){
//
//               bool dateChanged = false;
//               String dateTime = element["date_time"].toString();
//
//               if(!dateList.contains(dateTime)) {
//                 dateList.add(dateTime);
//                 dateChanged = true;
//                 log(element['date_time']);
//               }
//               return Container(
//                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     if(!dateChanged)
//                       const Divider(
//                         color: Colors.white,
//                         thickness: 1.5,
//                         height: 0,
//                       )
//                     else
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 3,),
//                           Divider(
//                             color: StaticColors.primary,
//                             thickness: 5,
//                             height: 10,
//                           ),
//                           Text(element["date_time"].toString(),style: TextStyle(color: StaticColors.containerButon, fontWeight: FontWeight.bold, fontSize: 16),),
//                           const SizedBox(height: 5,),
//                         ],
//                       ),
//
//                     SizedBox(height: 10,),
//
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Icon(Icons.notifications,color: Colors.black,),
//                         SizedBox(width: 10,),
//                         Expanded(child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(element["header"],style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//                             const SizedBox(height: 3,),
//                             Text(element["notice"],style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
//                           ],
//                         )),
//                       ],
//                     ),
//                     const SizedBox(height: 5,),
//
//                     /* Row(
//                 children: [
//                   SizedBox(width: Constants(context).screenWidth -220,),
//                   Icon(Icons.watch_later,color: Colors.orange,size: 15,),
//                   SizedBox(width: 7,),
//                   Text(element["date_time"].toString(),style: TextStyle(color: StaticColors.containerButon),),
//
//                 ],
//               ),*/
//                     SizedBox(height: 10,),
//
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//         )
//       /* ListView.builder(
//           itemCount: notifications.length,
//           itemBuilder: (context,index){
//             Map element = notifications[index];
//             String dateTime = element["date_time"].toString();
//
//             bool dateChanged = false;
//             if(!dateList.contains(dateTime)) {
//               dateList.add(dateTime);
//               dateChanged = true;
//               log(element['date_time']);
//             }
//         return Container(
//           padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               if(!dateChanged)
//                 const Divider(
//                   color: Colors.white,
//                   thickness: 1.5,
//                   height: 0,
//                 )
//               else
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 3,),
//                     Divider(
//                       color: StaticColors.primary,
//                       thickness: 5,
//                       height: 10,
//                     ),
//                     Text(element["date_time"].toString(),style: TextStyle(color: StaticColors.containerButon, fontWeight: FontWeight.bold, fontSize: 16),),
//                     const SizedBox(height: 5,),
//                   ],
//                 ),
//
//               SizedBox(height: 10,),
//
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(Icons.notifications,color: Colors.black,),
//                   SizedBox(width: 10,),
//                   Expanded(child: Text(element["notice"],style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
//                 ],
//               ),
//               const SizedBox(height: 5,),
//
//              *//* Row(
//                 children: [
//                   SizedBox(width: Constants(context).screenWidth -220,),
//                   Icon(Icons.watch_later,color: Colors.orange,size: 15,),
//                   SizedBox(width: 7,),
//                   Text(element["date_time"].toString(),style: TextStyle(color: StaticColors.containerButon),),
//
//                 ],
//               ),*//*
//
//               SizedBox(height: 10,),
//
//             ],
//           ),
//         );
//       })*/
//     );
//   }
// }
//
