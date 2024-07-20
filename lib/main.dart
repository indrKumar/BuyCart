import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vFASHU/features/auth/presantaion/bloc/auth_bloc.dart';
import 'package:vFASHU/features/auth/userparams.dart';
import 'package:vFASHU/screens/all_bottom_navigation/bag_checkout/bag_page.dart';
import 'package:vFASHU/screens/all_bottom_navigation/favorite_page.dart';
import 'package:vFASHU/screens/all_bottom_navigation/home/home_page.dart';
import 'package:vFASHU/screens/all_pages/change_password.dart';
import 'package:vFASHU/screens/all_pages/contact_us.dart';
import 'package:vFASHU/screens/all_pages/delete_page.dart';
import 'package:vFASHU/screens/all_pages/help_center.dart';
import 'package:vFASHU/screens/all_pages/my_acoount/add_new_address.dart';
import 'package:vFASHU/screens/all_pages/my_acoount/my_account.dart';
import 'package:vFASHU/screens/all_pages/my_acoount/my_address.dart';
import 'package:vFASHU/screens/all_pages/my_acoount/payment.dart';
import 'package:vFASHU/screens/all_pages/my_order.dart';
import 'package:vFASHU/screens/all_pages/notification_details.dart';
import 'package:vFASHU/screens/all_pages/notification_page.dart';
import 'package:vFASHU/screens/all_pages/order_succes_page.dart';
import 'package:vFASHU/screens/all_pages/privacy_policy.dart';
import 'package:vFASHU/screens/all_pages/search_page.dart';
import 'package:vFASHU/screens/all_pages/show_product_list.dart';
import 'package:vFASHU/screens/all_pages/slsahScreen.dart';
import 'package:vFASHU/screens/auth_Screen/login_confirmotp_screen.dart';
import 'package:vFASHU/screens/auth_Screen/login_sendotp_screen.dart';
import 'package:vFASHU/screens/auth_Screen/sign_up_screen.dart';
import 'package:vFASHU/screens/mainactivity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const userLogin = UserLogin();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            userLogin: userLogin
          ),
        ),
      ],
      child:
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: MainActivity_page.id,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          MainActivity_page.id: (context) => MainActivity_page(),
          Login_ConfirmOtp_page.id: (context) => const Login_ConfirmOtp_page(),
          Login_SendOtp_page.id: (context) => const Login_SendOtp_page(),
          Sign_Up_page.id: (context) => const Sign_Up_page(),
          My_Account_Page.id: (context) => const My_Account_Page(),
          Notification_Page.id: (context) => const Notification_Page(),
          Search_Page.id: (context) => Search_Page(),
          Home_page.id: (context) => const Home_page(),
          Favorite_page.id: (context) => const Favorite_page(),
          My_AddressPage.id: (context) => const My_AddressPage(),
          Add_New_Address.id: (context) => const Add_New_Address(),
          Product_list.id: (context) => const Product_list(),
          // Product_dtails.id: (context) => Product_dtails(),
          Change_password.id: (context) => const Change_password(),
          Delete_Page.id: (context) => const Delete_Page(),
          Help_Center_page.id: (context) => const Help_Center_page(),
          Contacts_Us.id: (context) => const Contacts_Us(),
          Privacy_Policy.id: (context) => const Privacy_Policy(),
          My_Order_page.id: (context) => const My_Order_page(),
          // Download_Invoice.id: (context) => Download_Invoice(),
          Payment_Page.id: (context) => const Payment_Page(),
          BagePage.id: (context) => const BagePage(),
          Suceesfull_PlacedOredr.id: (context) => const Suceesfull_PlacedOredr(),
          NotificationDetails.id:(context)=> const NotificationDetails()
        },
      ),
    );
  }
}
