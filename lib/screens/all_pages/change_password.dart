import 'package:flutter/material.dart';
import '../../widgets/common/buttons.dart';
import '../../widgets/common/textformfield.dart';

class Change_password extends StatefulWidget {
  static String id = "change pass";
  const Change_password({Key? key}) : super(key: key);

  @override
  State<Change_password> createState() => _Change_passwordState();
}

class _Change_passwordState extends State<Change_password> {
  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  bool isCurrentPasswordVisible = true;
  bool isNewPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text(
          "Change password",
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15),
          child: Divider(
            color: Colors.black,
            height: 0,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Enter Current password",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  MyFormTextField(
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.start,
                    controller: _currentPassController,
                    hintText: "Min 6 characters",
                    obscureText: isCurrentPasswordVisible,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCurrentPasswordVisible = !isCurrentPasswordVisible;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        isCurrentPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter New password",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  MyFormTextField(
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.start,
                    controller: _newPassController,
                    hintText: "Min 6 characters",
                    obscureText: isNewPasswordVisible,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isNewPasswordVisible = !isNewPasswordVisible;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Confirm Current password",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  MyFormTextField(
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    textInputType: TextInputType.text,
                    textAlign: TextAlign.start,
                    controller: _confirmPassController,
                    hintText: "Min 6 characters",
                    obscureText: isConfirmPasswordVisible,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
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
                child: const Text(
                  "SAVE CHANGES",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}