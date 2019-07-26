import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recursive_image/in_progress_screen.dart';
import 'package:recursive_image/recursive_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState();

  final completer = Completer<void>();
  final stream = Stream.periodic(Duration(milliseconds: 500));

  StreamSubscription subscription;

  int ticker = 0;

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() {
    subscription = stream.listen((_) {
      ticker = ticker + 1;
      setState(() {});
    });

    Future.delayed(Duration(seconds: 10)).then((_) async {
      await subscription.cancel();
      completer.complete();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recursive image demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Recursive image"),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text("Ticker: $ticker"),
            ),
            Expanded(
              child: !completer.isCompleted
                  ? RecursiveImage(
                      builder: (context, image) => InProgressScreen(image: image),
                      recursionDepth: 2,
                    )
                  : Container(
                      child: Text("done $ticker"),
                      color: Colors.red,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
