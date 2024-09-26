import 'package:flutter/material.dart';
import 'styled_text.dart';

class MeasurementSlider extends StatelessWidget {
  final String title;
  final String unit;
  final double value;
  final double minimum;
  final double maximum;
  final ValueChanged<double> onChanged;

  const MeasurementSlider({
    super.key,
    required this.title,
    required this.unit,
    required this.value,
    required this.minimum,
    required this.maximum,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StyledText(
              text: title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            StyledText(
              text: '${value.toStringAsFixed(0)} $unit',
              style: const TextStyle(
                  fontSize: 16, color: Color.fromRGBO(3, 71, 255, 1)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50, // Increased height to accommodate spacing
          child: Stack(
            children: [
              CustomPaint(
                size: const Size(double.infinity, 50),
                painter: SliderPainter(
                  value: (value - minimum) / (maximum - minimum),
                ),
              ),
              Positioned.fill(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackShape: CustomTrackShape(),
                    thumbColor: Theme.of(context).primaryColor,
                    activeTrackColor: Colors.transparent,
                    inactiveTrackColor: Colors.transparent,
                    overlayColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 20.0),
                  ),
                  child: Slider(
                    value: value,
                    min: minimum,
                    max: maximum,
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SliderPainter extends CustomPainter {
  final double value;

  const SliderPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromRGBO(3, 71, 255, 1)
      ..strokeWidth = 1;

    final activeTrackPaint = Paint()
      ..color = Color.fromRGBO(3, 71, 255, 1)
      ..strokeWidth = 4;

    final inactiveTrackPaint = Paint()
      ..color = Color.fromRGBO(3, 71, 255, 1).withOpacity(0.3)
      ..strokeWidth = 4;

    final totalLines = 7;
    final lineSpacing = size.width / (totalLines - 1);
    final sliderY = size.height / 2; // Center the slider vertically

    // Draw scale lines (excluding start and end)
    for (int i = 1; i < totalLines - 1; i++) {
      final x = i * lineSpacing;
      canvas.drawLine(Offset(x, sliderY + 10), Offset(x, size.height), paint);
    }

    // Draw inactive track
    canvas.drawLine(
      Offset(0, sliderY),
      Offset(size.width, sliderY),
      inactiveTrackPaint,
    );

    // Draw active track
    canvas.drawLine(
      Offset(0, sliderY),
      Offset(size.width * value, sliderY),
      activeTrackPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
