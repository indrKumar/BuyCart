import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vFASHU/widgets/common/buttons.dart';

import '../../utils/constant_color.dart';

class RateProductPage extends StatelessWidget {
  const RateProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rate Product",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(15),
          child: Divider(
            color: Colors.grey.shade300,
            height: 2,
            thickness: 3,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Women`s Traditional cotton ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("Black")
                  ],
                ),
                Image(
                  image: AssetImage("assets/girl.png"),
                  height: 90,
                  width: 90,
                )
              ],
            ),
            const Divider(),
            RatingBar(
              itemSize: 30,
              ratingWidget: RatingWidget(
                full: const Icon(Icons.star, color: AppColors.darkGreenColor),
                half: const Icon(Icons.star_half, color: Colors.grey),
                empty: const Icon(Icons.star_border, color: Colors.grey),
              ),
              onRatingUpdate: (rating) {
                // Handle rating update here
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              maxLines: null, // set to null for unlimited lines
              minLines: 6, // set minimum lines
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Enter your text here',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30,),

            GestureDetector(
              onTap: () {},
              child: const Row(
                children: [
                  Icon(Icons.add),
                  Text(
                    "Upload Image",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            const Image(image: AssetImage("assets/girl.png"),height: 70,width: 70,),
            const SizedBox(height: 30,),
            LoginButtonWithGradient(
              height: 40,

              width: double.infinity,
              color: Color(0xFF632D8F),
              child: Center(child: Text("Rate Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),)),
            )
          ],
        ),
      ),
    );
  }
}
