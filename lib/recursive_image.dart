import 'package:flutter/widgets.dart';

class RecursiveImage extends StatelessWidget {
  const RecursiveImage({@required this.recursionDepth, this.builder, Key key}) : super(key: key);

  final Widget Function(BuildContext context, Widget image) builder;
  final int recursionDepth;

  Matrix4 transformation(double scale) => Matrix4.identity().scaled(1.0)
    ..translate(0.375 * scale, 0.18 * scale)
    ..scale(scale * 0.00085)
    ..rotateZ(-0.61)
    ..rotateX(0.5)
    ..rotateY(0.62);

  static const innerPhoneWidth = 375.0;
  static const innerPhoneHeight = 785.0;

  @override
  Widget build(BuildContext context) => builder(
    context,
    // Center so Image takes the aspect ratio of the image, on which the transformation relies
    Center(
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
        Image.asset("assets/bird.jpg"),
            if (recursionDepth > 0)
              Positioned.fill(
                child: Builder(
                  builder: (context) => Transform(
                    transform: transformation(constraints.maxWidth),
                    child: OverflowBox(
                      alignment: Alignment.topLeft,
                      maxWidth: innerPhoneWidth,
                      minWidth: innerPhoneWidth,
                      maxHeight: innerPhoneHeight,
                      minHeight: innerPhoneHeight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: IgnorePointer(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            removeLeft: true,
                            removeRight: true,
                            child: RecursiveImage(
                              recursionDepth: recursionDepth - 1,
                              builder: builder,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}