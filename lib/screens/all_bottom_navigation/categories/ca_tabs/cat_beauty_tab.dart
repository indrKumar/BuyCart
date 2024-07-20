import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Category_Beauty_Tab extends StatefulWidget {
  const Category_Beauty_Tab({super.key});

  @override
  State<Category_Beauty_Tab> createState() => _Category_Beauty_TabState();
}

class _Category_Beauty_TabState extends State<Category_Beauty_Tab> {
  int selectedIndex = 0;

  List<String> cardNames = [
    'Brands',
    'Influencere',
    'Beauty',
    'Clothing',
    'Dreses',
    "Accesories",
    "Topweare",
    "Fotweare",
    "Bags",
  ];

  bool isSlected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Container(
          width: 120,
          height: double.infinity,
          color: Colors.grey.shade300,
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
                        child: Expanded(
                          child: Text(
                            cardNames[index],
                            style: TextStyle(fontSize: 12),
                          ),
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
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          endIndent: 3,
                          indent: 3,
                          thickness: 2,
                          color: Colors.white,
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "VIEW ALL",
                            style: TextStyle(
                                fontSize: 13,
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
                        )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "CATEGORIES TO EXPLORE",
                  style: TextStyle(color: Color(0xFFc0a68e)),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        child: Container(
                            color: Colors.grey,
                            child: Stack(children: [
                              Positioned(
                                  bottom: 50,
                                  left: 10,
                                  child: Text(
                                    "Product Name",
                                  ))
                            ])),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                  ),
                )
              ]),
            ),
          ),
        )
      ]),
    );
  }
}
