import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
import 'package:vFASHU/screens/all_pages/product_dtails.dart';
import 'package:vFASHU/screens/all_pages/search_page.dart';
import '../../widgets/common/buttons.dart';
import '../all_bottom_navigation/bag_checkout/bag_page.dart';
import '../all_bottom_navigation/favorite_page.dart';

class Product_list extends StatefulWidget {
  const Product_list({
    super.key,
  });

  static String id = "product_list";

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<Product_list> {
  int pageNum = 1;
  String selectedCategory = '';
  List<Map<String, dynamic>> selectedCategoryData = [];

  List<Map<String, dynamic>> _data = [];
  List<Map<String, dynamic>> _topCategory = [];
  List<dynamic> children = [];

  Future<List<List<Map<String, dynamic>>>> _callAPIToGetListOfData() async {
    isLoading = true;
    final responseDic = await http.get(
      Uri.parse(_groupValue == null
          ? "http://dev.teckhubsolutions.com/mobapi/api/Productlist"
          : "http://dev.teckhubsolutions.com/mobapi/api/Productlist?price_filter=$_groupValue"),
      headers: {
        'Authorization': 'Bearer o12ksu73evhg3dw0szea8lnl0zkwnzzn',
        'Content-Type': 'application/json',
      },
    );
    Map<String, dynamic> dicOfRes = json.decode(responseDic.body);
    List<Map<String, dynamic>> temArr =
        List<Map<String, dynamic>>.from(dicOfRes["data"]["products"]);
    List<Map<String, dynamic>> topCategory =
        List<Map<String, dynamic>>.from(dicOfRes["data"]["category"]);

    print(temArr);
    print(dicOfRes);

    if (dicOfRes != null) {
      if (pageNum == 1) {
        _data = temArr;
        _topCategory = topCategory;
      } else {
        _data.addAll(temArr);
      }
    }
    print("_top::::$_topCategory");
    return [_data, _topCategory];
  }

  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(_scrollListener);
    print("gr::::::::$_groupValue");
    _callAPIToGetListOfData().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter <= 0 && !isLoading) {
      _callAPIToGetListOfData();
      // .then((data) {
      // setState(() {});
      // });
    }
  }

  bool checkBoxSelect = false;
  final int _perPage = 10; // Number of items to fetch per page
  int _currentPage = 1; // Current page index

  ScrollController _scrollController = ScrollController();
  bool isLoading = true;
  String _groupValue = "";

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      selectedCategoryData = _topCategory
          .where((item) => item['name'] == selectedCategory)
          .toList();
      children = selectedCategoryData.isNotEmpty
          ? selectedCategoryData[0]['child']
          : [];
    });
    print(selectedCategory);
  }

  void _refreshData() {
    _callAPIToGetListOfData().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
          title: ListTile(
            contentPadding: const EdgeInsets.only(right: 10),
            title: const Text(
              "TopWear",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "1951 ITEM FOUND",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, BagePage.id);
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, BagePage.id);
                },
                child: const ImageIcon(
                  AssetImage("assets/bag.png"),
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Favorite_page.id);
              },
              child: const Icon(
                Icons.favorite_border,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Search_Page.id);
              },
              child: const ImageIcon(
                AssetImage("assets/find.png"),
                size: 30,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(5),
            child: Divider(
              height: 0,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 30,
                child: ListView.builder(
                  // itemCount: _topCategory.length,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onTap: () {
                          onCategorySelected(_topCategory[index]['name']);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: const Center(
                            child: Text(
                              "Tops",
                              // _topCategory[index]["name"],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child:
                    // selectedCategory.isNotEmpty
                    //     ?
                    Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  mainAxisExtent: 300,
                ),
                itemCount: 10,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Product_dtails(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
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
                            LikeButton(
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
                                end: Color(0xff0099cc),
                              ),
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
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
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFABABAB))),
                          child: const Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 9),
                            child: Text(
                              "Add to Cart",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          )),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
                //     :FutureBuilder<List<List<Map<String, dynamic>>>>(
                //   future: _callAPIToGetListOfData(),
                //   builder: (BuildContext context, AsyncSnapshot<List<List<Map<String, dynamic>>>> snapshot) {
                //     switch (snapshot.connectionState) {
                //       case ConnectionState.none:
                //       case ConnectionState.active:
                //       case ConnectionState.waiting:
                //         return Center(child: Constants.loadingIndicator());
                //       case ConnectionState.done:
                //         if (snapshot.hasError) {
                //           return Text('You have some error: ${snapshot.error.toString()}');
                //         } else if (snapshot.hasData) {
                //           isLoading = false;
                //           pageNum++;
                //           List<Map<String, dynamic>>? data = snapshot.data?[0];
                //           List<Map<String, dynamic>>? topCategory = snapshot.data?[1];
                //
                //           print(data);
                //
                //           return Padding(
                //             padding: const EdgeInsets.only(left: 15, right: 15),
                //             child: GridView.builder(
                //               shrinkWrap: true,
                //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //                 crossAxisSpacing: 20,
                //                 mainAxisSpacing: 10,
                //                 crossAxisCount: 2,
                //                 mainAxisExtent: 260,
                //               ),
                //               itemCount: data?.length,
                //               itemBuilder: (_, index) {
                //                 return InkWell(
                //                   onTap: () {
                //                     Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                         builder: (context) => Product_dtails(
                //                           productId: data?[index]['product_id'],
                //                         ),
                //                       ),
                //                     );
                //                   },
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       Container(
                //                         decoration: BoxDecoration(
                //                           image: DecorationImage(
                //                             image: NetworkImage(data?[index]['image'][0]),
                //                             fit: BoxFit.fill,
                //                           ),
                //                         ),
                //                         height: 200,
                //                       ),
                //                       SizedBox(
                //                         height: 6,
                //                       ),
                //                       Row(
                //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                         children: [
                //                           Expanded(
                //                             child: Text(
                //                               "SAR ${data?[index]["price"]}",
                //                               style: TextStyle(
                //                                 fontSize: 12,
                //                                 fontWeight: FontWeight.w500,
                //                                 overflow: TextOverflow.clip,
                //                               ),
                //                             ),
                //                           ),
                //                 LikeButton(
                //                 likeBuilder: (bool isLiked) {
                //                   print(isLiked);
                //                 return Icon(
                //                 isLiked ? Icons.favorite : Icons.favorite_border,
                //                 color: isLiked ? Colors.red : Colors.grey,
                //                 size: 20,
                //                 );
                //                 },
                //                 circleColor: CircleColor(
                //                 start: Color(0xff00ddff),
                //                 end: Color(0xff0099cc),
                //                 ),
                //                 bubblesColor: BubblesColor(
                //                 dotPrimaryColor: Color(0xff33b5e5),
                //                 dotSecondaryColor: Color(0xff0099cc),
                //                 ),
                //                 size: 20,
                //                 onTap: (bool isLiked) async {
                //                   print("jhjgjgjh::::$isLiked");
                //                 if (isLiked) {
                //
                //                 // Make API call to remove from wishlist asynchronously
                //                 // Use appropriate endpoint and parameters
                //                 // Handle response and update UI accordingly
                //                 // await removeItemFromWishlist();
                //                 } else {
                //                   ApiServisces().addFavorite(data?[index]['product_id']).then((value) {
                //                     if(value != null){
                //                       print("add wishlist");
                //                     }
                //                   });
                //                 // Make API call to add to wishlist asynchronously
                //                 // Use appropriate endpoint and parameters
                //                 // Handle response and update UI accordingly
                //                 // await addItemToWishlist();
                //                 }
                //                 return !isLiked;
                //                 },
                //                 ),]),
                //                       Text(
                //                         data?[index]["name"],
                //                         style: TextStyle(
                //                           fontSize: 11,
                //                           overflow: TextOverflow.ellipsis,
                //                           color: Colors.grey.shade400,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 );
                //               },
                //             ),
                //           );
                //         } else {
                //           return Text('No data available');
                //         }
                //     }
                //   },
                // )

                ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Table(
                                      border: TableBorder.symmetric(
                                        inside: BorderSide(
                                            width: 1.0,
                                            color: Colors.grey.shade300),
                                      ),
                                      children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  const Text(
                                                    'Sort',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      // height: 3,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: ImageIcon(
                                                        AssetImage(
                                                            "assets/cross.png"),
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _groupValue = 'discount';
                                                    _refreshData();
                                                    print(_groupValue);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  children: [
                                                    ImageIcon(
                                                      AssetImage(
                                                          "assets/discount.png"),
                                                      size: 18,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      'Discount',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    Spacer(),
                                                    Radio<String>(
                                                      value: 'discount',
                                                      groupValue: _groupValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _groupValue =
                                                              value.toString();
                                                          print(value);
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _groupValue = 'low_to_high';
                                                    _refreshData();
                                                    if (kDebugMode) {
                                                      print(_groupValue);
                                                    }
                                                  });

                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  children: [
                                                    const ImageIcon(
                                                      AssetImage(
                                                          "assets/lowto.png"),
                                                      size: 18,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    const Text(
                                                      'Price - Low to High',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    const Spacer(),
                                                    Radio<String>(
                                                      value: 'low_to_high',
                                                      groupValue: _groupValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _groupValue =
                                                              value.toString();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _groupValue = 'high_to_low';
                                                    _refreshData();
                                                    print(_groupValue);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  children: [
                                                    const ImageIcon(
                                                      AssetImage(
                                                          "assets/highto.png"),
                                                      size: 18,
                                                    ),
                                                    SizedBox(width: 10),
                                                    const Text(
                                                      'Price - High to Low',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    const Spacer(),
                                                    Radio<String>(
                                                      value: 'high_to_low',
                                                      groupValue: _groupValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _groupValue =
                                                              value.toString();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _groupValue = 'popularity';
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    const ImageIcon(
                                                      AssetImage(
                                                          "assets/fire.png"),
                                                      size: 18,
                                                    ),
                                                    SizedBox(width: 10),
                                                    const Text(
                                                      'Popularity',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    Spacer(),
                                                    Radio<String>(
                                                      value: 'popularity',
                                                      groupValue: _groupValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _groupValue =
                                                              value.toString();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _groupValue =
                                                        'new_arrivals';
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    const ImageIcon(
                                                      AssetImage(
                                                          "assets/hanger.png"),
                                                      size: 18,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    const Text(
                                                      'New Arrivals',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    Spacer(),
                                                    Radio<String>(
                                                      value: 'new_arrivals',
                                                      groupValue: _groupValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _groupValue =
                                                              value.toString();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _groupValue = 'ratings';
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .star_border_outlined,
                                                      size: 18,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    const Text(
                                                      'Ratings',
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    Spacer(),
                                                    Radio<String>(
                                                      value: 'ratings',
                                                      groupValue: _groupValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _groupValue =
                                                              value.toString();
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(AssetImage("assets/switch.png")),
                    Text(
                      "SORT",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: Filter(),
                      );
                    },
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(AssetImage("assets/filter.png")),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "FILTER",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class Filter extends StatefulWidget {
  Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool _savePaymentInfo = false;

  int selectedIndex = 0;

  List<String> cardNames = [
    'Brands',
    'Size',
    'Color',
    'Discount',
    'Price',
    "MORE FILTER",
    "Product type",
    "Occasion",
    "Pattern",
  ];
  List<String> filterCheck = [
    "Sneakers(127)",
    "Casual Shoes(289)",
    "Heal Sandals",
    "Flat Sandal(20)",
    "Trainers(12)",
    "Formal Shoes(121)",
    "Flip Flop",
    "Comfort Sandal(21)",
    "Bedroom Slipper(209)",
    "Books(210)"
  ];

  int selectedCheckboxIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(top: 8, left: 20),
                child: Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // InkWell(
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: ImageIcon(
              //         AssetImage("assets/cross.png"),
              //         size: 20,
              //       ),
              //     )),
              const Spacer(),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ImageIcon(
                      AssetImage("assets/cross.png"),
                      size: 20,
                    ),
                  ))
            ]),
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.black54,
          height: 0,
        ),
        Expanded(
          child: Row(children: [
            Container(
              width: 120,
              height: double.infinity,
              color: Colors.grey.shade100,
              child: ListView.builder(
                itemCount: cardNames.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
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
                              cardNames[index],
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.black,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filterCheck.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 10, top: 10, bottom: 3),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                side: BorderSide(color: Colors.grey),
                                value: selectedCheckboxIndex == index,
                                // Compare the index with the selectedCheckboxIndex
                                onChanged: (value) {
                                  setState(() {
                                    if (value!) {
                                      selectedCheckboxIndex =
                                          index; // Update the selectedCheckboxIndex when checkbox is checked
                                    } else {
                                      selectedCheckboxIndex =
                                          -1; // Reset the selectedCheckboxIndex when checkbox is unchecked
                                    }
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              filterCheck[index],
                              style: TextStyle(fontSize: 12),
                            ),
                          ]),
                    );
                  },
                ),
              ),
            )
          ]),
        ),
        Card(
          elevation: 5,
          shadowColor: Colors.grey,
          margin: EdgeInsets.zero,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 40, right: 25, top: 10, bottom: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CLEAR ALL",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  LoginButtonWithGradient(
                    width: 170,
                    height: 45,
                    color: Colors.amber,
                    child: Center(
                        child: Text(
                      "APPLY FILTER",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    )),
                  )
                ]),
          ),
        )
      ],
    );
  }
}
