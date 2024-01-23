import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone1/resources/fireStore_methos.dart';
import 'package:zoom_clone1/utils/colors.dart';
import 'package:zoom_clone1/utils/widgets/custom_list_Tile.dart';

class HistoryMeetingScreen extends StatelessWidget {
  const HistoryMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FireStoreMethods().meetingHistory,
        builder: (context, snabshot) {
          if (snabshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snabshot.data!.docs.length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(
                        "RoomName: ${snabshot.data!.docs[index]["meetingName"]}"),
                    subtitle: Text(
                        "Joined At: ${DateFormat.yMMMMd().format(snabshot.data!.docs[index]["createdAt"].toDate())}"),
                  ));
        });
  }
}
