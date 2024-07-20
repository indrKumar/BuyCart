import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:vFASHU/screens/all_pages/rate_product.dart';
import 'package:vFASHU/utils/constant_color.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Ratings & Reviews",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RateProductPage(),));
                    },
                   child:const Text("Ratings & Reviews",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Column(
                  children: [
                    RatingBar(
                      itemSize: 30,
                      ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Colors.amber),
                        half: const Icon(Icons.star_half, color: Colors.amber),
                        empty: const Icon(Icons.star_border, color: Colors.amber),
                      ),
                      onRatingUpdate: (rating) {
                        // Handle rating update here
                      },
                    ),
                    const Text("(5.00)")
                  ],
                ),
                const Text("256 Ratings & 89 Reviews",style: TextStyle(fontSize: 14,color: Colors.grey),)
              ],),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
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
                        const SizedBox(width: 40,),
                        const Text("Nice Product",style: TextStyle(
                          fontSize: 12
                        ),)
                      ],
                    ),
                    const Text("Dear user, As you are already aware, we have approached in the final stretch this year and We firmly acknowledge your... Dear user, As you are already aware, we have approached in the final stretch this year and We firmly acknowledge your... ",style: TextStyle(fontSize: 11,fontWeight: FontWeight.normal),),
                    SizedBox(
                      height:90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount:2,
                        itemBuilder: (context, index) {
                        return const Image(image: AssetImage("assets/girl.png"),width: 70,height: 80,);
                      },),
                    )
                ],);
              },)
            ],
          ),
        ),
      ),
    );
  }
}
