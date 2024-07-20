import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vFASHU/screens/all_bottom_navigation/home/tabbar/women_tab.dart';
import 'package:vFASHU/screens/all_pages/notification_page.dart';
import 'package:vFASHU/screens/all_pages/search_page.dart';
import 'package:vFASHU/utils/constant_color.dart';
import 'package:vFASHU/widgets/common/buttons.dart';

import '../../../utils/apis.dart';
import '../../all_pages/show_product_list.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  static String id = "home_page";

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  Map<String, dynamic> _data = {};
  List<dynamic> _categories = [];
  List<dynamic> _brands = [];
  List<dynamic> _topTrndingCatagoris = [];
  bool isLoading = true;
  List horizontalList = ["Dresses", "T-Shirts", "Nightwear", "Sportswear"];

  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    ApiServisces().homePage().then((data) {
      setState(() {
        _data = data["data"];
        _categories = data['data']["category"];
        _topTrndingCatagoris = _data["top_trending_category"];
        _brands = _data["barnds"];
        if (kDebugMode) {
          print("top trending $_topTrndingCatagoris");
          print(_data);

          print("brand$_brands");
        }
        // _tabController = TabController(length: _categories.length, vsync: this);
        isLoading = false;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "VfashU",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor),
          ),
          centerTitle: false,
          leading: const Padding(
              padding: EdgeInsets.only(
                left: 10.0,
              ),
              child: Image(
                image: AssetImage("assets/logo.png"),
                height: 18,
                width: 18,
              )),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child:
                // isLoading
                //     ? const Text("")
                //     :
                Column(
              children: [
                TabBar(
                  unselectedLabelColor: Colors.grey,
                  padding: const EdgeInsets.only(left: 0, right: 20),
                  labelColor: Colors.black,
                  controller: _tabController,
                  indicatorColor: const Color(0xFFB08E6E),
                  indicatorWeight: 5,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  tabs: const [
                    Tab(
                      text: 'Alteration Service',
                    ),
                    Tab(
                      text: 'Designer Consultation Service',
                    ),
                  ],
                  // _categories.map<Widget>((category) {
                  //   return Tab(
                  //     text: category['name'],
                  //   );
                  // }).toList()
                ),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          actions: [
            LoginButtonWithGradient(
              height: 25,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: AppColors.mainColor,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Be Our Partner",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Search_Page.id,
                  );
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.black,
                  // size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Notification_Page.id);
                },
                child: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                  // size: 30,
                ),
              ),
            ),
          ],
        ),
        body:
            // isLoading
            //     ? Constants.loadingIndicator()
            //     :
            TabBarView(controller: _tabController, children: [
          // _categories.map<Widget>((category) {
          //
          //   List<dynamic>? categories = category["child"];
          //   if (category.containsKey("child")) {
          //     if (kDebugMode) {
          //       print("caegoris $categories");
          //     }

          // return
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  circularImage(
                    // itemCount: categories?.length,
                    itemCount: 4,
                    title: (index) => "Dresses",
                    onPress: () {
                      Navigator.pushNamed(context, Product_list.id);
                    },
                    // img: (index) => categories![index]["image"],
                    img: (index) => "assets/top.png",
                  ),
                  // Container(
                  //     height: 35,
                  //     width: double.infinity,
                  //     decoration: const BoxDecoration(
                  //         color: Colors.amber,
                  //         image: DecorationImage(
                  //           image:
                  //           NetworkImage("_data[gif_paceholder"),
                  //           fit: BoxFit.fitWidth,
                  //         ))),
                  const SizedBox(
                    height: 10,
                  ),
                  banner(170, 2, "assets/banner1.png"),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    children: [
                      Text(
                        "Boutiques",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 150,
                          child: Card(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                banner(
                                  110,
                                  5,
                                  "assets/banner2.png",
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  child: const Text(
                                    "Fashion Boutique",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  brandGrid(
                    img: (index) => _brands[index]["image"].toString(),
                    itemCount: _brands.length,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  trndingCategories(
                      // imgUrl: (index) =>
                      // _topTrndingCatagoris[index]["image"],
                      // title: (index) =>
                      // _topTrndingCatagoris[index]["name"],
                      imgUrl: (index) => "assets/banner1.png",
                      title: (index) =>
                          // _topTrndingCatagoris[index]["name"],
                          "",
                      // itemCount: _topTrndingCatagoris.length
                      itemCount: 4)
                ],
              ),
            ),
          ),
          const Center(child: Text("Designer Consultation Service"))
        ]));
    //   SingleChildScrollView(
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 10),
    //     child: Column(
    //       children: [
    //         circularImage(
    //           itemCount: categories?.length,
    //           title: (index) => categories![index]["name"],
    //           onPress: () {
    //             Navigator.pushNamed(context, Product_list.id);
    //           },
    //           img: (index) => categories![index]["image"],
    //         ),
    //         Container(
    //             height: 35,
    //             width: double.infinity,
    //             decoration: BoxDecoration(
    //                 color: Colors.amber,
    //                 image: DecorationImage(
    //                   image:
    //                       NetworkImage(_data["gif_paceholder"]),
    //                   fit: BoxFit.fitWidth,
    //                 ))),
    //         const SizedBox(
    //           height: 10,
    //         ),
    //         banner(170, 2, _data["banner1"]),
    //         const SizedBox(
    //           height: 15,
    //         ),
    //         banner(
    //           140,
    //           5,
    //           _data["banner2"],
    //         ),
    //         const SizedBox(
    //           height: 15,
    //         ),
    //         brandGrid(
    //           img: (index) =>
    //               _brands[index]["image"].toString(),
    //           itemCount: _brands.length,
    //         ),
    //         const SizedBox(
    //           height: 15,
    //         ),
    //         trndingCategories(
    //             imgUrl: (index) =>
    //                 _topTrndingCatagoris[index]["image"],
    //             title: (index) =>
    //                 _topTrndingCatagoris[index]["name"],
    //             itemCount: _topTrndingCatagoris.length)
    //       ],
    //     ),
    //   ),
    // );
    // } else {
    //   return Center(child: Text("data"));
    // }
    // }).toList()));
