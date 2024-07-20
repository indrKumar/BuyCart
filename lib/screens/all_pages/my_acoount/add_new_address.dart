import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vFASHU/utils/apiservices.dart';


import '../../../utils/apis.dart';
import '../../../utils/utils.dart';
import '../../../widgets/common/buttons.dart';
import '../../../widgets/common/textformfield.dart';
// import 'package:http/http.dart' as http;
class Add_New_Address extends StatefulWidget {
  const Add_New_Address({super.key});

  static String id = "add_new";
  @override
  State<Add_New_Address> createState() => _Add_New_AddressState();
}

class _Add_New_AddressState extends State<Add_New_Address> {

  late String selectedCourseValue1 = "";
  List<Map<String, dynamic>> regions = [];

  @override
  void initState() {
    super.initState();
    // ApiServisces().getRegion().then((value) {
    //   setState(() {
    //     regions = List<Map<String, dynamic>>.from(value["regions"]);
    //   });
    //   print(regions);
    // });
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _buildingAddressController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.grey;
  }


  @override
  Widget build(BuildContext context) {
  var arg = ModalRoute.of(context)?.settings.arguments;
print(arg);

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
        title: const Text(
          "Add New Address",
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 10,),
            const Text("First Name",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: MyFormTextField(
                controller: _firstNameController,
                textInputType: TextInputType.text,
                style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                hintStyle: TextStyle(fontSize: 13,color: Colors.grey),
                textAlign: TextAlign.start,
                // controller: _nemeController,
                hintText: "First Name",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // const Text("Last Name",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
            // const SizedBox(
            //   height: 10,
            // ),SizedBox(
            //       height: 50,
            //   child: MyFormTextField(
            //     controller: _lastNameController,
            //     textInputType: TextInputType.text,
            //     style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
            //     hintStyle: TextStyle(fontSize: 13,color: Colors.grey),
            //     textAlign: TextAlign.start,
            //     // controller: _nemeController,
            //     hintText: "Last name",
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            const Text("Mobile number",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 50,
              child: MyFormTextField(
                textInputType: TextInputType.number,
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                hintStyle: TextStyle(fontSize: 13,color: Colors.grey),
                textAlign: TextAlign.start,
                // controller: _nemeController,
                hintText: "9893272873",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
//                 const Text("Select Region",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
// SizedBox(height: 10,),
//                 SizedBox(
//                   height: 50,
//                   child: InputDecorator(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(4)),
//                       contentPadding: const EdgeInsets.all(17),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         value: selectedCourseValue1,
//                         isDense: true,
//                         isExpanded: true,
//                         menuMaxHeight: 350,
//                         items: [
//                           const DropdownMenuItem(
//                               value: "",
//                               child:Text("Select Region",style: TextStyle(fontSize: 13),)),
//                           ...regions.map<DropdownMenuItem<String>>((data) {
//                             return DropdownMenuItem( value: data['value'], child: Text(data['label']));
//                           }).toList(),
//                         ],style: const TextStyle(fontSize: 13,color: Colors.black54),
//                         onChanged: (newValue) {
//                           setState(
//                                 () {
//                               selectedCourseValue1 = newValue!;
//                               print(selectedCourseValue1);
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
            const Text("Select City and Area",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
            const SizedBox(
              height: 10,
            ),
             SizedBox(
              height: 50,
              child: MyFormTextField(
                textInputType: TextInputType.text,
                style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                hintStyle: const TextStyle(fontSize: 13,color: Colors.grey),
                textAlign: TextAlign.start,
                controller: _cityController,
                hintText: "City/Area",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("Street",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
            const SizedBox(
              height: 10,
            ),
             SizedBox(height: 50 ,
              child: MyFormTextField(
                textInputType: TextInputType.text,
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                hintStyle: TextStyle(fontSize: 13,color: Colors.grey),
                textAlign: TextAlign.start,
                controller: _streetController,
                hintText: "Karamveer ",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("State",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
            const SizedBox(
              height: 10,
            ),
             SizedBox(
              height: 50,
              child: MyFormTextField(
                textInputType: TextInputType.text,
                style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                hintStyle: const TextStyle(fontSize: 13,color: Colors.grey),
                textAlign: TextAlign.start,
                controller: _stateController,
                hintText: "Madhya pradesh",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("PIN Code",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
            const SizedBox(
              height: 10,
            ),
             SizedBox(height: 50,
              child: MyFormTextField(
                textInputType: TextInputType.text,

                style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                hintStyle: TextStyle(fontSize: 13,color: Colors.grey),
                textAlign: TextAlign.start,
                controller: _pinController,
                hintText: "462023",
              ),
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                  width: 25,
                  child: Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),side: BorderSide(color: Colors.grey),

                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ),
                const Text("Set this as may deffould=t address",style: TextStyle(fontSize: 12,color: Colors.grey),)
              ],
            )
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
        child: LoginButtonWithGradient(
          onTap: (){
            ApiService().addAddress(
              city: _cityController.text,
                pin: _pinController.text,
              state: _stateController.text,
              street: _streetController.text,
                isDefault: isChecked
              // selectedCourseValue1,_mobileController.text,_streetController.text
            ).then((value) {
              print("RESPONE::::$value");
              if(value["success"] == true){
                Fluttertoast.showToast(msg: "Add Successfully",
                  gravity: ToastGravity.CENTER,
                );
                Navigator.pop(context);
              }else{
                Fluttertoast.showToast(msg: "Something went wrong",
                  gravity: ToastGravity.CENTER,
                );
              }
              if (kDebugMode) {
                print("VAluev$value");
              }
            });

          },

          color: const Color(0xFF0B7708),
          height: 55,
          child: const Center(
            child: Text("ADD ADDRESS",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,
                  color: Colors.white
                )),
          ),
        ),
      ),
    );
  }
}
