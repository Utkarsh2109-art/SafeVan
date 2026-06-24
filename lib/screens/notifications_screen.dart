import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(

        backgroundColor: Colors.black,
        elevation: 0,

        title: const Text(
          "Notifications",

          style: TextStyle(
            color: const Color(0xFF1E1E1E),
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: StreamBuilder(

        stream: FirebaseFirestore.instance
            .collection('notifications')
            .orderBy('time',
            descending: true)
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final notifications =
              snapshot.data!.docs;

          return ListView.builder(

            itemCount: notifications.length,

            itemBuilder: (context, index) {

              final data =
              notifications[index];

              return ListTile(

                leading: const Icon(
                  Icons.notifications,
                ),

                title: Text(
                  data['title'],
                ),

                subtitle: Text(
                  data['message'],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget notificationTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {

    return Container(

      margin: const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        boxShadow: [

          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
          ),
        ],
      ),

      child: Row(

        children: [

          Container(

            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: color.withOpacity(0.15),

              borderRadius:
              BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,

                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}