import 'package:flutter/material.dart';

class ExpandedDetails extends StatefulWidget {
  final int code;
  final String medicineName;
  final String date;
  final int sold;
  final String patientName;
  final String api;
  ExpandedDetails({
    Key? key,
    required this.code,
    required this.medicineName,
    required this.date,
    required this.sold,
    required this.patientName,
    required this.api,
  }) : super(key: key);

  @override
  State<ExpandedDetails> createState() => _ExpandedDetailsState();
}

class _ExpandedDetailsState extends State<ExpandedDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
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
                      AssetImage('assets/icons/arrow-circle-up.png'),
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
              Text(
                widget.date.toString(),
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                ),
              ),
              Text(
                widget.sold.toString(),
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                widget.patientName,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
