import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vFASHU/utils/constant_color.dart';
import '../../../models/cartdetailsmodel.dart';
import '../../../utils/apis.dart';
import '../../../utils/apiservices.dart';
import '../../../utils/utils.dart';
import '../../../widgets/booking_cart.dart';
import '../../../widgets/common/buttons.dart';
import '../../all_pages/my_acoount/payment.dart';
import '../favorite_page.dart';

class BagePage extends StatefulWidget {
  const BagePage({Key? key}) : super(key: key);
  static String id = "BagPAge";

  @override
  State<BagePage> createState() => _BagePageState();
}

class _BagePageState extends State<BagePage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = -1;
  String selectedSize = '';
  String showSelected = 'S';
  List<String> sizeList = ["S", "M", "L", "XL", "XXL"];
  TextEditingController couponCodeController = TextEditingController();

  bool _isLoadingPrice = false;
  bool isLoading = true;

  // late TabController _tabController;

  int value = 0;
  int AED = 10;

  void incrementValue(int index) {
    _isLoadingPrice = true;
    setState(() {
      value = items[index]["qty"]++;
      value++;

      if (kDebugMode) {
        print("current value$value");
      }
    });
    ApiServisces()
        .updateCartItem(
      items[index]["item_id"],
      value,
      items[index]["product_id"],
    )
        .then((value) {
      // _getCartList();
      _isLoadingPrice = false;
      log("sghgshahsba$value");
    });
  }

  void decrementValue(int index) {
    _isLoadingPrice = true;
    setState(() {
      value = items[index]["qty"]--;
      value--;
    });
    ApiServisces()
        .updateCartItem(
      items[index]["item_id"],
      value,
      items[index]["product_id"],
    )
        .then((value) {
      log("Update$value");
      // _getCartList();
      _isLoadingPrice = false;
    });
  }

  List<CartItem> _categories = [];

  Future<void> _fetchCartList() async {
    print("object");
    await ApiService().getCart().then(
      (value) {
        print(value!.data.cart);
        if (value!.success == true) {
          setState(() {
            _categories = value.data.cart;
            isLoading = false;
          });
        } else {
          Future.delayed(Duration(seconds: 2)).then(
            (value) {
              setState(() {
                isLoading = false;
              });
            },
          );
        }
      },
    );
  }

  Future<void> _remove(int index) async{
    setState(() {
      isLoading = true;
    });
   await ApiService().deleteCart(productId: _categories[index].productId).then(
      (value) {
        print("objectsjshdhjshjdhsgd");
        if(value["success"] == true){
          setState(() {
            _fetchCartList();
          });
        }else{

        }

      },
    );
  }


  List<dynamic> getCoupunDtails = [];

  void _getCoupons() {
    ApiServisces().getCopuns().then((value) {
      setState(() {
        getCoupunDtails = value["data"];
      });
      print(getCoupunDtails);
    });
  }

  String isApply = '';

  void _applyCode() {
    ApiServisces().applyCoupon(couponCodeController.text).then((value) {
      isApply = value.toString();
      print(value);
    });
  }
// late String grandtotal;
//
// void multiplyValue() {
//   setState(() {
//
//
//
// }

