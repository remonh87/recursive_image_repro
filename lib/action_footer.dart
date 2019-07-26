import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ActionFooter extends StatelessWidget {
  ActionFooter({
    this.buttons,
    this.message,
    Key key,
  })  : assert((buttons != null && buttons.isNotEmpty) || message != null),
        super(key: key);

  final List<Widget> buttons;

  /// An optional [ActionFooterMessage]
  final Widget message;

  final _marginTop = 16.0;

  final _backgroundColor = Colors.black12;

  @override
  Widget build(BuildContext context) {
    final actionsWidget = buttons?.isNotEmpty ?? false
        ? ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 80, maxWidth: 240),
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buttons
                    .map((button) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: button,
                        ))
                    .toList(),
              ),
            ),
          )
        : null;

    final sigma = 12.0;

    return DecoratedBox(
      decoration: BoxDecoration(color: _backgroundColor),
      child: ClipRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Color(0x00ffffff)),
            child: SizedBox(
              width: double.infinity,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: _marginTop,
                    horizontal: 12.0,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        if (message != null) message,
                        if (actionsWidget != null) actionsWidget,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ActionFooterMessage extends StatelessWidget {
  const ActionFooterMessage({
    @required this.message,
    Key key,
  }) : super(key: key);

  final Widget message;

  @override
  Widget build(BuildContext context) {
    final box = SizedBox();
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        child: IntrinsicWidth(
          child: ConstrainedBox(
            // At least button height to prevent height changes when switching between button and activity indicator
            constraints: const BoxConstraints(minHeight: 36.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                box,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 6.0,
                    ),
                    child: DefaultTextStyle(
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                      child: message,
                    ),
                  ),
                ),
                Opacity(opacity: 0, child: box),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
