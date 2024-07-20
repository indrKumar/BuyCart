import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vFASHU/models/catdatamodel.dart';
import 'package:vFASHU/utils/apiservices.dart';
import 'package:vFASHU/utils/constant_color.dart';

import '../../../models/productlistmodel.dart';
import '../../all_pages/product_dtails.dart';
import '../favorite_page.dart';

class Categories_page extends StatefulWidget {
  const Categories_page({super.key});

  @override
  State<Categories_page> createState() => _Categories_pageState();
}

class _Categories_pageState extends State<Categories_page>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;

  List<String> cardNames = [
    'Brands',
    'Influenceres',
    'Beauty',
    'Clothing',
    'Dresses',
    "Accessories",
    "Topweare",
    "Footwear",
    "Bags",
  ];

  bool isSlected = true;
  bool isLoading = true;
  bool isProLoading = true;
  late final TabController _tabController;
  List<Category> _categories = [];
  List<Category> _oldCategories = [];
  List<Product> _productList = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  // int _number = 131;
  // int _factorial = 0;
  // void _calculateFactorial() {
  //   setState(() {
  //     _factorial = factorial(_number);
  //     print('The factorial of $_number is: $_factorial');
  //   });
  // }
  //
  // int factorial(int n) {
  //   if (n == 0) {
  //     return 1;
  //   } else {
  //     return n * factorial(n - 1);
  //   }
  // }
  Future<void> _fetchCategories() async {
    try {
      final categories = await ApiService().getCategories();
      setState(() {
        if (_categories.isEmpty) {
          _categories = categories!.data.categories;
          _tabController = TabController(
              length: _categories.length, vsync: this, initialIndex: 0);
          _fetchProduct(
              _categories[selectedIndex].subcategories[selectedIndex].id);
        } else {
          if (!_areCategoriesEqual(_categories, categories!.data.categories)) {
            _oldCategories = _categories;
            _categories = categories.data.categories;
            _tabController = TabController(
                length: _categories.length, vsync: this, initialIndex: 0);
          }
        }
        isLoading = false;
      });
    } catch (e) {
      print('An error occurred: $e');
      Future.delayed(const Duration(seconds: 1)).then(
        (value) {
          // setState(() {
          isLoading = false;
          // });
        },
      );
    }
  }

  Future<void> _fetchProduct(id) async {
    setState(() {
      isProLoading = true;
    });
    await ApiService().getProductList(id: id).then(
      (value) {
        if (value.success == true) {
          setState(() {
            _productList = value.data.products;
            isProLoading = false;
          });
        } else {
          Future.delayed(const Duration(seconds: 1)).then(
            (value) {
              setState(() {
                isProLoading = false;
              });
            },
          );
        }
      },
    );
    // setState(() {
    // });
  }

  Future addToCart({product_id, size, qty}) async {
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
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Product Added Successfully")));
          });
        }else{
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(value.message.toString())));
          });
        }
        print(value!.message);
      },
    );
  }

  bool _areCategoriesEqual(
      List<Category> oldCategories, List<Category> newCategories) {
    if (oldCategories.length != newCategories.length) return false;
    for (int i = 0; i < oldCategories.length; i++) {
      if (oldCategories[i].id != newCategories[i].id ||
          oldCategories[i].name != newCategories[i].name ||
          oldCategories[i].description != newCategories[i].description) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(_categories.length);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
          ),
          child: SizedBox(
            height: 50,
            child: TextField(
              cursorColor: Colors.green,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  focusColor: Colors.black,
                  filled: true,
                  hintText: "what are you looking for?",
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintStyle: const TextStyle(fontSize: 15),
                  iconColor: Colors.black,
                  border:
                      const OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 15),
            child: GestureDetector(
              onTap: () {
                // _calculateFactorial();
                Navigator.pushNamed(context, Favorite_page.id);
              },
              child: const Icon(
                Icons.favorite_border,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: isLoading
              ? const Text("")
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 50),
                      child: SizedBox(
                        width: double.infinity,
                        child: TabBar(
                          onTap: (value) {
                            _fetchProduct(_categories[value]
                                .subcategories[selectedIndex]
                                .id);
                          },
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          physics: const AlwaysScrollableScrollPhysics(),
                          automaticIndicatorColorAdjustment: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.black,
                          controller: _tabController,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          isScrollable: true,
                          tabs: _categories.map<Widget>(
                            (e) {
                              print(e.name);
                              return Padding(
                                padding: EdgeInsets.zero,
                                child: Tab(
                                  text: e.name,
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                      color: Colors.grey,
                    )
                  ],
                ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: _categories.map<Widget>((category) {
                List<Subcategory> subcategories = category.subcategories;

                if (subcategories.isNotEmpty) {
                  print("IS NOT EMPTY");
                  for (var subCat in subcategories) {
                    print(subCat.id);
                  }
                } else {
                  print("Empty");
                }

                return Row(
                  children: [
                    Container(
                      width: 120,
                      height: double.infinity,
                      color: Colors.grey.shade300,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: subcategories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                _fetchProduct(subcategories[selectedIndex].id);
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: selectedIndex == index
                                      ? Colors.white
                                      : Colors.grey.shade300,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      subcategories[index].name,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    isProLoading == true
                        ? Expanded(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade400,
                              highlightColor: Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                    mainAxisExtent: 300,
                                  ),
                                  itemCount: 5,
                                  itemBuilder: (_, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Product_dtails(
                                              productId: "2",
                                              // children[index]['id'].toString(
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    // NetworkImage(children[index]['image']),
                                                    AssetImage(
                                                        "assets/girl.png"),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            height: 200,
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                height: 15,
                                                width: 40,
                                                color: Colors.grey,
                                              )),
                                              const SizedBox(
                                                width: 40,
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                border: Border.all(
                                                    color: const Color(
                                                        0xFFABABAB))),
                                            child: const Center(
                                                child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 9),
                                            )),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    decoration: const BoxDecoration(
                                        color: Colors.black),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              endIndent: 3,
                                              indent: 3,
                                              thickness: 2,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              "VIEW ALL",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              endIndent: 3,
                                              indent: 3,
                                              thickness: 2,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "CATEGORIES TO EXPLORE",
                                    style: TextStyle(
                                        color: Color(0xFFc0a68e), fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 10,
                                        crossAxisCount: 2,
                                        mainAxisExtent: 300,
                                      ),
                                      itemCount: _productList.length,
                                      itemBuilder: (_, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Product_dtails(
                                                  productId:
                                                      _productList[index].id,
                                                  // children[index]['id'].toString(
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image:
                                                        // NetworkImage(children[index]['image']),
                                                        AssetImage(
                                                            "assets/girl.png"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                height: 200,
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Expanded(
                                                    child: Text(
                                                      // "SAR ${_data[index]["price"]}",
                                                      "SAR 20",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                  ),
                                                  LikeButton(
                                                    likeBuilder:
                                                        (bool isLiked) {
                                                      return Icon(
                                                        isLiked
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color: isLiked
                                                            ? Colors.red
                                                            : Colors.grey,
                                                        size: 20,
                                                      );
                                                    },
                                                    circleColor:
                                                        const CircleColor(
                                                      start: Color(0xff00ddff),
                                                      end: Color(0xff0099cc),
                                                    ),
                                                    bubblesColor:
                                                        const BubblesColor(
                                                      dotPrimaryColor:
                                                          Color(0xff33b5e5),
                                                      dotSecondaryColor:
                                                          Color(0xff0099cc),
                                                    ),
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                // children[index]["name"],
                                                "Styli Satin V Neck Regular Fit...",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  addToCart(
                                                      size: "",
                                                      qty: 1,
                                                      product_id:
                                                          _productList[index]
                                                              .id);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.mainColor,
                                                      border: Border.all(
                                                          color: AppColors
                                                              .mainColor)),
                                                  child: const Center(
                                                      child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 9),
                                                    child: Text(
                                                      "Add to Cart",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // GridView.builder(
                                  //   physics: const NeverScrollableScrollPhysics(),
                                  //   shrinkWrap: true,
                                  //   itemCount: 5,
                                  //   itemBuilder: (context, index) {
                                  //     return Padding(
                                  //       padding: const EdgeInsets.symmetric(
                                  //           horizontal: 5, vertical: 3),
                                  //       child: GestureDetector(
                                  //         onTap: () {
                                  //           Navigator.push(
                                  //             context,
                                  //             MaterialPageRoute(
                                  //               builder: (context) =>
                                  //                   const Product_dtails(
                                  //                 productId: "2",
                                  //               ),
                                  //             ),
                                  //           );
                                  //         },
                                  //         child: Container(
                                  //           decoration: const BoxDecoration(
                                  //             image: DecorationImage(
                                  //               image: AssetImage("assets/girl.png"),
                                  //             ),
                                  //           ),
                                  //           child: const Center(
                                  //             child: Text(
                                  //               "TOPWEAR",
                                  //               style: TextStyle(
                                  //                 color: Colors.white,
                                  //                 fontSize: 13,
                                  //                 fontWeight: FontWeight.w500,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  //   gridDelegate:
                                  //       const SliverGridDelegateWithFixedCrossAxisCount(
                                  //     crossAxisCount: 2,
                                  //     mainAxisExtent: 140,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                  ],
                );
              }).toList(),
            ),
    );
  }
}
