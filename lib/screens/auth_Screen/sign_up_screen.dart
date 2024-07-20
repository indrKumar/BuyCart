import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vFASHU/utils/apiservices.dart';
import 'package:vFASHU/utils/constant_color.dart';
import '../../utils/apis.dart';
import '../../utils/utils.dart';
import '../../widgets/common/buttons.dart';
import '../../widgets/common/textformfield.dart';
import '../mainactivity.dart';

class Sign_Up_page extends StatefulWidget {
  static String id = "Sign_up";
  const Sign_Up_page({super.key});

  @override
  State<Sign_Up_page> createState() => _Sign_Up_pageState();
}

class _Sign_Up_pageState extends State<Sign_Up_page> {
  // String uniqueId;
  // @override
  // void initState() {
  //   super.initState();
  //
  //   getUniqueId().then(
  //         (value) => setState(
  //           () => uniqueId = value,
  //     ),
  //   );
  // }
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
ApiService apiService = ApiService();
  List slectMinutepersecond = [
    {"title": "Male", "value": "0"},
    {"title": "Female", "value": "1"},
  ];
  late String _selectGEnder= "";

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    print(Constants.accessToken);
    const SizedBox sizedBox10 = SizedBox(
      height: 10,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          top: false,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const SizedBox(
                //   height: 100,
                // ),
                // const Image(
                //   image: AssetImage("assets/saniya_logo.png"),
                //   width: 190,
                //   height: 180,
                // ),
                const Text("Register to VfashU!",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 10,
                ),
                const Text("Dummy Text",
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // border:
                      //     Border.all(color: Colors.grey.shade400, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    MyFormTextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]+')),
                      ],
                      textAlign: TextAlign.start,
                      controller: _nameController,
                      textInputType: TextInputType.text,
                      hintText: "Your Name",
                      hintStyle: TextStyle(
                          color: Colors.grey.shade400, fontSize: 13),
                    ),
                    // sizedBox10,
                    // MyFormTextField(
                    //   inputFormatters: [
                    //     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    //   ],
                    //   textAlign: TextAlign.start,
                    //   controller: _mobileController,
                    //   textInputType: TextInputType.number,
                    //   hintText: "Mobile no",
                    //   hintStyle: TextStyle(
                    //       color: Colors.grey.shade400, fontSize: 13),
                    // ),
                    sizedBox10,
                    MyFormTextField(
                      textAlign: TextAlign.start,
                      controller: _emailController,
                      textInputType: TextInputType.text,
                      hintText: "Email Address",
                      hintStyle: TextStyle(
                          color: Colors.grey.shade400, fontSize: 13),
                    ),
                    sizedBox10,
                    InputDecorator(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero),
                        contentPadding: EdgeInsets.all(17),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectGEnder,
                          isDense: true,
                          isExpanded: true,
                          menuMaxHeight: 350,
                          items: [
                             DropdownMenuItem(
                                value: "",
                                child:Text("Gender",style: TextStyle(color: Colors.grey.shade400, fontSize: 13),)),
                            ...slectMinutepersecond.map<DropdownMenuItem<String>>((data) {
                              return DropdownMenuItem( value: data['value'], child: Text(data['title']));
                            }).toList(),
                          ],
                          onChanged: (newValue) {
                            setState(
                                  () {
                                    _selectGEnder = newValue!;
                                print(_selectGEnder);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    isLoading
                        ? Constants.loadingIndicator()
                        : LoginButtonWithGradient(
                      onTap: () {
                        apiService.signUp(gmail:_emailController.text,name: _nameController.text,gender: _genderController.text).then((value) {
                          print(value.toString());
                          if(value!.success == true){
                            Navigator.pushReplacementNamed(
                                context, MainActivity_page.id,);
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login_ConfirmOtp_page()));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("SignUp successfully "),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('This is a message'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        },);
                              // setState(() {
                              //   isLoading = true;
                              // });
                              // ApiServisces()
                              //     .createCustomer(
                              //     _mobileController.text,
                              //     _nameController.text,
                              //     _selectGEnder,
                              //     _emailController.text
                              // )
                              //     .then((value) {
                              //   setState(() {
                              //     isLoading = false;
                              //   });
                              //   print("created $value");
                              //   if (value['status'].toString() ==
                              //       "200") {
                              //     print("value $value");
                              //     Navigator.pushReplacementNamed(
                              //         context, MainActivity_page.id);
                              //     sharedPreferences.setString(Constants.SP_USER_EMAIL, _emailController.text);
                              //     Constants.accessToken =
                              //         value['data'].toString();
                              //     sharedPreferences.setString(
                              //         Constants.SP_ACCESS_TOKEN,
                              //         value['data'].toString());
                              //     sharedPreferences.setBool(
                              //         Constants.SP_ISLOGIN, true);
                              //   }
                              // });
                            },
                      height: 55,
                            width: double.infinity,
                            color: AppColors.mainColor,
                            child: Center(
                              child: Center(
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "Register",
                                        style: Utils.text25,
                                      ),
                              ),
                            ),
                          )
                  ]),
                ),
                const SizedBox(
                  height: 30,
                ),
              ]),
        ),
      ),
    );
  }
  // Future<String> getUniqueId() async {
  //   try {
  //     return await UniqueDeviceId.instance.getUniqueId();
  //   } on PlatformException catch (e) {
  //     if (e.code == '1011') {
  //       final status = await Permission.storage.request();
  //       if (status.isGranted) {
  //         return getUniqueId();
  //       } else if (status.isPermanentlyDenied) {
  //         openAppSettings();
  //       }
  //     }
  //     return null;
  //   }
  // }
}