//     body:
//     isLoading
//         ? Constants.loadingIndicator()
//         : TabBarView(
//             controller: _tabController,
//             children: _categories.map<Widget>((category) {
//               List<dynamic>? categories = category["child"];
//               if (category.containsKey("child")) {
//                 print("caegoris $categories");
//
//                 return SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Column(
//                       children: [
//                         circularImage(
//                           itemCount: categories?.length,
//                           title: (index) => categories![index]["name"],
//                           onPress: () {
//                             Navigator.pushNamed(context, Product_list.id);
//                           },
//                           img: (index) => categories![index]["image"],
//                         ),
//                         Container(
//                             height: 35,
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                                 color: Colors.amber,
//                                 image: DecorationImage(
//                                   image: NetworkImage(_data["gif_paceholder"]),
//                                   fit: BoxFit.fitWidth,
//                                 ))),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         banner(170, 2, _data["banner1"]),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         banner(
//                           140,
//                           5,
//                           _data["banner2"],
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         brandGrid(
//                           img: (index) => _brands[index]["image"].toString(),
//                           itemCount: _brands.length,
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         trndingCategories(
//                             onTab: (index) {
//                               Navigator.pushNamed(context, Product_list.id);
//                             },
//                             imgUrl: (index) =>
//                                 _topTrndingCatagoris[index]["image"],
//                             title: (index) =>
//                                 _topTrndingCatagoris[index]["name"],
//                             itemCount: _topTrndingCatagoris.length)
//                       ],
//                     ),
//                   ),
//                 );
//               } else {
//                 return Center(child: Text("data"));
//               }
//             }).toList());
  }
}
