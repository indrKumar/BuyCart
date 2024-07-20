import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

class Utils {
  static const TextStyle text20 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const TextStyle text15 = TextStyle(
    fontSize: 15.0,
    color: Colors.grey,
  );
  static const TextStyle text25 = TextStyle(
    fontSize: 25.0,
    color: Colors.white,
  );
  static const TextStyle text17 = TextStyle(
    fontSize: 17.0,
    color: Colors.black,
  );
  static const TextStyle text10 = TextStyle(
      fontSize: 10.0, color: Colors.black, fontWeight: FontWeight.bold);
}



class Constants {
  static const noConnectionErrorMessage = 'Not connected to a network!';

  late Size _screenSize;
  late TextTheme _textTheme;
  late Map<String, dynamic> _passedData;

  static Color themeColor = const Color(0xff7e7b7b);




  static const String SP_ISLOGIN = "isLogin";
  static const String SP_USER_NAME = "username";
  static const String SP_USER_MOBILE = "userMobile";
  static const String SP_USER_EMAIL = "userEmail.com";
  static const String SP_ACCESS_TOKEN = "accessToken";

 static String accessToken = "";




 //address and profile details
  static const String SP_REGION ="";
  static const String SP_REGION_ID ="";
  static const String SP_COUNTRY_ID ="";
  static const String SP_STREET ="";
  static const String SP_POSTCODE ="";
  static const String SP_CITY ="";
  static const String SP_FIRSTNAME ="";
  static const String SP_LASTNAME ="";
  static const String SP_EMAIL ="";
  static const String SP_TELEPHONE ="";

  Constants(BuildContext context) {
    try {
      _screenSize = MediaQuery.of(context).size;
      _passedData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    } catch (e) {
      // log("constant error $e");
    }
    _textTheme = Theme.of(context).textTheme;
  }

  double get screenWidth {
    return _screenSize.width;
  }

  double get screenHeight {
    return _screenSize.height;
  }

  double get iconSize {
    return _screenSize.width;
  }

  double get appBarSize {
    return _screenSize.height;
  }

  TextTheme get textTheme {
    return _textTheme;
  }

  Map<String, dynamic> get passedData {
    return _passedData;
  }

  static Widget loadingIndicator(){
    return Center(
        child: CircularProgressIndicator(
          color: themeColor,
        )
    );
  }


  static showLoader(context){
    showDialog(context: context, builder: (context){
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 120),
        child: Container(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  )
              ),
              SizedBox(height: 15,),
              Text("Please Wait", style: TextStyle(color: Colors.black))
            ],
          ),
        ),
      );
    },
        barrierDismissible: false);

    /*Loader.show(context,
        isSafeAreaOverlay: false,
        isBottomBarOverlay: false,
        overlayFromBottom: 80,
        overlayColor: Colors.black26,
        progressIndicator: CircularProgressIndicator(backgroundColor: Colors.orange),
        themeData: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black))
    );*/
  }

  static dismissLoader(context){
    Navigator.pop(context);
    //Loader.hide();
  }


  static showSnackDialog(context, String text){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 10),
          elevation: 8,
          dismissDirection: DismissDirection.horizontal,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          backgroundColor: Colors.white,
          content: Container(
            height: 100,
            decoration: filledRoundedDecoration(radius: 1.0, color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Message", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10),),
                SizedBox(height: 6,),
                Expanded(child: Text(text, style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black ), /*overflow: TextOverflow.ellipsis,*/)),
                SizedBox(height: 5,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        //Navigator.pop(context);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      child: Container(
                        decoration: filledRoundedDecoration(radius: 4.0, color: Colors.red),
                        padding: const EdgeInsets.all(8),
                        child: const Text("Okay", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    //Icon(Icons.info_outline, color: Colors.grey, size: 12,),
                    //Text(" Swipe to dismiss", style: TextStyle(color: Colors.grey, fontSize: 10),),
                  ],
                )
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(15),
          //action: SnackBarAction(label: "Close", onPressed: ()=>{ScaffoldMessenger.of(context).removeCurrentSnackBar()}),
        )
    );
  }


  static BoxDecoration filledRoundedDecoration({required double radius, Color? color}){

    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );

  }

  Decoration outlineDecoration({color, width, radius, fillColor}){
    return BoxDecoration(
        color: fillColor,
        border: Border.all(color: color ?? Colors.red, width: width ?? 10, ),
        borderRadius: BorderRadius.circular(radius ?? 10,)
    );
  }


  static String
  SP_KEY_USER_TYPE = "key_user_type",
      SP_KEY_ACCESS_TOKEN = "key_user_token",
      SP_KEY_IS_LOGGED_IN = "key_is_logged_in",
      SP_KEY_USER_NAME = "key_user_name",
      SP_KEY_USER_MOBILE_NUMBER="key_mobile_number",
      SP_KEY_USER_EMAIL="key_user_email",
      SP_KEY_USER_ADDRESS="key_user_address",
      SP_KEY_USER_IMAGE="key_user_image";

  // static setStringSp(String key, String value) async{
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   sp.setString(key, value);
  //   sp.remove(key);
  // }
  //
  // static Future<String?> getStringSp(String key) async{
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   return sp.getString(key);
  // }
  //
  // static setBoolSp(String key, bool value) async{
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //
  //   sp.setBool(key, value);
  // }
  //
  // static Future<bool?> getBoolSp(String key) async{
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   return sp.getBool(key);
  // }

  showAlertDialog(context, {
    required Widget content,
    required void Function() redAction,
    required String redText,
    required void Function() greenAction,
    required String greenText,
    required double height
  }){
    showDialog(context: context, builder:(context)=> AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.all(12),
        decoration: outlineDecoration(width: 2.0, radius: 10.0, fillColor: Colors.white),
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            content,

            Spacer(),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: redAction,
                    child: GestureDetector(
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: Colors.red
                        ),
                        child: Center(child: Text(redText,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),

                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: InkWell(
                    onTap: greenAction,
                    child: GestureDetector(
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: Colors.green
                        ),
                        child: Center(child: Text(greenText,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),);
  }

  showWidgetDialog(context, {
    required Widget content,
    required double height
  }){
    showDialog(context: context, builder:(context)=> AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: EdgeInsets.all(12),
        decoration: outlineDecoration(width: 2.0, radius: 10.0, fillColor: Colors.white),
        height: height,
        child: content,
      ),
    ),);
  }


}




extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

