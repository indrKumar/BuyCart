import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vFASHU/utils/constant_color.dart';

import '../../utils/apis.dart';
import '../../utils/utils.dart';
import '../all_pages/product_dtails.dart';

class Favorite_page extends StatefulWidget {
  const Favorite_page({super.key});
  static String id = "favorite";

  @override
  State<Favorite_page> createState() => _Favorite_pageState();
}

class _Favorite_pageState extends State<Favorite_page> {
  int selectedIndex = -1;
  String selectedSize = '';
  String showSelected = 'S';

  List<String> cardNames = [
    'Card 1',
    'Card 2',
    'Card 3',
    'Card 4',
    'Card 5',
  ];
  List<String> sizeList = ["S", "M", "L", "XL", "XXL"];
  List<dynamic> listOfData = [];
bool isLoading = false;
  void getWishlist() {
    setState(() {
      isLoading = true;
    });
    ApiServisces().getWishList().then((value) {
      setState(() {
        listOfData = value["data"];
        isLoading = false;
      });
  if(kDebugMode){
    print("vsloo:::$listOfData");
    print("length:::${listOfData.length}");
  }
        });
  }

  @override
  void initState() {
    super.initState();
    getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "My Wishlist",
          style: Utils.text20,
        ),
        centerTitle: false,
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Icon(
        //       Icons.favorite_border,
        //       color: Colors.black,
        //       size: 30,
        //     ),
        //   ),
        // ],
        bottom: const PreferredSize(
          preferredSize: Size.zero,
          child: Divider(
            color: Colors.grey,
            height: 2,
            thickness: 1,
          ),
        ),
      ),
      body:
      // isLoading? Constants.loadingIndicator():
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            mainAxisExtent: 310,
          ),
          itemCount: 10,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Product_dtails(
                        productId: "2",
                        // children[index]['id'].toString(
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                          // NetworkImage(children[index]['image']),
                          AssetImage("assets/girl.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      height: 200,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            // "SAR ${_data[index]["price"]}",
                            "SAR 20",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      // children[index]["name"],
                      "Styli Satin V Neck Regular Fit...",
                      style: TextStyle(
                        fontSize: 11,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.mainColor,
                          border: Border.all(color: const Color(0xFFABABAB))),
                      child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 9),
                            child: Text(
                              "Add to Cart",
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}