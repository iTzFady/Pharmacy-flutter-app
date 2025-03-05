import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockDetailsExpanded extends StatefulWidget {
  final int code;
  final String medicineName;
  final String expDate;
  final int quantity;
  final String api;
  const StockDetailsExpanded({
    Key? key,
    required this.code,
    required this.medicineName,
    required this.expDate,
    required this.quantity,
    required this.api,
  });
  @override
  State<StockDetailsExpanded> createState() => _StockDetailsExpandedState();
}

class _StockDetailsExpandedState extends State<StockDetailsExpanded> {
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
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: ImageIcon(
                      AssetImage('assets/icons/arrow-drop-down-circle.png'),
                      color: Colors.black,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.code.toString(),
                        style: TextStyle(
                          fontFamily: 'Cario',
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                widget.medicineName,
                style: TextStyle(
                  fontFamily: 'Cario',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                widget.api,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'Cairo',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Expired   ',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),

                  Text(
                    widget.expDate.toString(),
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
              Text(
                widget.quantity.toString(),
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
