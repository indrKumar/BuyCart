import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';
import 'package:vFASHU/models/productdetailsmodel.dart';
import 'package:vFASHU/utils/apiservices.dart';
import 'package:vFASHU/utils/constant_color.dart';
import '../../utils/apis.dart';
import '../../utils/utils.dart';
import '../../widgets/appicons.dart';
import '../../widgets/common/buttons.dart';
import '../all_bottom_navigation/bag_checkout/bag_page.dart';

class Product_dtails extends StatefulWidget {
  final String productId;

  const Product_dtails({super.key, required this.productId});

  static String id = "prodtuct datails";

  @override
  State<Product_dtails> createState() => _Product_dtailsState();
}

class _Product_dtailsState extends State<Product_dtails> {
  Map<String, dynamic> _productData = {};

  late final PageController _pageController;
  double initializeRating = 0;

  late final _ratingController;
  late double _rating;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;

  // bool _isRTLMode = false;
  bool _isVertical = false;

  IconData? _selectedIcon;

  List<String> sizeList = ["S", "M", "L", "XL", "XXL"];

  int _currentPage = 0;
  bool isLoading = true;
  bool loader = false;

  List _image = [];
  List<dynamic> rattinsData = [];
  List<dynamic> productChildData = [];
  List<Product> _proDetails = [];

  Future<void> getDetails() async {
    if (kDebugMode) {
      print("Fetching product details...");
    }
    isLoading = true;
    ApiService().getProductDetails(id: widget.productId).then((value) {
      if (kDebugMode) {
        print("Response received: $value");
      }
      if (value.success == true) {
        _proDetails = [value.data.products];
        if (kDebugMode) {
          print("Product details: ${_proDetails[0].id}");
        }
setState(() {
  isLoading = false;

});
      } else {
        Future.delayed(const Duration(seconds: 2)).then((value) {
setState(() {
  isLoading = false;

});        });
      }
      _pageController = PageController(initialPage: _currentPage);
    });
  }

