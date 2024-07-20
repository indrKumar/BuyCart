import 'package:flutter/material.dart';

class Dimensions {
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double pageView(BuildContext context) => screenHeight(context) / 2.64;
  static double pageViewContainer(BuildContext context) =>
      screenHeight(context) / 3.84;
  static double pageViewTextContainer(BuildContext context) =>
      screenHeight(context) / 7.03;

  //daynemic height margin and padding
  static double height10(BuildContext context) => screenHeight(context) / 84.4;
  static double height20(BuildContext context) => screenHeight(context) / 42.2;
  static double height15(BuildContext context) => screenHeight(context) / 56.25;
  static double height30(BuildContext context) => screenHeight(context) / 28.13;
  static double height45(BuildContext context) => screenHeight(context) / 18.76;

  //daynemic width margin and padding

  static double width10(BuildContext context) => screenWidth(context) / 84.4;
  static double width20(BuildContext context) => screenWidth(context) / 42.2;
  static double width15(BuildContext context) => screenWidth(context) / 56.25;
  static double width30(BuildContext context) => screenWidth(context) / 28.13;
  static double width45(BuildContext context) => screenWidth(context) / 18.76;

  //daynemic radius and font hieght
  static double font20(BuildContext context) => screenHeight(context) / 42.60;
  static double font26(BuildContext context) => screenHeight(context) / 32.46;
  static double font16(BuildContext context) => screenHeight(context) / 53.25;

  static double radius20(BuildContext context) => screenHeight(context) / 42.2;
  static double radius30(BuildContext context) => screenHeight(context) / 28.13;

  // icon size
  static double iconSize24(BuildContext context) =>
      screenHeight(context) / 35.17;
  static double iconSize16(BuildContext context) =>
      screenHeight(context) / 52.75;

  static double listViewImageSize(BuildContext context) =>
      screenWidth(context) / 3.25;
  static double listViewTextContSize(BuildContext context) =>
      screenWidth(context) / 3.9;

  // popularfood image size
  static double popularFoodImgSize(BuildContext context) =>
      screenHeight(context) / 2.41;

  static double bottomHeightBar(BuildContext context) =>
      screenHeight(context) / 7.03;
}
