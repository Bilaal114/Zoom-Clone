import 'package:flutter/material.dart';
import 'package:zoom_clone1/resources/auth_methods.dart';
import 'package:zoom_clone1/resources/fireStore_methos.dart';
import 'package:zoom_clone1/utils/widgets/custom_list_Tile.dart';

class profile extends StatelessWidget {
  profile({super.key});
  final AuthMethos _authMethos = AuthMethos();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FireStoreMethods().getUsers,
      builder: (context, snabshot) {
        if (snabshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snabshot.data!.docs.length,
          itemBuilder: (context, index) => MeetingCard(
            title: Image(
              image:
                  NetworkImage("${snabshot.data!.docs[index]["profilePhoto"]}"),
              height: 45,
              width: 45,
            ),
            subTitle: Text("${snabshot.data!.docs[index]["username"]}"),
          ),
        );
      },
    );
  }
}
