import 'package:flutter/material.dart';

class CollapsedDetails extends StatefulWidget {
  final String medicineName;
  final String date;
  const CollapsedDetails({
    Key? key,
    required this.medicineName,
    required this.date,
  });
  @override
  State<CollapsedDetails> createState() => _CollapsedDetailsState();
}

class _CollapsedDetailsState extends State<CollapsedDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ImageIcon(
                AssetImage('assets/icons/arrow-circle-down.png'),
                color: Colors.black,
              ),
            ),
            Text(
              widget.medicineName,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text(
                widget.date,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
