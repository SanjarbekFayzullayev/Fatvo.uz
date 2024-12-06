import 'package:flutter/material.dart';

class MiniCard extends StatefulWidget {
  IconData iconData;
  String name;

  MiniCard(this.iconData, this.name, {Key? key}) : super(key: key);

  @override
  State<MiniCard> createState() => _MiniCardState();
}

class _MiniCardState extends State<MiniCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xff41686D),
          ),
          child: Icon(
            widget.iconData,
            color: Colors.white,
            size: 34,
          ),
        ),
        Text(
          widget.name,
          style: const TextStyle(
            color: Color(0xff41686D),
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
