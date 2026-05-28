import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() =>
      _AttendanceScreenState();
}

class _AttendanceScreenState
    extends State<AttendanceScreen> {

  final List<Map<String, dynamic>> students = [

    {
      'name': 'Rahul',
      'present': false,
    },

    {
      'name': 'Aman',
      'present': false,
    },

    {
      'name': 'Priya',
      'present': false,
    },

    {
      'name': 'Sneha',
      'present': false,
    },
  ];

  Future<void> saveAttendance() async {

    for (var student in students) {

      await FirebaseFirestore.instance
          .collection('attendance')
          .add({

        'name': student['name'],
        'present': student['present'],
        'time': Timestamp.now(),
      });
    }

    if (mounted) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Attendance Saved",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Attendance"),
      ),

      body: Column(

        children: [

          Expanded(

            child: ListView.builder(

              itemCount: students.length,

              itemBuilder: (context, index) {

                return CheckboxListTile(

                  title: Text(
                    students[index]['name'],
                  ),

                  value:
                  students[index]['present'],

                  onChanged: (value) {

                    setState(() {

                      students[index]['present']
                      = value!;
                    });
                  },
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),

            child: SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: saveAttendance,

                child: const Text(
                  "Save Attendance",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}