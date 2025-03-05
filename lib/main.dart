import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/constatns/routes.dart';
import 'package:pharmacy/firebase_options.dart';
import 'package:pharmacy/models/addmedicine.dart';
import 'package:pharmacy/views/add_new_medicine.dart';
import 'package:pharmacy/views/home.dart';
import 'package:pharmacy/views/login_view.dart';
import 'package:pharmacy/views/requestedmedicine_view.dart';
import 'package:pharmacy/views/sold_view.dart';
import 'package:pharmacy/views/solditems_view.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmacy',
      theme: ThemeData(
        fontFamily: 'Cairo',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: const MyHomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        homeRoute: (context) => const HomePageView(),
        newMedicineRoute: (context) => const AddNewMedicineView(),
        soldViewRoute:
            (context) => SoldView(
              code: 0,
              medName: '',
              expDate: '',
              purchaseDate: '',
              quantity: 0,
              sold: 0,
              api: '',
              medicine: Medicine(
                name: '',
                api: '',
                date: '',
                code: 0,
                expDate: '',
                quantity: 0,
                sold: 0,
              ),
              id: '',
            ),
        requestMedicineRoute: (context) => const RequestedmedicineView(),
        soldItemsRoute: (context) => const SolditemsView(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final User? currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              return const HomePageView();
            } else {
              return const LoginView();
            }
          default:
            return Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Center(child: const CircularProgressIndicator()),
            );
        }
      },
    );
  }
}
