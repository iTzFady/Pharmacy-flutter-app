import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextDirection { right, center, left }

class LabeledTextfield extends StatelessWidget {
  LabeledTextfield({
    Key? key,
    this.height,
    this.width,
    required this.label,
    required this.hint,
    required this.controller,
    this.inputType = TextInputType.text,
    required this.onChanged,
    required this.baseColor,
    required this.labedDirection,
    required this.inputFormatter,
  }) : super(key: key);
  final double? height;
  final double? width;
  late final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType inputType;
  final Color baseColor;
  final Function onChanged;
  final Alignment labedDirection;
  List<TextInputFormatter> inputFormatter = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Column(
          children: [
            Align(
              alignment: labedDirection,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
            TextField(
              inputFormatters: inputFormatter,
              keyboardType: inputType,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
