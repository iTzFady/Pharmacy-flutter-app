import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pharmacy/models/addmedicine.dart';
import 'package:pharmacy/services/database_services.dart';
import 'package:pharmacy/utility/expandable_stock_details.dart';
import 'package:pharmacy/utility/icon_text_button.dart';
import 'package:pharmacy/utility/stock_details_collapsed.dart';
import 'package:pharmacy/utility/stock_details_expanded.dart';
import 'package:pharmacy/views/add_new_medicine.dart';
import 'package:pharmacy/views/requestedmedicine_view.dart';
import 'package:pharmacy/views/search_view.dart';
import 'package:pharmacy/views/sold_view.dart';
import 'package:pharmacy/views/solditems_view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late final String? userName = getUserName();
  late final TextEditingController _searchController;
  final DatabaseServices _databaseServices = DatabaseServices();

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String? getUserName() {
    if (FirebaseAuth.instance.currentUser?.displayName != null) {
      return FirebaseAuth.instance.currentUser?.displayName;
    } else {
      return 'User';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(191, 234, 255, 1.0),
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.all(0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                        'Hi, User',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                      child: TextField(
                        controller: _searchController,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Search',
                          suffixIcon: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => SearchView(
                                        searchItem: _searchController.text,
                                      ),
                                ),
                              );
                            },
                            icon: Icon(Icons.search),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconTextButton(
                            title: 'العلاج المطلوب',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          const RequestedmedicineView(),
                                ),
                              );
                            },
                            width: 50,
                            height: 50,
                          ),
                          IconTextButton(
                            title: 'الخارج',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SolditemsView(),
                                ),
                              );
                            },
                            width: 50,
                            height: 50,
                          ),
                          IconTextButton(
                            title: 'روشتات المرضي',
                            onPressed: () {},
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 12, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Stock',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 1, 10, 0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const AddNewMedicineView(),
                                  ),
                                );
                              },
                              label: Text(
                                'Add new medicine',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              icon: Icon(
                                Icons.add_circle_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height * 0.50,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: _databaseServices.getAvaliableMedicine(),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot,
                              ) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: const Text('Something went wrong'),
                                  );
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
                                            Medicine data =
                                                document.data()! as Medicine;
                                            if ((data.quantity - data.sold) <=
                                                0) {
                                              _databaseServices.deleteMedicine(
                                                document.id,
                                              );
                                            }
                                            return ExpandableStockDetails(
                                              expandedChild:
                                                  StockDetailsExpanded(
                                                    code: data.code,
                                                    medicineName: data.name,
                                                    expDate:
                                                        data.expDate.toString(),
                                                    quantity: data.quantity,
                                                    api: data.api,
                                                  ),
                                              collapsedChild:
                                                  StockDetailsCollapsed(
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
                                                            expDate:
                                                                data.expDate,
                                                            purchaseDate:
                                                                DateFormat(
                                                                      'dd-MM-yyyy',
                                                                    )
                                                                    .format(
                                                                      DateTime.now(),
                                                                    )
                                                                    .toString(),
                                                            quantity:
                                                                data.quantity,
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
