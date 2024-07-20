import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Checkout_Suggetion_Cart extends StatelessWidget {
  const Checkout_Suggetion_Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 70,
                child: Stack(children: [
                  AspectRatio(
                      aspectRatio: 0.6,
                      child: ClipRRect(
                        // borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://img.mensxp.com/media/content/2023/Feb/iStock-1127767024_63edce9b49f76.jpeg?w=1100&h=558&cc=1",
                          fit: BoxFit.fill,
                        ),
                      )),
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.green.shade700,
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ]),
              ),
              SizedBox(
                height: 5,
              ),
              Text("AED 68"),
              SizedBox(
                height: 5,
              ),
              Text("Saniyas")
            ],
          ),
        ),
      ],
    );
  }
}
