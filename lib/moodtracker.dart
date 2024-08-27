import 'package:flutter/material.dart';

class SleepPatternWidget extends StatefulWidget {
  @override
  _SleepPatternWidgetState createState() => _SleepPatternWidgetState();
}

class _SleepPatternWidgetState extends State<SleepPatternWidget> {
  List<double> _sleepData = [6.5, 7.0, 6.0, 8.0, 7.5]; // Sample data

  @override
  Widget build(BuildContext context) {
    // Determine the maximum value for scaling
    double maxValue = _sleepData.reduce((a, b) => a > b ? a : b);

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 53, 92, 102), // Background color
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sleep Pattern Tracker',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 200, // Height of the graph container
            child: CustomPaint(
              painter: SleepGraphPainter(_sleepData, maxValue),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}

class SleepGraphPainter extends CustomPainter {
  final List<double> sleepData;
  final double maxValue;

  SleepGraphPainter(this.sleepData, this.maxValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint barPaint = Paint()..color = Colors.blue;

    // Add padding to the left for the labels
    final double paddingLeft = 40.0;
    final double barWidth = (size.width - paddingLeft) / (sleepData.length * 2);

    for (int i = 0; i < sleepData.length; i++) {
      final double barHeight = (sleepData[i] / maxValue) * size.height;
      final double barX = paddingLeft + i * barWidth * 2 + barWidth / 2;
      final double barY = size.height - barHeight;

      canvas.drawRect(
        Rect.fromLTWH(barX, barY, barWidth, barHeight),
        barPaint,
      );
    }

    _drawReferenceLines(canvas, size, paddingLeft);
  }

  void _drawReferenceLines(Canvas canvas, Size size, double paddingLeft) {
    final Paint linePaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final TextPainter textPainter = TextPainter(
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
    );

    double step = maxValue / 5; // Number of reference lines
    for (int i = 0; i <= 5; i++) {
      double y = size.height - (size.height / 5 * i);
      canvas.drawLine(Offset(paddingLeft, y), Offset(size.width, y), linePaint);

      final String label = '${(step * i).toStringAsFixed(1)}h';
      textPainter.text = TextSpan(
        text: label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      );
      textPainter.layout();

      // Adjusted the x-offset to move the labels further to the left
      textPainter.paint(canvas, Offset(paddingLeft - 30, y - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
