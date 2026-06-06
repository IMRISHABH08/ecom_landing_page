import 'package:flutter/material.dart';

class MarqueeAnimation extends StatefulWidget {
  const MarqueeAnimation({
    super.key,
    required this.text,
    required this.style,
    required this.height,
    this.velocity = 60.0,
    this.gap = 80.0,
  });

  final String text;
  final TextStyle style;
  final double height;
  final double velocity;
  final double gap;

  @override
  State<MarqueeAnimation> createState() => _MarqueeAnimationState();
}

class _MarqueeAnimationState extends State<MarqueeAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _textWidth = 0;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  void _measure() {
    if (!mounted) return;
    final painter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      textDirection: TextDirection.ltr,
    )..layout();
    _textWidth = painter.width + widget.gap;

    _controller.duration = Duration(
      milliseconds: (_textWidth / widget.velocity * 1000).round(),
    );
    _controller.repeat();
    setState(() => _ready = true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return SizedBox(height: widget.height);

    return SizedBox(
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          painter: _MarqueePainter(
            text: widget.text,
            style: widget.style,
            offset: _controller.value * _textWidth,
            textWidth: _textWidth,
            canvasHeight: widget.height,
          ),
        ),
      ),
    );
  }
}

class _MarqueePainter extends CustomPainter {
  _MarqueePainter({
    required this.text,
    required this.style,
    required this.offset,
    required this.textWidth,
    required this.canvasHeight,
  });

  final String text;
  final TextStyle style;
  final double offset;
  final double textWidth;
  final double canvasHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    final y = (canvasHeight - tp.height) / 2;

    tp.paint(canvas, Offset(-offset, y));
    tp.paint(canvas, Offset(-offset + textWidth, y));
  }

  @override
  bool shouldRepaint(_MarqueePainter old) => old.offset != offset;
}
