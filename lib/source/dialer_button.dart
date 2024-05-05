import 'package:flutter/material.dart';

class DialerButton extends StatelessWidget {
  final Widget topWidget;
  final Widget? bottomWidget;
  final VoidCallback? onPressed;
  final double diameter;
  final Color lineColor, borderColor, backgroundColor, splashColor;

  const DialerButton({
    super.key,
    required this.topWidget,
    this.bottomWidget,
    this.onPressed,
    this.diameter = 48.0,
    this.lineColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    this.splashColor = const Color(0x1900FF00),
  });

  @override
  Widget build(BuildContext context) {
    double topWidgetOffset = diameter / 2 - 4;
    double bottomWidgetOffset = diameter / 2 + 4;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all(
          CircleBorder(side: BorderSide(color: borderColor, width: 2)),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.all(diameter / 10)),
        fixedSize: MaterialStateProperty.all(Size(diameter, diameter)),
        elevation: MaterialStateProperty.all(0.0),
        overlayColor: MaterialStateProperty.all(splashColor),
      ),
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          (bottomWidget == null)
              ? Center(child: topWidget)
              : Positioned(bottom: topWidgetOffset, child: topWidget),
          if (bottomWidget != null)
            Positioned(top: bottomWidgetOffset, child: bottomWidget!),
          Positioned.fill(
              child:
                  CustomPaint(painter: EquatorLinePainter(color: lineColor))),
        ],
      ),
    );
  }
}

class EquatorLinePainter extends CustomPainter {
  final Color color;

  EquatorLinePainter({this.color = Colors.transparent});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
