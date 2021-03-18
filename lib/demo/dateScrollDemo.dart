import 'package:caloriecounter/caloriescounter/viewRecipesPage.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// class DateScrollDemo extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DateScrollDemo(title: 'Date Picker Timeline Demo'),
//     );
//   }
// }

class DateScrollDemo extends StatefulWidget {
  Function setDateTime;

  GoogleSignInAccount gUser;
  DateScrollDemo({Key key, this.title, this.gUser, this.setDateTime})
      : super(key: key);
  final String title;

  @override
  _DateScrollDemoState createState() => _DateScrollDemoState();
}

class _DateScrollDemoState extends State<DateScrollDemo> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.replay),
        //   onPressed: () {
        //     _controller.animateToSelection();
        //   },
        // ),
        body: Container(
      // padding: EdgeInsets.all(2.0),
      //color: Colors.blueGrey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(2),
          ),
          Transform.scale(
            scale: 0.6,
            child: Container(
              child: DatePicker(
                DateTime.now(),
                width: 70,
                height: 100,
                controller: _controller,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                dayTextStyle: TextStyle(fontSize: 10),
                onDateChange: (date) {
                  widget.setDateTime(date);
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
