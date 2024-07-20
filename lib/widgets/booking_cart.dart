import 'package:flutter/material.dart';
import 'package:vFASHU/widgets/quantity.dart';

import '../utils/constant_color.dart';
import 'common/buttons.dart';

class Booking_Cart extends StatelessWidget {
  const Booking_Cart(
      {super.key,
      required this.value,

      required this.color,
      this.quantityIncreament,
        required this.remove,
        required this.imgUrl,
      this.quantityDecrease, required this.title, required this.price, required this.selectSize,});
final Widget selectSize;
  final int value;
  final String price;
  final String title;
  final String imgUrl;
  final VoidCallback remove;
  final Color color;
  final VoidCallback? quantityIncreament;
  final VoidCallback? quantityDecrease;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
             Row(children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: SizedBox(
                   width: 90,
                   height: 150,
                   child: AspectRatio(
                       aspectRatio: 0.5,
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(10),
                         child: Image.asset(
                           imgUrl,
                           fit: BoxFit.fill,
                         ),
                         // child: Image.network(
                         //   imgUrl,
                         //   fit: BoxFit.fill,
                         // ),
                       )),
                 ),
               ),
               const SizedBox(width: 5,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       title,
                       style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                     ),
                     const SizedBox(
                       height: 10,
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         const Text("MRP 1,999",style: TextStyle(color: Colors.grey,fontSize: 12,decoration: TextDecoration.lineThrough,decorationColor: Colors.grey),),
                         const SizedBox(width: 10,),
                         const Text("Rs 1,499",style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),),
                         const SizedBox(width: 10,),
                         LoginButtonWithGradient(
                           borderRadius: BorderRadius.circular(3),
                           color: AppColors.mainColor,child: const Center(child: Padding(
                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                           child: Text("25% Off",style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.w600),),
                         )),)
                       ],
                     ),
                     const SizedBox(height: 8,),
                     const Text("Delivery by 26 Jan",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),),
                     const SizedBox(height: 8,),
                     const Text("Return applicable*",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: AppColors.darkGreenColor),),
                     const SizedBox(
                       height: 10,
                     ),
                     // const Spacer(),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Container(
                             padding: const EdgeInsets.symmetric(vertical: 4),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(4),
                                 color: Colors.grey.shade300),
                             child:selectSize),
                         const SizedBox(
                           width: 20,
                         ),
                         Quantity(
                           quantityDecrease: () => quantityDecrease!(),
                           quantityIncreament: () => quantityIncreament!(),
                           value: value,
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
             ],),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  // splashColor: Colors.transparent,
                    onTap:remove ,
                    child: const ImageIcon(AssetImage("assets/cross.png"),size: 20,)),
              ),
            ]),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Text("View Similar Products",style: TextStyle(color: AppColors.mainColor),),
            Icon(Icons.arrow_forward_ios_outlined,size: 20,),
              SizedBox(width: 15,)
          ],),
          const SizedBox(height: 10,),
          const SizedBox(
              height: 0,
              width: double.infinity,
              child: Divider(color: Colors.grey)),
        ],
      ),
    );
  }
}

