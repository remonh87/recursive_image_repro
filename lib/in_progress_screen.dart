import 'package:flutter/material.dart';

import 'action_footer.dart';

class InProgressScreen extends StatelessWidget {
  const InProgressScreen({
    Key key, this.image,
  }) : super(key: key);

  final Widget image;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          children: <Widget>[
            Text("aaaaaaaaa"),
            Expanded(
              child: image,
            ),
            RepaintBoundary(
              // To prevent the whole screen from repainting continuously while the spinner is running because ActionFooter
              // is transparent
              child: ActionFooter(
                message: ActionFooterMessage(
                  message: Text("my test"),
                ),
              ),
            ),
          ],
        ),
      );
}
