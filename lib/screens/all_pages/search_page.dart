import 'package:flutter/material.dart';

import '../../utils/apis.dart';
import '../mainactivity.dart';

class Search_Page extends StatefulWidget {
  Search_Page({Key? key}) : super(key: key);
  static String id = "Search_page";

  @override
  _Search_PageState createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {
  List<dynamic> _listItems = [];
  List<Map<String, dynamic>> _searchResults = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    ApiServisces().searchApi().then((value) {
      print("value: $value");
      setState(() {
        _searchResults = List<Map<String, dynamic>>.from(value["data"]);
        _listItems = List<dynamic>.from(value["data"]); // Set listItems initially
      });
      print("data: $_searchResults");
    });

    // At the beginning, all users are shown
    _foundUsers = _searchResults;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // If the search field is empty or only contains white-space, display all users
      results = _searchResults;
    } else {
      results = _searchResults
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _foundUsers = [];

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: _searchController,
            cursorColor: Colors.green,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.start,
            onChanged: (text) {
              _runFilter(_searchController.text);
            },
            decoration: InputDecoration(
              focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              fillColor: Colors.grey.shade200,
              focusColor: Colors.black,
              filled: true,
              hintText: "What are you looking for?",
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
                size: mediaQuery * 0.05,
              ),
              hintStyle: TextStyle(fontSize: mediaQuery * 0.03),
              iconColor: Colors.black,
              border:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 30, top: 3, bottom: 3),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, MainActivity_page.id, (route) => false);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    height: 5,
                    decoration: BoxDecoration(border: Border.all()),
                    child: const ImageIcon(
                      AssetImage("assets/home (1).png"),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: (_foundUsers.isNotEmpty)
          ? ListView.builder(
        itemCount: _foundUsers.length,
        itemBuilder: (context, index) {
          
          return
            // Container(
            // decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(_foundUsers[index]["image"][0]))),
            // child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: _foundUsers[index]["name"].toString(),
                      style: DefaultTextStyle.of(context).style,
                      children:  <TextSpan>[
                        TextSpan(text: "  ${_foundUsers[index]["sku"].toString()}",style: DefaultTextStyle.of(context).style,
                        ),
                      ],
                    ),
                  ),
                ),
              Divider()

              ],
            );
               RichText(text: TextSpan(
                 text:_foundUsers[index]["name"].toString(),
                  children: [
                    TextSpan(
                      // text: _foundUsers[index]["name"].toString()
                    )
                  ]
               ) );

          // );
        },
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.search,
              size: 35,
            ),
            SizedBox(
              child: Text("Search product"),
            ),
          ],
        ),
      ),
    );
  }
}
