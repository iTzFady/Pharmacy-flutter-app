import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmacy/constatns/routes.dart';
import 'package:pharmacy/models/addmedicine.dart';
import 'package:pharmacy/utility/labeled_textfield.dart';
import 'package:pharmacy/services/database_services.dart';
import 'package:pharmacy/utility/show_error_dialog.dart';
import 'package:string_validator/string_validator.dart';

class AddNewMedicineView extends StatefulWidget {
  const AddNewMedicineView({super.key});

  @override
  State<AddNewMedicineView> createState() => _AddNewMedicineViewState();
}

class _AddNewMedicineViewState extends State<AddNewMedicineView> {
  late final TextEditingController _code;
  late final TextEditingController _nameOfMedicine;
  late final TextEditingController _api;
  late final TextEditingController _expDate;
  late final TextEditingController _addDate;
  late final TextEditingController _quantity;
  final DatabaseServices _databaseServices = DatabaseServices();

  @override
  void initState() {
    _code = TextEditingController();
    _nameOfMedicine = TextEditingController();
    _api = TextEditingController();
    _expDate = TextEditingController();
    _addDate = TextEditingController();
    _quantity = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _code.dispose();
    _nameOfMedicine.dispose();
    _api.dispose();
    _expDate.dispose();
    _addDate.dispose();
    _quantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(191, 234, 255, 1.0),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(homeRoute, (Route) => false);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill,
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                child: Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(3, 1, 5, 3),
                          child: Icon(
                            Icons.add_circle_rounded,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Add new medicine',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LabeledTextfield(
                        label: 'Code',
                        hint: '101',
                        controller: _code,
                        inputType: TextInputType.number,
                        onChanged: (val) {
                          setState(() {
                            _code.text = val.toString();
                          });
                        },
                        baseColor: Colors.transparent,
                        labedDirection: Alignment.topLeft,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      LabeledTextfield(
                        label: 'Name of the medicine',
                        hint: 'Panadol Extra',
                        controller: _nameOfMedicine,
                        onChanged: (text) {
                          _nameOfMedicine.text = text.toString();
                        },
                        baseColor: Colors.transparent,
                        inputType: TextInputType.text,
                        labedDirection: Alignment.topLeft,
                        inputFormatter: [],
                      ),
                      LabeledTextfield(
                        label: 'API',
                        hint: 'المادة الفعالة',
                        controller: _api,
                        onChanged: (text) {
                          _api.text = text.toString();
                        },
                        baseColor: Colors.transparent,
                        inputType: TextInputType.text,
                        labedDirection: Alignment.topLeft,
                        inputFormatter: [],
                      ),
                      LabeledTextfield(
                        label: 'Expiration Date',
                        hint: '12/8/2028',
                        controller: _expDate,
                        onChanged: (text) {
                          _expDate.text = text.toString();
                        },
                        baseColor: Colors.transparent,
                        inputType: TextInputType.numberWithOptions(),
                        labedDirection: Alignment.topLeft,
                        inputFormatter: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^[0-9\/]*$'),
                          ),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            String text = newValue.text;
                            if (newValue.text.length == 2 &&
                                oldValue.text.length != 3) {
                              text += '/';
                            }
                            if (newValue.text.length == 5 &&
                                oldValue.text.length != 6) {
                              text += '/';
                            }
                            return TextEditingValue(text: text);
                          }),
                        ],
                      ),
                      LabeledTextfield(
                        label: 'Date',
                        hint: '5/2/2025',
                        controller: _addDate,
                        onChanged: (text) {
                          _addDate.text = text.toString();
                        },
                        baseColor: Colors.transparent,
                        inputType: TextInputType.numberWithOptions(),
                        labedDirection: Alignment.topLeft,
                        inputFormatter: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^[0-9\/]*$'),
                          ),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            String text = newValue.text;
                            if (newValue.text.length == 2 &&
                                oldValue.text.length != 3) {
                              text += '/';
                            }
                            if (newValue.text.length == 5 &&
                                oldValue.text.length != 6) {
                              text += '/';
                            }
                            return TextEditingValue(text: text);
                          }),
                        ],
                      ),
                      LabeledTextfield(
                        label: 'Quantity',
                        hint: '50',
                        controller: _quantity,
                        onChanged: (text) {
                          setState(() {
                            _quantity.text = text.toString();
                          });
                        },
                        baseColor: Colors.transparent,
                        inputType: TextInputType.number,
                        labedDirection: Alignment.topLeft,
                        inputFormatter: [],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (!isDate(_expDate.text)) {
                          _expDate.clear();
                          showErrorDialog(context, 'Enter a valid date');
                        } else if (!isDate(_addDate.text)) {
                          _addDate.clear();
                          showErrorDialog(context, 'Enter a valid date');
                        } else if (_code.text.isEmpty ||
                            _nameOfMedicine.text.isEmpty ||
                            _api.text.isEmpty ||
                            _expDate.text.isEmpty ||
                            _addDate.text.isEmpty ||
                            _quantity.text.isEmpty) {
                          showErrorDialog(context, "Please Fill all fields");
                        } else {
                          Medicine medicine = Medicine(
                            name: _nameOfMedicine.value.text,
                            api: _api.value.text,
                            code: int.parse(_code.text),
                            quantity: int.parse(_quantity.text),
                            expDate: _expDate.text,
                            date: _addDate.text,
                            sold: 0,
                          );
                          _databaseServices.addNewMedicine(medicine);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
