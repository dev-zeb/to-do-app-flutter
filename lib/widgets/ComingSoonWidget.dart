import 'package:flutter/material.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Coming Soon...\nIn Sha'a Allaah!",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }
}
