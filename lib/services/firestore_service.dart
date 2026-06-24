import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> addBooking({

    required String parentName,

    required String vanNumber,

    required String studentName,

    required String pickupLocation,

    required String dropLocation,
  }) async {

    await _firestore.collection('bookings').add({

      'studentName': studentName,

      'pickupLocation': pickupLocation,

      'dropLocation': dropLocation,

      'parentName': parentName,
      'vanNumber': vanNumber,
      'timestamp': FieldValue.serverTimestamp(),

      'bookingTime': DateTime.now(),

      'status': 'Pending',

    });
  }
}