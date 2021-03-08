import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';

class FlutterDateTimeDemo extends StatefulWidget {
  Function setDateTime;
  FlutterDateTimeDemo({this.setDateTime});
  @override
  _FlutterDateTimeDemoState createState() => _FlutterDateTimeDemoState();
}

class _FlutterDateTimeDemoState extends State<FlutterDateTimeDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            padding: const EdgeInsets.only(top: 11, bottom: 11),
            // decoration: BoxDecoration(color: const Color(0xFFF5F5F5)),
            child: FlutterDatePickerTimeline(
              startDate: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day)
                  .subtract(Duration(days: 30)),
              endDate: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day)
                  .add(Duration(days: 30)),
              initialSelectedDate: DateTime(DateTime.now().year,
                  DateTime.now().month, DateTime.now().day),
              onSelectedDateChange: (DateTime dateTime) {
                print(dateTime);
                widget.setDateTime(dateTime);
              },
            )),
      ),
    );
  }
}
