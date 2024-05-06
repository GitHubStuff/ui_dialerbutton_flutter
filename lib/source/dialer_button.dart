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

  const DialerButton({
    super.key,
    required this.topWidget,
    this.bottomWidget,
    this.onTapUp,
    this.onTapDown,
    this.diameter = 80.0,
    this.lineColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    this.splashColor = const Color(0x1900FF00), // Very light transparent green
  });

  @override
  State<DialerButton> createState() => _DialerButtonState();
}

class _DialerButtonState extends State<DialerButton> {
  final GlobalKey topKey = GlobalKey();
  final GlobalKey bottomKey = GlobalKey();
  double? topWidgetHeight;

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
    final double topWidgetOffset = topWidgetHeight != null
        ? centerLine - topWidgetHeight!
        : centerLine; // Calculate the top offset

    final double bottomWidgetOffset = centerLine / 2 + 12.0;

    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.backgroundColor),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(CircleBorder(
              side: BorderSide(color: widget.borderColor, width: 2))),
          padding:
              MaterialStateProperty.all(EdgeInsets.all(widget.diameter / 10)),
          fixedSize:
              MaterialStateProperty.all(Size(widget.diameter, widget.diameter)),
          elevation: MaterialStateProperty.all(0.0),
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
