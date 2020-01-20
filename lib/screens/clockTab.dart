import 'package:clock_app/clock/clock.dart';
import 'package:flutter/material.dart';

class ClockTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 85,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Clock(),
        ),
        SizedBox(
          height: 85,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "ALARM TIME",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.3),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "06:12 PM",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "WAKE UP AT",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.3),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "08:00 AM",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}