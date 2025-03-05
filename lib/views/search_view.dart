import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pharmacy/models/addmedicine.dart';
import 'package:pharmacy/services/database_services.dart';
import 'package:pharmacy/utility/expandable_stock_details.dart';
import 'package:pharmacy/utility/stock_details_collapsed.dart';
import 'package:pharmacy/utility/stock_details_expanded.dart';
import 'package:pharmacy/views/sold_view.dart';

class SearchView extends StatefulWidget {
  String searchItem;
  SearchView({required this.searchItem});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  DatabaseServices _databaseServices = DatabaseServices();
  Stream<QuerySnapshot> _search() {
    Query query = FirebaseFirestore.instance
        .collection('Medicines')
        .withConverter<Medicine>(
          fromFirestore: (snapshots, _) => Medicine.fromJson(snapshots.data()!),
          toFirestore: (medicine, _) => medicine.toJson(),
        )
        .where('Name', isEqualTo: widget.searchItem);
    return query.snapshots();
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
          padding: EdgeInsets.all(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.80,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _search(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot,
                  ) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Center(
                          child: Center(
                            child: const Text('Something went wrong'),
                          ),
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingAnimationWidget.fallingDot(
                        color: Colors.white,
                        size: 20,
                      );
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          'No results Found',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                                Medicine data = document.data()! as Medicine;
                                return ExpandableStockDetails(
                                  expandedChild: StockDetailsExpanded(
                                    code: data.code,
                                    medicineName: data.name,
                                    expDate: data.expDate.toString(),
                                    quantity: data.quantity,
                                    api: data.api,
                                  ),
                                  collapsedChild: StockDetailsCollapsed(
                                    medicineName: data.name,
                                    expDate: data.expDate,
                                  ),
                                  onTap:
                                      () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => SoldView(
                                                code: data.code,
                                                medName: data.name,
                                                expDate: data.expDate,
                                                purchaseDate:
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(DateTime.now())
                                                        .toString(),
                                                quantity: data.quantity,
                                                sold: data.sold,
                                                api: data.api,
                                                medicine: data,
                                                id: document.id,
                                              ),
                                        ),
                                      ),
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
        ),
      ),
    );
  }
}
