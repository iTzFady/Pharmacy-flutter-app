import 'package:flutter/material.dart';

class ShowcaseText extends StatelessWidget {
  ShowcaseText({
    Key? key,
    this.height,
    this.width,
    required this.label,
    required this.text,
  }) : super(key: key);
  double? width;
  double? height;
  final String label;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Text(
                text,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