  Future addToCart({product_id, size, qty}) async {
    setState(() {
      loader = true;
    });
    await ApiService()
        .addToCart(
      product_id: product_id,
      qty: qty,
      size: size,
    )
        .then(
          (value) {
        if (value!.success == true) {
          setState(() {
                    loader = false;
                    Navigator.pushNamedAndRemoveUntil(
                              context,
                              BagePage.id,
                              (route) => true,
                            );
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Product Added Successfully")));
          });
        }else{
          Future.delayed(Duration(seconds: 2)).then((value) {
            setState(() {
              loader = false;
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(value.message.toString())));
            });
          },);

        }
        print(value!.message);
      },
    );
  }
  @override
  void initState() {
    super.initState();
    getDetails();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  // productChildData = _productData["child_products"];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  String selectedSize = '';

  Widget buildSizeButton(String size) {
    // getDetails();
    final isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = isSelected ? '' : size;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade500,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          size,
          style: TextStyle(
            fontSize: 13,
            color: isSelected ? Colors.blue : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double mediaQuery = MediaQuery.of(context).size.width;
    final double mediaQueryh = MediaQuery.of(context).size.height;

    return Scaffold(
      body:
          isLoading?  Center(child: Constants.loadingIndicator()):
          SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // color: Colors.red,
              height: mediaQueryh / 1.4,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      // color: Colors.red,
                      height: mediaQueryh / 1.4,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        itemCount: 5,
                        // itemCount:_image.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: mediaQuery,
                            height: mediaQueryh,
                            decoration: const BoxDecoration(
                              // color: Colors.amber,
                              image: DecorationImage(
                                image: AssetImage("assets/girl.png"),
                                // image: NetworkImage(
                                //     _productData['image'][index].toString()
                                // ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Icon widgets
                  Positioned(
                    top: 45,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: setCustomIcon(),
                          // child: AppIcon(
                          //   icon: Icons.arrow_back_ios_new,
                          //   size: 35,iconSize: 22,
                          //   bgColor: Colors.grey.shade100,
                          // ),
                        ),
                        Row(
                          children: [
                            AppImageIcon(
                              imageUrl: "assets/share.png",
                              size: 35,
                              iconSize: 10,
                              bgColor: Colors.grey.shade100,
                              edginsets: 5,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, BagePage.id);
                              },
                              child: AppImageIcon(
                                imageUrl: "assets/bag.png",
                                size: 35,
                                iconSize: 10,
                                bgColor: Colors.grey.shade100,
                                edginsets: 5,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40 / 2),
                          color: const Color(0xeaf6f5f5),
                        ),
                        child: Center(
                          child: LikeButton(
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLiked ? Colors.red : Colors.grey,
                                size: 20,
                              );
                            },
                            circleColor: const CircleColor(
                                start: Color(0xff00ddff),
                                end: Color(0xff0099cc)),
                            bubblesColor: const BubblesColor(
                              dotPrimaryColor: Color(0xff33b5e5),
                              dotSecondaryColor: Color(0xff0099cc),
                            ),
                            size: 20,
                          ),
                        ),
                      )),
                  // Positioned(
                  //   left: 100,
                  //   bottom: 10,
                  //   right: 100,
                  //   child: Center(
                  //     child: SmoothPageIndicator(
                  //
                  //       effect:  WormEffect(
                  //         dotColor: Colors.grey.shade300,
                  //         activeDotColor: Colors.red,
                  //         dotHeight: 10,
                  //         dotWidth: 10,
                  //       ),
                  //       controller: _pageController,
                  //       count: _image.length,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      // _productData['name'].toString()
                      "VfashU",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      // _productData['name'].toString()
                      _proDetails[0].name,
                      // "CAnvas Sposta  Shoes light weiht nad comrtabke",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                   Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      // _productData['name'].toString()
                      "INR ${_proDetails[0].cost ?? "0"}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                      //       child: Html(
                      //         data:_productData['description'].toString(),
                      //         tagsList: Html.tags..addAll(["bird", "flutter"]),
                      //         style: {
                      //         "li":Style(),
                      //         },
                      // ),
                      ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 7,
              color: Color(0xFFEEEEEE),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Delivery by ",
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 12),
                      ),
                      const Text(
                        "Thy, 6th Apr ",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  const Text(
                    "Riyadh",
                    style: TextStyle(fontSize: 13),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            const Divider(thickness: 7, color: Color(0xFFEEEEEE)),

            //cart color/ size
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Color: ",
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 14)),
                        const Text(
                          "White",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    productChildData != null
                        ? SizedBox(
                            height: 100,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              // itemCount: productChildData.length,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 70,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: const DecorationImage(
                                            image:
                                                AssetImage("assets/girl.png"),
                                            fit: BoxFit.fill)),
                                    // NetworkImage(productChildData[index][""]),fit: BoxFit.fill)),
                                  ),
                                );
                              },
                            ),
                          )
                        : const Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Pick your size",
                            style: TextStyle(fontSize: 15)),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: 200,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Row(children: [
                                          Text("Pick your size",
                                              style: TextStyle(fontSize: 16)),
                                        ]),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: double.infinity,
                                          child: ListView.builder(
                                              itemCount: sizeList.length,
                                              scrollDirection: Axis.horizontal,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                child:
                                                final isSelected =
                                                    selectedSize ==
                                                        sizeList[index];

                                                return Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedSize =
                                                              isSelected
                                                                  ? ''
                                                                  : sizeList[
                                                                      index];
                                                        });
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 8,
                                                                vertical: 3),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: isSelected
                                                                ? Colors.blue
                                                                : Colors.grey
                                                                    .shade500,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Text(
                                                          sizeList[index],
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                            color: isSelected
                                                                ? Colors.blue
                                                                : Colors.grey
                                                                    .shade700,
                                                          ),
                                                        ),
                                                      ),
                                                    ));
                                              }),
                                        ),
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        LoginButtonWithGradient(
                                          color: const Color(0xFF0B7708),
                                          height: 40,
                                          width: double.infinity,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Center(
                                              child: Text(
                                            "ADD TO BAG",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        )
                                      ],
                                    ),
                                  );
                                });
                              },
                            );
                          },
                          child: const Row(
                            children: [
                              Text("Size Chart",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                              Icon(Icons.keyboard_arrow_down_outlined)
                            ],
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: sizeList.length,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildSizeButton(sizeList[index]));
                  }),
            ),
            const Divider(thickness: 7, color: Color(0xFFEEEEEE)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Image(image: AssetImage("assets/youtub.png")),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Measurement Guide",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(onPressed: () {}, child: const Text("Watch Video"))
                ],
              ),
            ),
            const Divider(thickness: 7, color: Color(0xFFEEEEEE)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Product Information",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                          border: const TableBorder.symmetric(),
                          defaultColumnWidth:
                              FixedColumnWidth(mediaQuery / 1.7),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                              children: const [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Product Code:"),
                                  ),
                                ),
                                Text("34567898765"),
                              ],
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200),
                            ),
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Brand Name:"),
                                  ),
                                ),
                                Text("Styli"),
                              ],
                              // decoration: BoxDecoration(color: Colors.grey[200]),
                            ),
                            TableRow(
                              children: const [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Material Composition:"),
                                  ),
                                ),
                                Text("100% Polyester"),
                              ],
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200),
                            ),
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Product Type:"),
                                  ),
                                ),
                                Text("Wrap"),
                              ],
                              // decoration: BoxDecoration(color: Colors.grey[200])
                            ),
                            TableRow(
                              children: const [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Pattern Type"),
                                  ),
                                ),
                                Text("Plain"),
                              ],
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200),
                            ),
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Fit:"),
                                  ),
                                ),
                                Text("Regular"),
                              ],
                              // decoration: BoxDecoration(color: Colors.grey[200])
                            ),
                            TableRow(
                              children: const [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Fabric::"),
                                  ),
                                ),
                                Text("Polyester"),
                              ],
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(thickness: 7, color: Color(0xFFEEEEEE)),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Ratings",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      RatingBar(
                        initialRating: initializeRating,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 23.0,
                        ratingWidget: RatingWidget(
                          full: Icon(Icons.star, color: Colors.amber),
                          half: Icon(Icons.star_half, color: Colors.amber),
                          empty: Icon(Icons.star_border, color: Colors.amber),
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            initializeRating = rating;
                          });
                          // Handle the rating update here
                          ApiServisces()
                              .ratting(widget.productId, rating)
                              .then((value) {
                            print("ratting response::$value");
                          });
                          print(rating);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        initializeRating.toString(),
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: SizedBox(
                      height: 110,
                      width: 150,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: rattinsData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Text(
                                  rattinsData[index]["rating_no"].toString(),
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                    child: Divider(
                                  color: Colors.greenAccent,
                                  thickness: 1,
                                )),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${rattinsData[index]["rating_per"].toString()}%",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.grey),
                                ),
                              ],
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 7,
              color: Color(0xFFEEEEEE),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageIcon(AssetImage("assets/security.png")),
                          SizedBox(
                            height: 3,
                          ),
                          Text("Safe packaging",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          Center(
                              child: Text(
                            "Orders are sanitized and packed",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                            textAlign: TextAlign.center,
                          ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 80,
                    width: 1,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Flexible(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ImageIcon(AssetImage("assets/return.png")),
                          SizedBox(
                            height: 3,
                          ),
                          Text("Easy returns",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "15 days easy return.",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Return Details",
                            style: TextStyle(
                              color: Color(0xFFB08E6E),
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      bottomNavigationBar: Card(
        shadowColor: Colors.grey,
        elevation: 5,
        margin: EdgeInsets.zero,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // isLoading? Card():Text("SAR ${_productData['price'].toString()}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),) ,
                  LoginButtonWithGradient(
                    onTap: () {
                      setState(() {
                        loader = true;
                      });
                      ApiServisces()
                          .addToCart(widget.productId, 1,
                              _productData["product_type"].toString())
                          .then((value) {
                        print("asd-dd$value");
                        if (value['status'] == 200) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            BagePage.id,
                            (route) => true,
                          );
                          setState(() {
                            loader = false;
                          });
                        }
                        print("Add Item $value");
                      });
                    },
                    color: const Color(0xFF646464),
                    width: 170,
                    height: 40,
                    child: loader
                        ? Constants.loadingIndicator()
                        : const Center(
                            child: Text(
                            "ADD TO WISHLIST",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.white),
                          )),
                  ),
                  LoginButtonWithGradient(
                    onTap: () {
                    addToCart(product_id: widget.productId.toString(),qty: 1);
                      // ApiServisces()
                      //     .addToCart(widget.productId, 1,
                      //         _productData["product_type"].toString())
                      //     .then((value) {
                      //   print("asd-dd$value");
                      //   if (value['status'] == 200) {
                      //     Navigator.pushNamedAndRemoveUntil(
                      //       context,
                      //       BagePage.id,
                      //       (route) => true,
                      //     );
                      //     setState(() {
                      //       loader = false;
                      //     });
                      //   }
                      //   if (kDebugMode) {
                      //     print("Add Item $value");
                      //   }
                      // });
                    },
                    color: AppColors.mainColor,
                    width: 170,
                    height: 40,
                    child: loader
                        ? Constants.loadingIndicator()
                        : const Center(
                            child: Text(
                            "ADD TO BAG",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.white),
                          )),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Icon setCustomIcon() {
    if (Platform.isAndroid) {
      // Return the iOS icon for Android
      return const Icon(Icons.arrow_back); // Replace with your desired iOS icon
    } else if (Platform.isIOS) {
      // Return the Android icon for iOS
      return const Icon(Icons
          .arrow_back_ios_new_outlined); // Replace with your desired Android icon
    }
    // Return a default icon if the platform is unknown
    return const Icon(Icons.help); // Replace with your desired default icon
  }
}

class sizedPickCategory extends StatefulWidget {
  const sizedPickCategory({Key? key}) : super(key: key);

  @override
  State<sizedPickCategory> createState() => _sizedPickCategoryState();
}

class _sizedPickCategoryState extends State<sizedPickCategory> {
  String selectedSize = '';

  void selectSize(String size) {
    setState(() {
      selectedSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade500),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                "S",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              "M",
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              "L",
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              "XL",
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              "XXL",
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
          ),
        ),
      ],
    );
  }
}