// here call cart list api

  final Map<String, dynamic> _cartList = {};
  List<dynamic> items = [];

  // suggestions
  List<dynamic> _data = [];
  late int controllerLenght = 0;

  // getSuggestionProduct() {
  //   ApiServisces().getSuggestionDataCArt().then((value) {
  //     isLoading = true;
  //     if(value != null){
  //       setState(() {
  //         _data = value["data"];
  //         controllerLenght = _data.length;
  //         // _tabController = TabController(length: controllerLenght, vsync: this);
  //         isLoading = false;
  //       });
  //     }
  //     print("data:::::$controllerLenght");
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    // getSuggestionProduct();
    // _getCartList();
    _fetchCartList();
    // _getCoupons();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement disposea
    couponCodeController.dispose();
    super.dispose();
  }

  String couponCode = '';
  int selectedProductIndex = 0;

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black45),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Cart",
          style: Utils.text20,
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Favorite_page.id);
              },
              child: const Icon(
                Icons.favorite_border,
                color: Colors.black45,
                size: 30,
              ),
            ),
          ),
        ],
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
          // isLoading ? Constants.loadingIndicator(): _cartList["cartcount"] == "0" ? Center(child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text("Your bag is empty"),
          //     SizedBox(height: 8),
          //     LoginButtonWithGradient(
          //       onTap: () {
          //         Navigator.pushNamed(context, Product_list.id);
          //       },
          //       borderRadius: BorderRadius.circular(5),
          //       color: Colors.amber,
          //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          //       child: const Text("Browse Products",
          //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          //     )
          //   ],
          // )) :
          isLoading
              ? Constants.loadingIndicator()
              : SingleChildScrollView(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _categories.length,
                      // itemCount: items.length,
                      itemBuilder: (context, index) {
                        return
                            // isLoading ? const Text("data") :
                            Booking_Cart(
                          value: 2,
                          // value: items[index]["qty"],
                          color: Colors.red,
                          remove: () {
                            _remove(index);
                          },
                          quantityDecrease: () => decrementValue(index),
                          quantityIncreament: () => incrementValue(index),
                          imgUrl: "assets/girl.png",
                          // change image type assets to netswork
                          // imgUrl: items[index]["image"],
                          title: "Women`s Traditional cotton ",
                          // title: items[index]['name'],
                          price: "INR 200 ",
                          // price: "SAR ${items[index]['price']}",
                          selectSize: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter sheetState) {
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
                                          SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: double.infinity,
                                            child: ListView.builder(
                                                itemCount: sizeList.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  final isSelected =
                                                      selectedSize ==
                                                          sizeList[index];
                                                  return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          sheetState(() {
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
                                                                    .circular(
                                                                        5),
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
                                            color: Colors.amber,
                                            height: 40,
                                            width: double.infinity,
                                            onTap: () {
                                              setState(() {
                                                showSelected = selectedSize;
                                                if (kDebugMode) {
                                                  print(showSelected);
                                                }
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Center(
                                                child: Text("ADD TO BAG")),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 2, left: 8),
                                  child: Text(
                                    showSelected,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Icon(
                                        Icons.keyboard_arrow_down_outlined)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(
                      thickness: 3,
                      height: 0,
                    ),
                    // const SizedBox(height: 100,),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const Text(
                    //         "You May Also Like",
                    //         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    //       ),
                    //       const SizedBox(height: 10),
                    //       SizedBox(
                    //         height: 30,
                    //         child: ListView.builder(
                    //           shrinkWrap: true,
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: _data.length,
                    //           itemBuilder: (context, index) {
                    //             return Padding(
                    //               padding: const EdgeInsets.symmetric(horizontal: 5),
                    //               child: InkWell(
                    //                 onTap: () {
                    //                   setState(() {
                    //                     selectedProductIndex = index;
                    //                     getSuggestionProduct();
                    //                   });
                    //                   print(_data[selectedProductIndex]["name"]);
                    //                 },
                    //                 child: Container(
                    //                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    //                   decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(5),
                    //                     border: Border.all(color: Colors.grey),
                    //                   ),
                    //                   child: Center(
                    //                     child: Text(
                    //                       _data[index]["name"],
                    //                       style: const TextStyle(
                    //                         fontSize: 12,
                    //                         fontWeight: FontWeight.normal,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //       SizedBox(height: 10),
                    //       SizedBox(
                    //         width: mediaQuery,
                    //         height: 170,
                    //         child: isLoading
                    //             ? Constants.loadingIndicator()
                    //             :
                    //         _data.isNotEmpty && selectedProductIndex < _data.length ?
                    //         ListView.builder(
                    //           itemCount: _data[selectedProductIndex]["products"].length,
                    //           scrollDirection: Axis.horizontal,
                    //           itemBuilder: (context, index) {
                    //             List<dynamic> products = _data[selectedProductIndex]["products"];
                    //             return Padding(
                    //               padding: const EdgeInsets.only(right: 5),
                    //               child: SizedBox(
                    //                 height: 100,
                    //                 width: 80,
                    //                 child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Stack(
                    //                       children: [
                    //                         InkWell(
                    //                           onTap: () {
                    //                             print("productId:::${products[index]["product_id"]}");
                    //                             Navigator.push(
                    //                               context,
                    //                               MaterialPageRoute(
                    //                                 builder: (context) => Product_dtails(
                    //                                   productId: products[index]['product_id'].toString(),
                    //                                 ),
                    //                               ),
                    //                             );
                    //                           },
                    //                           child: Container(
                    //                             height: 100,
                    //                             color: Colors.grey,
                    //                             width: 80,
                    //                             child: Image(
                    //                               image: NetworkImage(
                    //                                 products[index]["image"][0].toString(),
                    //                               ),
                    //                               fit: BoxFit.cover,
                    //                             ),
                    //                           ),
                    //                         ),
                    //                         Positioned(
                    //                           right: 5,
                    //                           bottom: 6,
                    //                           child: InkWell(
                    //                             onTap: () {
                    //                               setState(() {
                    //                                 isLoading = true;
                    //                               });
                    //                               ApiServisces()
                    //                                   .addToCart(
                    //                                 products[index]["product_id"],
                    //                                 1,
                    //                                 products[index]["product_type"].toString(),
                    //                               )
                    //                                   .then((value) {
                    //                                 print("asd-dd$value");
                    //                                 if (value['status'] == 200) {
                    //                                   setState(() {
                    //                                     isLoading = false;
                    //                                   });
                    //                                 }
                    //                                 print("Add Item $value");
                    //                               });
                    //                             },
                    //                             child: CircleAvatar(
                    //                               radius: 12,
                    //                               backgroundColor: Color(0xFF0B7708),
                    //                               child: Align(
                    //                                 alignment: Alignment.center,
                    //                                 child: Icon(
                    //                                   Icons.add,
                    //                                   color: Colors.white,
                    //                                   size: 16,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     SizedBox(height: 6),
                    //                     Text(
                    //                       "SAR ${products[index]["price"]}",
                    //                       style: TextStyle(
                    //                         fontSize: 13,
                    //                         fontWeight: FontWeight.w700,
                    //                       ),
                    //                     ),
                    //                     SizedBox(height: 1),
                    //                     Text(
                    //                       products[index]["name"].toString(),
                    //                       style: TextStyle(
                    //                         fontSize: 13,
                    //                       ),
                    //                       overflow: TextOverflow.ellipsis,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         ):Text(""),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // Divider(thickness: 3,
                    //   height: 0,),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            "Apply coupon/Voucher code",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 40,
                                    width: mediaQuery * 0.9,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.local_offer_outlined,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 8),
                                          // Adjust the spacing between prefix and input field
                                          Flexible(
                                            child: TextField(
                                              controller: couponCodeController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    'What are you looking for?',
                                                hintStyle: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          isApply != null
                                              ? GestureDetector(
                                                  onTap: () {
                                                    _applyCode();
                                                  },
                                                  child: const Text(
                                                    "APPLY",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ))
                                              : GestureDetector(
                                                  onTap: () {
                                                    ApiServisces()
                                                        .removeCopuns(
                                                            couponCodeController
                                                                .text)
                                                        .then((value) {
                                                      if (kDebugMode) {
                                                        print(value);
                                                      }
                                                    });
                                                  },
                                                  child: const Text(
                                                    "REMOVE",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: mediaQuery,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: getCoupunDtails.length,
                                      itemBuilder: (context, index) {
                                        final coupon = getCoupunDtails[index];
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              couponCodeController.text =
                                                  coupon['coupon'];
                                              couponCode =
                                                  couponCodeController.text;
                                              getCoupunDtails.removeAt(index);
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: Container(
                                              height: 30,
                                              width: mediaQuery * 0.9,
                                              color: Colors.blue.shade400,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          getCoupunDtails[index]
                                                              ['name'],
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text(
                                                          getCoupunDtails[index]
                                                              ['description'],
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 25,
                                                          width: 45,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white)),
                                                          child: Center(
                                                              child: Text(
                                                            getCoupunDtails[
                                                                        index]
                                                                    ['coupon']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "Tab to Apply",
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              ]),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total MRP",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700),
                                  ),
                                  _cartList["subtotal"] != null
                                      ? Text(
                                          "SAR ${_cartList['subtotal'].toString()}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey.shade700),
                                        )
                                      : Text(
                                          "INR 4,998",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey.shade700),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount on MRP",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    "INR 1,000",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Shipping Fee",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    "INR 69",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Platform Fee",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    "INR 10",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700),
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text("Shipping Fee", style: TextStyle(
                              //         fontSize: 13, color: Colors.grey.shade700),),
                              //     const Text(
                              //       "Free",
                              //       // _cartList['shipping_cost'].toString(),
                              //       style: TextStyle(
                              //           fontSize: 13, color: AppColors.darkGreenColor),),
                              //
                              //   ],),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "INR 4,058",
                                    // "${_cartList['getGrandTotal'].toString()}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
      bottomNavigationBar:
          // _cartList["cartcount"] == "0" ? Text("") : isLoading
          //     ? const Text("")
          //     :
          SizedBox(
        // padding: EdgeInsets.zero,
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _isLoadingPrice
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Color(0xff7e7b7b),
                          ))
                      : _cartList["getGrandTotal"] == "null" ||
                              _cartList["getGrandTotal"] == "0"
                          ? const Text("0.00")
                          : const Text("INR 4,058",
                              // "${_cartList["getGrandTotal"].toString()
                              // }",
                              style: TextStyle(fontSize: 18)),
                  LoginButtonWithGradient(
                    onTap: () {
                      Navigator.pushNamed(context, Payment_Page.id);
                    },
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.darkGreenColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: const Text("CHECKOUT",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )
                ]),
          ),
        ),
      ),
    );
  }
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(DiagnosticsProperty<TabController>('_tabController', _tabController));
//   }
// }
}

Widget sizedPickCategory() {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
            "S",
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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

//
// if (response.statusCode == 200) {
// setState(() {
// suffixText = "Coupon Applied!";
// getCouponDetails.clear();
// });
// } else {
// setState(() {
// suffixText = "Apply";
// showDialog(
// context: context,
// builder: (context) {
// return AlertDialog(
// title: Text("Coupon Error"),
// content: Text("Invalid coupon code. Please try again."),
// actions: [
// TextButton(
// onPressed: () {
// Navigator.of(context).pop();
// },
// child: Text("OK"),
// ),
// ],
// );
// },
// );
// });
// }
