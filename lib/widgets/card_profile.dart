import 'package:flutter/material.dart';
import 'package:vFASHU/utils/constant_color.dart';

Widget card(){
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(color: AppColors.mainColor,borderRadius: BorderRadius.all(Radius.circular(8))),
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your wallet balance",style: TextStyle(color: Colors.white,fontSize: 12),),
          Text("Rs 1,967",style: TextStyle(fontSize: 18,color: Colors.white),),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                  child: Text("Add Amount",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                ),
              ),
            )
          ],)
        ],
      ),
    ),
  );
}