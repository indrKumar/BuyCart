import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vFASHU/utils/apiservices.dart';

import '../../../models/addresslistmodel.dart';
import '../../../utils/apis.dart';
import '../../../utils/utils.dart';
import 'add_new_address.dart';

class My_AddressPage extends StatefulWidget {
  const My_AddressPage({super.key});
  static String id = "My_add";

  @override
  State<My_AddressPage> createState() => _My_AddPageState();
}

class _My_AddPageState extends State<My_AddressPage> {

  bool isLoading = true;
  List<Map<String, dynamic>> _addList = [];
  List<Address> addList = [];

  getAddressList(){
    ApiService().getAddressList().then((value) {
      if (value.success == true) {
        setState(() {
          addList = value.data.address;
          isLoading = false;
        });
      } else {
        Future.delayed(const Duration(seconds: 3)).then((value) {
          setState(() {
            // _addList =  List<Map<String, dynamic>>.from(addresses);
            isLoading = false;
          });
        },);
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddressList();
  }
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "My Address",
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
        actions: [
          IconButton(
            onPressed: () async{
              await Navigator.push(context,MaterialPageRoute(builder: (context) => const Add_New_Address(),));

              setState(() {
                getAddressList();

              });
            },
            icon: Icon(
              Icons.add,
              size: 30,
              color: Colors.grey.shade800,

            ),
          )
        ],
      ),
      body:isLoading? Constants.loadingIndicator(): SingleChildScrollView(
        child: Column(children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: addList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final address = addList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
               Text(address.state,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
               const SizedBox(height: 5,),
             Text("${address.street}, ${address.city}, ${address.state}, ${address.zip}" ,style: TextStyle(fontSize: 14),),
                 const SizedBox(height: 5,),
                 const Text("9691486905",style: TextStyle(fontSize: 14,),),
             ],),
           ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              endIndent: 18,
              indent: 18,
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap:(){
                    if (kDebugMode) {
                      print(address.id);
                    }
                    ApiService().deleteAddress(id:address.id).then((value) {
                      if(value["success"] == true){
                        setState(() {
                          getAddressList();
                        });
                      }else{

                      }
                    },);
                  },
                  child: const Row(
                    children: [
                      ImageIcon(AssetImage("assets/delete.png"),size: 15,),
                      SizedBox(width: 10,),
                      Text("Delete",style: TextStyle(fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
                const Text("|"),
                InkWell(
                  onTap:(){
                    Navigator.pushNamed(context, Add_New_Address.id,arguments: "isEdit");
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.edit,size: 15,),
                      SizedBox(width: 10,),

                      Text("Edit",style: TextStyle(fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 5,
              color: Colors.grey.shade300,
            ),
          ],);
        },),
          ListTile(
            contentPadding: const EdgeInsets.only(right: 20, left: 20),
            leading: const ImageIcon(
              AssetImage("assets/address.png"),
              size: 18,
              color: Colors.black54,
            ),
            title: const Text(
              "Add New Address",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.pushNamed(context, Add_New_Address.id);
            },
          ),
          Divider(
            thickness: 5,
            color: Colors.grey.shade300,
          )
        ]),
      ),
    );
  }
}
