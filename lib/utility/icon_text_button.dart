import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  IconTextButton({
    Key? key,
    this.height,
    this.width,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  double? height;
  double? width;
  String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Column(
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
