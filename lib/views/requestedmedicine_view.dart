import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmacy/models/requestedmedicine.dart';
import 'package:pharmacy/services/database_services.dart';
import 'package:pharmacy/utility/labeled_textfield.dart';

class RequestedmedicineView extends StatefulWidget {
  const RequestedmedicineView({super.key});

  @override
  State<RequestedmedicineView> createState() => _RequestedmedicineViewState();
}

class _RequestedmedicineViewState extends State<RequestedmedicineView> {
  late final TextEditingController _medicineName;
  late final TextEditingController _quantity;
  late final TextEditingController _patientName;
  final DatabaseServices _databaseServices = DatabaseServices();

  @override
  void initState() {
    _medicineName = TextEditingController();
    _quantity = TextEditingController();
    _patientName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _medicineName.dispose();
    _quantity.dispose();
    _patientName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
          padding: EdgeInsets.all(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
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
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Icon(
                                Icons.add_circle_rounded,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'العلاج المطلوب',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  LabeledTextfield(
                    label: 'اسم العلاج',
                    hint: 'Panadol Extra',
                    controller: _medicineName,
                    onChanged: () {},
                    baseColor: Colors.white,
                    labedDirection: Alignment.topRight,
                    inputType: TextInputType.text,
                    inputFormatter: [],
                  ),
                  LabeledTextfield(
                    label: 'الكمية المطلوبة',
                    hint: '5',
                    controller: _quantity,
                    onChanged: () {},
                    baseColor: Colors.white,
                    labedDirection: Alignment.topRight,
                    inputType: TextInputType.number,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  LabeledTextfield(
                    label: 'اسم المريض',
                    hint: 'كاراس مينا صبحي',
                    controller: _patientName,
                    onChanged: () {},
                    baseColor: Colors.transparent,
                    labedDirection: Alignment.topRight,
                    inputFormatter: [],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 50),
                child: Align(
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
                        Requestedmedicine medicine = Requestedmedicine(
                          patientName: _patientName.value.text,
                          medicineName: _medicineName.value.text,
                          quantity: int.parse(_quantity.text),
                        );
                        _databaseServices.requestMed(medicine);
                        Navigator.pop(context);
                      },
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
