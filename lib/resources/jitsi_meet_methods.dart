import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:zoom_clone1/resources/auth_methods.dart';
import 'package:zoom_clone1/resources/fireStore_methos.dart';

class JisiMeetingsMethods {
  final FireStoreMethods _fireStoreMethods = FireStoreMethods();
  final AuthMethos _authMethos = AuthMethos();
  /* void createMeetings(
      {required roomName,
      required bool isAudioMuted,
      required bool isVideoMuted}) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p

      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = _authMethos.user.displayName
        ..userEmail = _authMethos.user.email
        ..userAvatarURL = _authMethos.user.photoURL // or .png
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("error: $error");
    }
  }*/

  void createMeetings({
    required roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = "",
  }) async {
    // Define meetings options here
    String name;
    if (username.isEmpty) {
      name = _authMethos.user.displayName!;
    } else {
      name = username;
    }
    Map<String, Object> featureFlags = {};
    var options = JitsiMeetingOptions(
      roomNameOrUrl: roomName,
      userAvatarUrl: _authMethos.user.photoURL,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      userDisplayName: name,
      userEmail: _authMethos.user.email,
      featureFlags: featureFlags,
    );

    debugPrint("JitsiMeetingOptions: $options");
    _fireStoreMethods.addToMeetingHistory(roomName!);
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
            "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          debugPrint(
            "onParticipantJoined: email: ${_authMethos.user.email}, name: ${_authMethos.user.displayName}, role: $role, "
            "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          debugPrint(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
            "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
            "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      ),
    );
  }
}
