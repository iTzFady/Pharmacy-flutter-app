import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockDetailsCollapsed extends StatefulWidget {
  final String medicineName;
  final String expDate;
  const StockDetailsCollapsed({
    Key? key,
    required this.medicineName,
    required this.expDate,
  });
  @override
  State<StockDetailsCollapsed> createState() => _StockDetailsCollapsedState();
}

class _StockDetailsCollapsedState extends State<StockDetailsCollapsed> {
  int getRemainingdays(DateTime later) {
    later = DateTime.utc(later.year, later.month, later.day);
    return later.difference(DateTime.now()).inDays;
  }

  MaterialAccentColor? getColor() {
    String dateString = widget.expDate;
    DateFormat format = DateFormat.yMd('en_us');
    DateTime dateTime = format.parse(dateString);
    if (getRemainingdays(dateTime) > 30) {
      return Colors.greenAccent;
    } else if (getRemainingdays(dateTime) < 30 &&
        getRemainingdays(dateTime) > 15) {
      return Colors.orangeAccent;
    } else {
      return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Icon(Icons.arrow_drop_down_circle, color: Colors.black),
            ),
            Center(
              child: Text(
                widget.medicineName,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
