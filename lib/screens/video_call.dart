import 'package:flutter/material.dart';
import 'package:zoom_clone1/resources/auth_methods.dart';
import 'package:zoom_clone1/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone1/utils/colors.dart';
import 'package:zoom_clone1/utils/widgets/meeting_options.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({super.key});

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final AuthMethos _authMethos = AuthMethos();
  final JisiMeetingsMethods _jisiMeetingsMethods = JisiMeetingsMethods();
  late TextEditingController roomIdController;
  late TextEditingController nameController;
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    roomIdController = TextEditingController();
    nameController = TextEditingController(text: _authMethos.user.displayName);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
    nameController.dispose();
  }

  _joinMeeting() {
    _jisiMeetingsMethods.createMeetings(
        roomName: roomIdController.text,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
        username: nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text("Join Meeting"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: roomIdController,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: "Room ID"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: nameController,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: "Name"),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: _joinMeeting,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Join",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MeetingOption(
              text: "Mute Audio",
              isMute: isAudioMuted,
              isOnchanged: onAudioMuted),
          MeetingOption(
              text: "Nute Video",
              isMute: isVideoMuted,
              isOnchanged: onVideoMuted),
        ],
      ),
    );
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }
}
