import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pharmacy/models/soldMedicine.dart';
import 'package:pharmacy/services/database_services.dart';
import 'package:pharmacy/utility/expandable_stock_details.dart';
import 'package:pharmacy/utility/medicine_details_collapsed.dart';
import 'package:pharmacy/utility/medicine_details_expanded.dart';

class SolditemsView extends StatefulWidget {
  const SolditemsView({super.key});

  @override
  State<SolditemsView> createState() => _SolditemsViewState();
}

class _SolditemsViewState extends State<SolditemsView> {
  final DatabaseServices _databaseServices = DatabaseServices();
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'الخارج',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.80,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _databaseServices.getSoldMedicine(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LoadingAnimationWidget.fallingDot(
                            color: Colors.white,
                            size: 20,
                          );
                        }
                        return ListView(
                          children:
                              snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                    Soldmedicine data =
                                        document.data()! as Soldmedicine;
                                    return ExpandableStockDetails(
                                      expandedChild: ExpandedDetails(
                                        code: data.code,
                                        medicineName: data.productName,
                                        date: data.date.toString(),
                                        sold: data.sold,
                                        api: data.api,
                                        patientName: data.paitientName,
                                      ),
                                      collapsedChild: CollapsedDetails(
                                        medicineName: data.productName,
                                        date: data.date,
                                      ),
                                      onTap: () {},
                                    );
                                  })
                                  .toList()
                                  .cast(),
                        );
                      },
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
