import 'package:flutter/material.dart';

import '../../../../utils/constant_color.dart';

//
// class Women_Tab extends StatefulWidget {
//   const Women_Tab({Key? key}) : super(key: key);
//
//   @override
//   State<Women_Tab> createState() => _Women_TabState();
// }
//
// class _Women_TabState extends State<Women_Tab> {
//
//
//   List<Map<String,dynamic>> circularImageData=[
//     {
//       "titel":"Dresses",
//       "imgUrl":""
//     },
//     {
//       "titel":"T-Shirts",
//       "imgUrl":""
//     },
//
//     {
//       "titel":"Nightwear",
//       "imgUrl":""
//     },
//
//     {
//       "titel":"Sportswear",
//       "imgUrl":""
//     },
//
//     {
//       "titel":"tops",
//       "imgUrl":""
//     }
//   ];
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     ApiServisces().homePage().then((value) {
//       print(value);
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             children: [
//               circularImage(
//                 title: 'Saniya',
//                 img: NetworkImage(
//                   "https://img.mensxp.com/media/content/2023/Feb/iStock-1127767024_63edce9b49f76.jpeg?w=1100&h=558&cc=1",
//                 ),
//                 onPress: (){
//                   Navigator.pushNamed(context, Product_list.id);
//                 },
//               ),
//               Container(
//                 height: 40,
//                 width: double.infinity,
//                 child: Center(child: Text("GIF/Image Placeholder")),
//                 decoration: BoxDecoration(color: Colors.amber),
//
//               ),
//
//               // SizedBox(height: 10,),
//               // banner(200),
//               // SizedBox(height: 15,),
//               // banner(150),
//               // SizedBox(height: 15,),
//               // brandGrid(),
//               // SizedBox(height: 15,),
//               // trndingCategories()
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

Widget banner(final double height, final double radius, String imageUrl) {
  return Container(
    width: double.infinity,
    height: height,
    decoration: BoxDecoration(
      // remove color while implementing apis
      color: Colors.grey,

        borderRadius: BorderRadius.circular(radius),
        image:
            DecorationImage(image:
  AssetImage(imageUrl),fit: BoxFit.fill)
            // NetworkImage(imageUrl), fit: BoxFit.fill)
    ),
  );
}

class circularImage extends StatelessWidget {
  final int? itemCount;
  final String Function(int) title;
  final String Function(int) img;
  final int? indexx;
  final VoidCallback? onPress;
  const circularImage(
      {Key? key,
      required this.title,
      required this.img,
      this.onPress,
      this.itemCount,
      this.indexx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 140,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final imageURL = img(index);
          final text = title(index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: onPress,
                  child: CircleAvatar(
                    // backgroundImage: NetworkImage(imageURL),
                    backgroundImage: AssetImage(imageURL),

                    radius: 41,
                    backgroundColor: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(text),
              ],
            ),
          );
        },
      ),
    );
  }
}

class brandGrid extends StatelessWidget {
  int itemCount;
  String Function(int) img;
  // String Function(int) title;
  brandGrid({Key? key, required this.img, required this.itemCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 150,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 65,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          // final text = title(index);
          final imgUrl = img(index);
          return Container(
            height: 40,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(imgUrl)),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white),
            // child: Center(child: Text(text)
          );
        },
      ),
    );
  }
}

class trndingCategories extends StatelessWidget {
  final String Function(int) imgUrl;
  String Function(int) title;
  final VoidCallback? Function(int)? onTab;
  int itemCount;
  trndingCategories(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.itemCount,
      this.onTab})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'TRENDING CATEGORIES',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(color: Color(0xFFfffbf2)),
          height: 340,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 155
            ),
            itemBuilder: (context, index) {
              final text = title(index);
              final imageURL = imgUrl(index);
              return Column(children: [
                GestureDetector(
                  onTap: onTab != null ? () => onTab!(index) : null,
                  child: Container(
              decoration: const BoxDecoration(
              color:AppColors.mainColor,),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10,right: 25,left: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color:Colors.grey,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100)),
                            image: DecorationImage(
                                // image: NetworkImage(imageURL), fit: BoxFit.cover)),
                                image: AssetImage(imageURL), fit: BoxFit.cover)),
                        height: 140,
                        // width: 100,
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Text(
                //   text,
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                // )
              ]);
            },
          ),
        )
      ],
    );
  }
}
