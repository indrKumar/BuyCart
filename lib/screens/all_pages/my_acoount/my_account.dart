import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/utils.dart';
import '../../../widgets/common/buttons.dart';
import '../../../widgets/common/textformfield.dart';
import '../../../widgets/radio_buttons.dart';
import '../change_password.dart';
import '../delete_page.dart';
import '../notification_page.dart';
import '../privacy_policy.dart';
import 'my_address.dart';

class My_Account_Page extends StatefulWidget {
  static String id = "My_account";
  const My_Account_Page({super.key});

  @override
  State<My_Account_Page> createState() => _My_Account_PageState();
}

enum Gender { male, female, other }

class _My_Account_PageState extends State<My_Account_Page> {
  TextEditingController monthController = TextEditingController();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
        monthController.text = formattedDate;
      });
    }
  }

  Gender _gender = Gender.male;
  void _genderRadioValueChange(Gender? value) {
    setState(() {
      _gender = value!;
    });
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
          "My Account",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 25,),
             SizedBox(
               child: GestureDetector(
                 onTap: (){
                   Navigator.pushNamed(context, My_AddressPage.id);
                 },
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Row(children: [   ImageIcon(
                       AssetImage("assets/address.png"),
                       size: 18,
                       color: Colors.black54,
                     ),
                       SizedBox(width: 20,),
                       Text(
                         "My Addresses",
                         style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                       ),],),
                     Icon(
                       Icons.arrow_forward_ios_rounded,
                       size: 18,
                       color: Colors.black54,
                     )
                   ],),
               ),
             ),
       // SizedBox(height: 15,),
                // SizedBox(
                //   child: GestureDetector(
                //     onTap: (){
                //       Navigator.pushNamed(context, Change_password.id);
                //     },
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Row(children: [   ImageIcon(
                //           AssetImage("assets/lock.png"),
                //           size: 18,
                //           color: Colors.black54,
                //         ),
                //           SizedBox(width: 20,),
                //           Text(
                //             "Change Password",
                //             style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                //           ),],),
                //         Icon(
                //           Icons.arrow_forward_ios_rounded,
                //           size: 18,
                //           color: Colors.black54,
                //         )
                //       ],),
                //   ),
                // ),
                //
                // SizedBox(height: 15,),
           //  SizedBox(
           //    child: GestureDetector(
           //      onTap: (){
           //        Navigator.pushNamed(context, Delete_Page.id);
           //      },
           //      child: Row(
           //        mainAxisAlignment: MainAxisAlignment.spaceBetween,
           //        children: [
           // Row(children: [   ImageIcon(
           //       AssetImage("assets/delete.png"),
           //       size: 18,
           //   color: Colors.black54,
           // ),
           //       SizedBox(width: 20,),
           //       Text(
           //         "Delete Account",
           //         style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
           //       ),],),
           //        Icon(
           //          Icons.arrow_forward_ios_rounded,
           //          size: 18,
           //          color: Colors.black54,
           //        )
           //      ],),
           //    ),
           //  ),
                const SizedBox(height: 18,),

            const Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            ),
const SizedBox(height: 12,),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, Delete_Page.id);
                  },
                  child: const SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [   ImageIcon(
                    AssetImage("assets/profile.png"),
                    size: 23,
                    color: Colors.black54,
                        ),
                          SizedBox(width: 20,),
                          Text(
                            "Profile Details",
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                          ),],),
                        // Icon(
                        //   Icons.arrow_forward_ios_rounded,
                        //   size: 18,
                        //   color: Colors.black54,
                        // )
                      ],),
                  ),
                ),
                SizedBox(height: 12,),

                Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Text("FULL NAME",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 50,
              child: MyFormTextField(
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
                // controller: _nameController,
                textInputType: TextInputType.text,
                hintText: "indrkumar",
                hintStyle: TextStyle(fontSize: 13,color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text("Enter Email",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 50,
              child: MyFormTextField(
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                hintStyle: TextStyle(fontSize: 13,color: Colors.grey),


                // controller: _nameController,
                textInputType: TextInputType.text,
                hintText: "indrkuma@gmail.com",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text("Enter Your Mobile Number",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
            SizedBox(
              height: 5,
            ),
            SizedBox(height: 50,
              child: MyFormTextField(
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                hintStyle: TextStyle(fontSize: 13,color: Colors.grey),


                textAlign: TextAlign.start,
                // controller: _nameController,
                textInputType: TextInputType.number,
                hintText: "9832983272",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            ),
            SizedBox(
              height: 15,
            ),
            Text("Gender"),
            SizedBox(height: 5,),
            GenderSelectionWidget(),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.grey,
              height: 0,
              thickness: 1,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Birthday",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
            SizedBox(
              height: 5,
            ),
            SizedBox(height: 50,
              child:MyFormTextField(
                readOnly: true,
                controller: monthController,

                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                textInputType: TextInputType.none,
                suffixIcon: const Icon(
                  Icons.date_range_outlined,
                  color: Colors.grey,
                ),
                hintText: "24/28/1982",
                onTap: () {
                  _selectDate(context);
                },
              ),

            ),
            SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            ),
                SizedBox(height: 15,),
                SizedBox(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, Privacy_Policy.id);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [   ImageIcon(
                          AssetImage("assets/lock.png"),
                          size: 18,
                          color: Colors.black54,
                        ),
                          SizedBox(width: 20,),
                          Text(
                            "Privacy & Policy",
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                          ),],),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: Colors.black54,
                        )
                      ],),
                  ),
                ),
            const SizedBox(height: 15,),
            const Divider(
              color: Colors.grey,
              height: 2,
              thickness: 1,
            ),
                const SizedBox(height: 15,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, Notification_Page.id);

                  },
                  child: SizedBox(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, Notification_Page.id);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [   ImageIcon(
                            AssetImage("assets/notification.png"),
                            size: 18,
                            color: Colors.black54,
                          ),
                            SizedBox(width: 15,),
                            Text(
                              "Notifications",
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                            ),],),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18,
                            color: Colors.black54,
                          )
                        ],),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Divider(
                  color: Colors.grey.shade300,
                  height: 2,
                  thickness: 3,
                ),
                const SizedBox(height: 15,),
                Center(child: GestureDetector(
                  onTap: (){},
                  child: const Text("SIGN OUT OF MY ACCOUNT",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w700,color: Color(0xFF0B7708))
                    ,),
                )),
                const SizedBox(height: 20,)
          ]),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Divider(
              color: Colors.grey,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: LoginButtonWithGradient(
                width: double.infinity,
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFF0B7708),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: const Text("SAVE CHANGES",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

