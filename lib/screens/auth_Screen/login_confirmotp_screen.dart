import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vFASHU/screens/auth_Screen/sign_up_screen.dart';
import 'package:vFASHU/screens/mainactivity.dart';
import 'package:vFASHU/utils/constant_color.dart';
import '../../utils/apiservices.dart';
import '../../utils/utils.dart';
import '../../widgets/common/buttons.dart';
import '../../widgets/common/textformfield.dart';

class Login_ConfirmOtp_page extends StatefulWidget {
  static String id = "Login_confirm";
  const Login_ConfirmOtp_page({super.key});

  @override
  State<Login_ConfirmOtp_page> createState() => _Login_ConfirmOtp_pageState();
}

class _Login_ConfirmOtp_pageState extends State<Login_ConfirmOtp_page> {
  final TextEditingController _otpController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final contact = arguments['contact'];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          top: true,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100,),

                // const Image(
                //   image: AssetImage("assets/saniya_logo.png"),
                //   width: 190,
                //   height: 180,
                // ),
                const SizedBox(
                  height: 30,
                ),
                const Text("Welcome To VfashU!", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 10,
                ),
                const Text("Enter Verification Code", style: TextStyle(fontSize: 14,color: Colors.grey)),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  width: double.infinity,
                  // height: 300,
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey.shade400,width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    Text("Verification Code hass been send to",
                        style:TextStyle(fontSize: 13,color: Colors.grey.shade400)),
                    const SizedBox(
                      height: 9,
                    ),
                    const Text(
                      "+91 9898238454",
                      style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    //textField ...
                    MyFormTextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: _otpController,
                      textInputType: TextInputType.number,
                      hintText: "Enter OTP",
                      hintStyle: TextStyle(fontSize: 13,color: Color(0xFF632D8F)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LoginButtonWithGradient(
                      onTap: () {
                        apiService.verifyOtp(contactNo: contact,otp: _otpController.text ).then((value) {
                          if(value!.success == true){
                            if(value.data.is_newUser == true){
                              Constants.accessToken =
                                  value.token;
                              sharedPreferences.setString(
                                  Constants.SP_ACCESS_TOKEN,
                                  value.token);
                              sharedPreferences.setBool(
                                  Constants.SP_ISLOGIN, true);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  MainActivity_page()));
                            }else{
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Sign_Up_page()));
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("OTP verify successfully"),
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
                      },
                      // onTap: () => Navigator.pushReplacementNamed(
                      //     context, Sign_Up_page.id),
                      height: 55,
                      width: double.infinity,
                      color: AppColors.mainColor,
                      child: const Center(
                        child: Text(
                          "Verify",
                          style: Utils.text25,
                        ),
                      ),
                    )
                  ]),
                ),
                const SizedBox(height: 30,)
              ]),
        ),
      ),
    );

  }

}
