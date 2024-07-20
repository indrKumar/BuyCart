import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Quantity extends StatelessWidget {
  const Quantity(
      {super.key,
      required this.value,
      required this.quantityIncreament,
      required this.quantityDecrease});
  final int value;
  final VoidCallback quantityIncreament;
  final VoidCallback quantityDecrease;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.grey.shade300),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: quantityDecrease,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "-",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 25,
            child: Text(
              value.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
          ),
          GestureDetector(
            onTap: quantityIncreament,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "+",
                style: TextStyle(fontSize: 25),
              ),
            ),
          )
        ],
      ),
    );
  }
}
