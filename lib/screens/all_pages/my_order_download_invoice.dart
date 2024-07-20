import 'package:flutter/material.dart';
import 'package:vFASHU/utils/constant_color.dart';

import '../../utils/apis.dart';
import '../../utils/utils.dart';
import '../../widgets/common/buttons.dart';

class Download_Invoice extends StatefulWidget {
  final String productId;

  const Download_Invoice({super.key, required this.productId});

  static String id = "download Invoice";

  @override
  State<Download_Invoice> createState() => _Download_InvoiceState();
}

class _Download_InvoiceState extends State<Download_Invoice> {
  Map<String, dynamic>? orderData = {};
  List<dynamic> track = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    ApiServisces().trackerApi(widget.productId).then((value) {
      setState(() {
        orderData = value['data'];
        track = orderData!["product"][0]["track"];
        print(track[0]["label"]);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Order Details",
          style: Utils.text20,
        ),
        centerTitle: false,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(15),
            child: Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            )),
      ),
      body:
          // isLoading?Constants.loadingIndicator():
          Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order ID: 563737363663'
                // '${orderData!['order_id'].toString()}'
                '',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 10,
              ),
              // for (var product in orderData!['product'])
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Women`s Traditional cotton '
                          // '${product['name']}'
                          '',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Rs 1,999  '
                          // '${orderData!['grand_total']}'
                          '',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 72,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                            image: AssetImage("assets/girl.png"),
                            fit: BoxFit.cover
                            // NetworkImage(product['image'].toString(),),fit: BoxFit.cover
                            )),
                  )
                ],
              ),

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //   tracker(track[0]["label"], Icons.circle,Colors.green,", ${track[0]["date"]}",),
              //   tracker(track[1]["label"], Icons.circle,Colors.green,", ${track[1]["date"]}"),
              //   tracker("label", Icons.circle,Colors.green,""),
              //  const Row(children: [ Icon(Icons.circle,color:Colors.green,size: 15,),
              //    SizedBox(width: 10),
              //    Text("label",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),
              //  ],)
              // ],),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tracker(
                    "Order Received",
                    Icons.circle,
                    Colors.green,
                    "(Mon 29th Apr’24 - 12:34 pm",
                  ),
                  tracker("Order Confirmed", Icons.circle, Colors.green,
                      "(Mon 29th Apr’24 - 12:34 pm}"),
                  tracker("Shipped", Icons.circle, Colors.green,
                      "(Mon 29th Apr’24 - 12:34 pm}"),
                  tracker("Out for Delivery", Icons.circle, Colors.green,
                      "(Mon 29th Apr’24 - 12:34 pm}"),
                  tracker("Delivered", Icons.circle, Colors.green,
                      "(Mon 29th Apr’24 - 12:34 pm}"),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoginButtonWithGradient(
              border: Border.all(color: Colors.grey.shade200),
              color: Colors.white,
              height: 45,
              child: const Center(
                child: Text(
                  "Rate product",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            LoginButtonWithGradient(
              color: AppColors.darkGreenColor,
              height: 45,
              child: const Center(
                child: Text(
                  "DOWNLOAD INVOICE",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget tracker(String label, IconData icon, Color iconColor, String date) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 15,
            ),
            Container(
              width: 1,
              height: 50,
              color: Colors.green,
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
            Text(
              date,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ],
    );
  }
}

//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Track Order'),
//     ),
//     body: orderData != null
//         ? Column(
//       children: [
//
//         Expanded(
//           child: ListView(
//             padding: EdgeInsets.all(16.0),
//             children: [
//               ListTile(
//                 title: Text('Order ID: ${orderData!['order_id']}'),
//               ),
//               ListTile(
//                 title: Text('Date: ${orderData!['date']}'),
//               ),
//               ListTile(
//                 title: Text('Customer Name: ${orderData!['customer_name']}'),
//               ),
//               ListTile(
//                 title: Text('Status: ${orderData!['status']}'),
//               ),
//               ListTile(
//                 title: Text('Grand Total: ${orderData!['grand_total']}'),
//               ),
//               ListTile(
//                 title: Text('Subtotal: ${orderData!['subtotal']}'),
//               ),
//               ListTile(
//                 title: Text('Shipping Amount: ${orderData!['shipping_amount']}'),
//               ),
//               ListTile(
//                 title: Text('Shipping Method: ${orderData!['shippingmethod']}'),
//               ),
//               ListTile(
//                 title: Text('Payment Method: ${orderData!['paymentmethod']}'),
//               ),
//               ListTile(
//                 title: Text('State: ${orderData!['state']}'),
//               ),
//               ListTile(
//                 title: Text('Updated Date: ${orderData!['updated_date']}'),
//               ),
//               for (var product in orderData!['product'])
//                 Column(
//                   children: [
//                     ListTile(
//                       title: Text('Product Name: ${product['name']}'),
//                     ),
//                     ListTile(
//                       title: Image.network(product['image']),
//                     ),
//                     // ... add more details or widgets for each product
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ],
//     )
//         : Center(
//       child: CircularProgressIndicator(),
//     ),
//   );
// }
// }
