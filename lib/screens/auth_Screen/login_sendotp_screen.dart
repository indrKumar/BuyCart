import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../features/auth/presantaion/bloc/auth_bloc.dart';
import '../../utils/apiservices.dart';
import '../../utils/constant_color.dart';
import '../../utils/utils.dart';
import '../../widgets/common/buttons.dart';
import 'login_confirmotp_screen.dart';
class Login_SendOtp_page extends StatefulWidget {
  const Login_SendOtp_page({Key? key}) : super(key: key);
  static String id = "send otp";

  @override
  State<Login_SendOtp_page> createState() => _Login_SendOtp_pageState();
}

class _Login_SendOtp_pageState extends State<Login_SendOtp_page> {
  TextEditingController controller = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: SafeArea(
          top: true,
          child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  print(state.message);
                  // showSnackBar(context, state.message);
                } else if (state is AuthSuccess) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login_ConfirmOtp_page()),
                        (route) => false,
                  );
                }
            },
            builder: (context, state) {
              // if (state is AuthLoading) {
              //   return  Constants.loadingIndicator();
              // }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: 100,),
                  // const Image(
                  //   image: AssetImage("assets/saniya_logo.png"),
                  //   width: 190,
                  //   height: 180,
                  // ),
                  const Text("Welcome To VfashU", style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 11,
                  ),
                  const Text("Sign in to Continue",
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(
                    height: 30,
                  ),
                  IntlPhoneField(
                    showCountryFlag: false,
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Your mobile number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                  // Container(
                  //   decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 10),
                  //     child: Row(
                  //       children: [
                  //         const Text('+966', style: TextStyle(fontSize: 14,color: AppColors.mainColor,fontWeight: FontWeight.bold),
                  //         ),
                  //         SizedBox(width: 8), // Adjust the spacing between prefix and input field
                  //         Flexible(
                  //           child: TextField(
                  //           keyboardType  : TextInputType.phone,
                  //             textAlign: TextAlign.start,
                  //         inputFormatters : [
                  //           FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  //       ],
                  //       decoration: const InputDecoration(
                  //         border: InputBorder.none,
                  //               hintText: "Your Mobile Number",
                  //               hintStyle: TextStyle(fontSize: 13,color: Colors.grey),
                  //             ),
                  //             // TextField properties
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 35,
                  ),
                  LoginButtonWithGradient(
                    onTap: () {
                      apiService.sendOtp(contactNo: controller.text).then((value) {
                        print(value.toString());
                        if(value!.success == true){
                          Navigator.pushReplacementNamed(
                                context, Login_ConfirmOtp_page.id,arguments: {'contact': controller.text.toString()});
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login_ConfirmOtp_page()));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("OTP send successfully "),
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
                    height: 55,
                    width: double.infinity,
                    color:
                    AppColors.mainColor,
                    child: const Center(
                      child: Text(
                        "Send OTP",
                        style: Utils.text25,
                      ),
                    ),
                    // gradient: const LinearGradient(
                    //   colors: [
                    //     Color.fromARGB(255, 196, 125, 20),
                    //   ],
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    // ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  // Row(
                  //   children:  [
                  //     Expanded(
                  //         child: Divider(
                  //       endIndent: 5,
                  //       indent: 5,
                  //       thickness: 1,
                  //       color: Colors.grey.shade400,
                  //     )),
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 15),
                  //       child: Text(
                  //         "OR",
                  //         style: TextStyle(fontSize: 13,color: Colors.grey.shade400),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //     Expanded(
                  //
                  //         child: Divider(
                  //       endIndent: 5,
                  //       indent: 5,
                  //       thickness: 1,
                  //       color: Colors.grey.shade400,
                  //     )),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 35,
                  // ),
                  // LoginButtonWithGradient(
                  //   height: 50,
                  //   width: double.infinity,
                  //   border: Border.all(color: Colors.grey),
                  //   child: const Center(
                  //     child: Text("Continue without number", style: TextStyle(fontSize: 18)),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 35,
                  // ),
                  // RichText(
                  //   text: TextSpan(
                  //     text: 'Are you a new user?  ',
                  //     style: Utils.text17,
                  //     children: <TextSpan>[
                  //       TextSpan(
                  //         text: 'Register Here',
                  //         style: const TextStyle(
                  //           color: AppColors.mainColor,
                  //           // decoration: TextDecoration.underline,
                  //         ),
                  //         recognizer: TapGestureRecognizer()
                  //           ..onTap = () {
                  //             Navigator.pushReplacementNamed(
                  //                 context, Sign_Up_page.id);
                  //           },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 30,)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
