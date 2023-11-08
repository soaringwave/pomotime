import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/functions/get_time_format.dart';
import 'package:pomotimer/widgets/icon_button_container.dart';
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
  Duration _duration = const Duration(hours: 0, minutes: 25);

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

  void onResetPressedInTotalTime() async {
    setState(() {
      widget.totalTime = 0;
    });
    await widget.prefs.setInt('totalTime', 0);
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
            IconButtonContainer(
              childWidget: IconButton(
                onPressed: onResetPressedInTotalTime,
                icon: const Icon(
                  Icons.clear_rounded,
                  size: 30,
                ),
              ),
              shadowColor: Colors.black.withOpacity(0.3),
            ),
            DurationPicker(
              duration: _duration,
              baseUnit: BaseUnit.minute,
              onChange: (val) {
                setState(() => _duration = val);
              },
              snapToMins: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
