import 'package:flutter/material.dart';

enum Gender { male, female, other }

class GenderSelectionWidget extends StatefulWidget {
  const GenderSelectionWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GenderSelectionWidgetState createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  late Gender _selectedGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                Row(children: [
                  Radio(
                    activeColor: Colors.black,
                    value: Gender.male,
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  Center(child: Text('Male',style: TextStyle(fontSize: 13),)),
                ],),
                Flexible(
                  child: Row(children: [
                    Radio(
                      activeColor: Colors.black,

                      value: Gender.female,
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    Center(child: Text('Female',style: TextStyle(fontSize: 13),)),
                  ],),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
