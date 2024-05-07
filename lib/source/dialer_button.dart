import 'package:flutter/material.dart';

class DialerButton extends StatefulWidget {
  final Widget topWidget;
  final Widget? bottomWidget;
  final Function(TapUpDetails)? onTapUp;
  final Function(TapDownDetails)? onTapDown;
  final double diameter;
  final Color lineColor;
  final Color borderColor;
  final Color backgroundColor;
  final Color splashColor;

  static const double defaultDiameter = 80.0;
  static const Color defaultSplashColor = Color(0x1900FF00);

  const DialerButton({
    super.key,
    required this.topWidget,
    this.bottomWidget,
    this.onTapUp,
    this.onTapDown,
    this.diameter = defaultDiameter,
    this.lineColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    this.splashColor = defaultSplashColor,
  });

  @override
  State<DialerButton> createState() => _DialerButtonState();
}

class _DialerButtonState extends State<DialerButton> {
  final GlobalKey topKey = GlobalKey();
  final GlobalKey bottomKey = GlobalKey();
  double? topWidgetHeight;

  static const double borderWidth = 2.0;
  static const double elevation = 0.0;
  static const double bottomWidgetVerticalOffset = 12.0;
  static const double paddingFraction =
      10.0; // Represents padding as a fraction of the diameter
  static const double strokeWidth = 1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateSizes());
  }

  void _calculateSizes() {
    final RenderObject? renderObjectTop =
        topKey.currentContext?.findRenderObject();
    if (renderObjectTop is RenderBox) {
      topWidgetHeight =
          renderObjectTop.size.height; // Get the height of the top widget
      setState(() {}); // Trigger a rebuild with the new height
    }
  }

  @override
  Widget build(BuildContext context) {
    final double centerLine = widget.diameter / 2;
    final double topWidgetOffset = widget.bottomWidget != null
        ? centerLine - (topWidgetHeight ?? 0)
        : centerLine; // Calculate the top offset

    final double bottomWidgetOffset =
        centerLine / 2 + bottomWidgetVerticalOffset;

    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.backgroundColor),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(CircleBorder(
              side: BorderSide(color: widget.borderColor, width: borderWidth))),
          padding: MaterialStateProperty.all(
              EdgeInsets.all(widget.diameter / paddingFraction)),
          fixedSize:
              MaterialStateProperty.all(Size(widget.diameter, widget.diameter)),
          elevation: MaterialStateProperty.all(elevation),
          overlayColor: MaterialStateProperty.all(widget.splashColor)),
      onPressed: () {}, //Use an empty onPressed make interactive
      child: GestureDetector(
        onTapDown: (topDownDetails) {
          if (widget.onTapDown != null) widget.onTapDown!(topDownDetails);
        },
        onTapUp: (tapUpDetails) {
          if (widget.onTapUp != null) widget.onTapUp!(tapUpDetails);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            (widget.bottomWidget == null)
                ? Center(child: widget.topWidget)
                : Positioned(
                    top: topWidgetOffset,
                    child: SizedBox(
                      key: topKey,
                      child: widget.topWidget,
                    ),
                  ),
            if (widget.bottomWidget != null)
              Positioned(
                top: bottomWidgetOffset,
                child: SizedBox(
                  key: bottomKey,
                  child: Center(child: widget.bottomWidget),
                ),
              ),
            Positioned.fill(
              child: CustomPaint(
                painter: EquatorLinePainter(color: widget.lineColor),
              ),
            ),
          ],
        ),
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
      ..strokeWidth = _DialerButtonState.strokeWidth;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
