import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vFASHU/utils/constant_color.dart';
import 'package:vFASHU/widgets/common/buttons.dart';
import '../../utils/apis.dart';
import '../../utils/utils.dart';
import 'my_order_download_invoice.dart';

class My_Order_page extends StatefulWidget {
  const My_Order_page({super.key});
  static String id = "MyOrder";

  @override
  State<My_Order_page> createState() => _My_Order_pageState();
}

class _My_Order_pageState extends State<My_Order_page> {
  List<dynamic> _data =[];
bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiServisces().orderDetails().then((value) {
      if(value != null){
          _data = value["data"]["product"];
          isLoading =false;
      }else{
        if (kDebugMode) {
          print("err");
        }
      }
 
if (kDebugMode) {
  print("dataaaaa:::::$_data");
}
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
          "My Orders",
          style: Utils.text20,
        ),
        centerTitle: false,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            )),
        // leading: GestureDetector(
        //   onTap: (){
        //     Navigator.pop(context);
        //   },
        //   child: Icon( Icons.arrow_back_ios_new,
        //   ),
        // ),
      ),
      body:
      // isLoading?Constants.loadingIndicator():
      ListView.separated(separatorBuilder: (context, index) {
        return const Divider();
      },
        itemCount: 5,
        // itemCount: _data.length,
        itemBuilder: (context, index) {
          return
            Padding(
              padding: const EdgeInsets.only(left: 15,top: 10,right: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Download_Invoice(productId:
                  // _data[index]!["order_id"]
                    "2"
                  ),));
                },
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Container(
                    width: 90,
                    height: 110,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.grey,image: const DecorationImage(image:
                    // NetworkImage(_data[index]["product"][index]["image"].toString()),fit: BoxFit.cover)
                    AssetImage("assets/girl.png"),fit: BoxFit.cover)
                    ),
                  ),
                  const SizedBox(width: 10,),

                   Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                      const Text(
                      "Women`s Traditional cotton "
                        // _data[index]["date"].toString()
                        ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("MRP 1,999",style: TextStyle(color: Colors.grey,fontSize: 12,decoration: TextDecoration.lineThrough,decorationColor: Colors.grey),),
                          const Text("Rs 1,499",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),),
                          LoginButtonWithGradient(
                            borderRadius: BorderRadius.circular(3),
                            color: AppColors.mainColor,child: const Center(child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Text("25% Off",style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.w600),),
                          )),)
                        ],
                      ),
                        const SizedBox(height: 4,),
                        const Text("Size: S",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),),
                        const SizedBox(height: 3,),
                        const Text("Arriving tomorrow",style: TextStyle(fontSize: 11,color: AppColors.lightGreenColor),),
                        const SizedBox(height: 2,),
                        const Text("Rate and Review to earn VfashU Credit",style: TextStyle(color: AppColors.mainColor),)
                    ],),
                  ),
                 const ImageIcon(AssetImage("assets/right-arrow.png"),size: 40,color: Colors.grey,)
                ],),
              ),
            );

            Column(
            children: [

              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Download_Invoice(productId: _data[index]!["order_id"]),));
                },
                leading: Container(
                  width: 70,
                  height: 65,
                  decoration: BoxDecoration(color: Colors.grey,image: DecorationImage(image: NetworkImage(_data[index]["product"][index]["image"].toString()),fit: BoxFit.cover)),
                ),
                title: Text(_data[index]["date"].toString()),
                subtitle:
                    Text("Girls Polyester Full Sleeve Top (White, Pack of 1)"),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
              ),
              Divider(
                color: Colors.grey,
              )
            ],
          );
        },
      ),
    );
  }
}
