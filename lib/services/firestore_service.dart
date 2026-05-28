import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> addBooking({
    required String parentName,
    required String vanNumber,
  }) async {

    await _firestore.collection('bookings').add({

      'parentName': parentName,
      'vanNumber': vanNumber,
      'timestamp': FieldValue.serverTimestamp(),

    });
  }
}