import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy/models/addmedicine.dart';
import 'package:pharmacy/models/soldMedicine.dart';
import 'package:pharmacy/services/database_services.dart';
import 'package:pharmacy/utility/show_error_dialog.dart';
import 'package:pharmacy/utility/showcase_text.dart';
import 'package:pharmacy/utility/showcsae_sidetext.dart';

int counter = 0;

class SoldView extends StatefulWidget {
  int code;
  String medName;
  String expDate;
  String purchaseDate;
  String api;
  int quantity;
  int sold;
  Medicine medicine;
  String id;
  SoldView({
    required this.code,
    required this.medName,
    required this.expDate,
    required this.purchaseDate,
    required this.quantity,
    required this.sold,
    required this.api,
    required this.medicine,
    required this.id,
  });

  @override
  State<SoldView> createState() => _SoldViewState();
}

class _SoldViewState extends State<SoldView> {
  late final TextEditingController _patientName;
  final DatabaseServices _databaseServices = DatabaseServices();

  @override
  void initState() {
    _patientName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _patientName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.medName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(138, 245, 145, 1),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: Color.fromRGBO(191, 234, 255, 1.0),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.all(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ShowcsaeSidetext(
                            label: 'Code',
                            text: widget.code.toString(),
                          ),
                          ShowcaseText(
                            width: double.infinity,
                            height: 40,
                            label: 'Name of the medicine',
                            text: widget.medName,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ShowcaseText(
                                label: 'Expiration Date',
                                text: widget.expDate,
                                width: 135,
                              ),
                              ShowcaseText(
                                label: 'Date',
                                text:
                                    DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(DateTime.now()).toString(),
                                width: 135,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 40,
                            children: [
                              ShowcaseText(
                                label: 'Quantity',
                                text: widget.quantity.toString(),
                                width: 77,
                              ),
                              ShowcaseText(
                                label: 'الخارج',
                                text: widget.sold.toString(),
                                width: 57,
                              ),
                            ],
                          ),
                          ShowcaseText(
                            label: 'المتبقي',
                            text: (widget.quantity - widget.sold).toString(),
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Divider(height: 5, color: Colors.black),
                          ),

                          Column(
                            children: [
                              Text(
                                'اختار العدد المطلوب',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          counter++;
                                        });
                                      },
                                      icon: Icon(Icons.add),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          counter.toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (counter > 1) {
                                          setState(() {
                                            counter--;
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.remove),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.all(18),
                            child: TextField(
                              controller: _patientName,
                              keyboardType: TextInputType.name,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: 'اسم المريض',
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(138, 245, 145, 1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'موافق',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          if (_patientName.text == '') {
                            showErrorDialog(
                              context,
                              "Patient's name field can't be empty",
                            );
                          } else if (counter == 0) {
                            showErrorDialog(context, "Counter can't be zero");
                          } else if (counter >
                              (widget.quantity - widget.sold)) {
                            showErrorDialog(
                              context,
                              "Counter can't be larger than the avaliable stock",
                            );
                          } else {
                            Soldmedicine soldMed = Soldmedicine(
                              productName: widget.medName,
                              api: widget.api,
                              date:
                                  DateFormat(
                                    'dd-MM-yyyy',
                                  ).format(DateTime.now()).toString(),
                              code: widget.code,
                              paitientName: _patientName.text,
                              sold: counter,
                            );
                            _databaseServices.sellItem(soldMed);
                            Medicine updatedMedicine = widget.medicine.copyWith(
                              sold: widget.sold + counter,
                            );
                            _databaseServices.updateMedicine(
                              widget.id,
                              updatedMedicine,
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
