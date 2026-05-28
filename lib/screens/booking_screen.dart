import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/firestore_service.dart';
import '../services/payment_service.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() =>
      _BookingScreenState();
}

class _BookingScreenState
    extends State<BookingScreen> {

  final FirestoreService firestoreService =
  FirestoreService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,

        title: const Text(
          "Seat Booking",

          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            bookingCard(
              "van1",
              "Van 01",
            ),

            bookingCard(
              "van2",
              "Van 02",
            ),

            bookingCard(
              "van3",
              "Van 03",
            ),
          ],
        ),
      ),
    );
  }

  Widget bookingCard(
      String docId,
      String vanName,
      ) {

    return StreamBuilder(

      stream: FirebaseFirestore.instance
          .collection('vans')
          .doc(docId)
          .snapshots(),

      builder: (context, snapshot) {

        if (!snapshot.hasData) {

          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final data = snapshot.data;

        if (data == null || !data.exists) {
          return const SizedBox();
        }

        final seats = data.data()?['seats'] ?? 0;

        return Container(

          margin: const EdgeInsets.only(bottom: 14),

          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: Colors.grey.shade100,

            borderRadius:
            BorderRadius.circular(18),
          ),

          child: Row(

            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    vanName,

                    style: const TextStyle(
                      fontWeight:
                      FontWeight.bold,

                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "$seats Seats Available",

                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),

                onPressed: () async {

                  if (seats <= 0) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          "No Seats Available",
                        ),
                      ),
                    );

                    return;
                  }

                  final payment =
                  PaymentService();

                  payment.initialize(

                    onSuccess: () async {

                      await FirebaseFirestore.instance
                          .collection('vans')
                          .doc(docId)
                          .update({

                        'seats': seats - 1,
                      });

                      await firestoreService
                          .addBooking(

                        parentName:
                        "Utkarsh Sinha",

                        vanNumber: vanName,
                      );

                      if (mounted) {

                        ScaffoldMessenger.of(context)
                            .showSnackBar(

                          const SnackBar(
                            content: Text(
                              "Seat Booked Successfully",
                            ),
                          ),
                        );
                      }
                    },
                  );

                  payment.openCheckout();
                },

                child: const Text(
                  "Book",

                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}