import 'package:flutter/material.dart';
import 'package:pomotimer/functions/get_time_format.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TotalTimeScreen extends StatefulWidget {
  TotalTimeScreen({
    super.key,
  });
  int totalTime = 0;
  late SharedPreferences prefs;

  @override
  State<TotalTimeScreen> createState() => _TotalTimeScreenState();
}

class _TotalTimeScreenState extends State<TotalTimeScreen> {
  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  void initPrefs() async {
    widget.prefs = await SharedPreferences.getInstance();
    if (widget.prefs.getInt('totalTime') != null) {
      setState(() {
        widget.totalTime = widget.prefs.getInt('totalTime')!;
      });
    } else {
      widget.prefs.setInt('totalTime', 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Total Time',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.normal,
          ),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getTimeFormat(widget.totalTime),
              style: const TextStyle(
                fontSize: 50,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.highlight_remove,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
