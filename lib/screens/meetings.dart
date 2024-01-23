import 'dart:math';
import 'package:flutter/material.dart';
import '../resources/jitsi_meet_methods.dart';
import '../utils/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});

  final JisiMeetingsMethods _jisiMeetingsMethods = JisiMeetingsMethods();
  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 1000000).toString();
    _jisiMeetingsMethods.createMeetings(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/VideoCall');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeMeetingsButton(
                  text: "New Meeting",
                  icon: Icons.videocam,
                  onPressed: createNewMeeting),
              HomeMeetingsButton(
                text: "Join Meeting",
                icon: Icons.add_box_rounded,
                onPressed: () => joinMeeting(context),
              ),
              HomeMeetingsButton(
                text: "Share Screen",
                icon: Icons.arrow_upward_rounded,
                onPressed: () {},
              )
            ],
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              "Create/Join Meetings With just a Click",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
