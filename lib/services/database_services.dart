import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacy/models/addmedicine.dart';
import 'package:pharmacy/models/requestedmedicine.dart';
import 'package:pharmacy/models/soldMedicine.dart';

const String MEDICINE_COLLECTION_REF = 'Medicines';
const String SOLD_MED_COLLECTION_REF = 'Sold';
const String REQUESTED_MED_COLLECTION_REF = 'Requested';

class DatabaseServices {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _medicineRef;
  late final CollectionReference _soldMedicineRef;
  late final CollectionReference _requestedMedicineRef;

  DatabaseServices() {
    _medicineRef = _firestore
        .collection(MEDICINE_COLLECTION_REF)
        .withConverter<Medicine>(
          fromFirestore: (snapshots, _) => Medicine.fromJson(snapshots.data()!),
          toFirestore: (medicine, _) => medicine.toJson(),
        );
    _soldMedicineRef = _firestore
        .collection(SOLD_MED_COLLECTION_REF)
        .withConverter<Soldmedicine>(
          fromFirestore:
              (snapshots, _) => Soldmedicine.fromJson(snapshots.data()!),
          toFirestore: (sold, _) => sold.toJson(),
        );
    _requestedMedicineRef = _firestore
        .collection(REQUESTED_MED_COLLECTION_REF)
        .withConverter<Requestedmedicine>(
          fromFirestore:
              (snapshots, _) => Requestedmedicine.fromJson(snapshots.data()!),
          toFirestore: (requestedmedicine, _) => requestedmedicine.toJson(),
        );
  }

  Stream<QuerySnapshot> getAvaliableMedicine() {
    return _medicineRef.snapshots();
  }

  void addNewMedicine(Medicine medicine) async {
    _medicineRef.add(medicine);
  }

  void updateMedicine(String medicineID, Medicine medicine) {
    _medicineRef.doc(medicineID).update(medicine.toJson());
  }

  void deleteMedicine(String medicineID) {
    _medicineRef.doc(medicineID).delete();
  }

  void sellItem(Soldmedicine medicine) async {
    _soldMedicineRef.add(medicine);
  }

  Stream<QuerySnapshot> getSoldMedicine() {
    return _soldMedicineRef.snapshots();
  }

  void requestMed(Requestedmedicine medicine) async {
    _requestedMedicineRef.add(medicine);
  }

  Stream<QuerySnapshot> getRequestedMeds() {
    return _requestedMedicineRef.snapshots();
  }
}
