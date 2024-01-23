import 'package:flutter/material.dart';

class MeetingCard extends StatelessWidget {
  final Widget title;
  final Widget subTitle;
  MeetingCard({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(right: 30, left: 5),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(35)),
          ),
          height: MediaQuery.of(context).size.height / 8,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              title,
              const SizedBox(
                width: 10,
              ),
              subTitle,
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
