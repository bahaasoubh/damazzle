import 'dart:math';
import 'dart:ui';
import 'package:damazzle/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';


class BackgroundPainter extends CustomPainter {
  BackgroundPainter({Animation<double>animation})
      : blue1Paint = Paint()
          ..color = DamazzleColors.darkOrange
          ..style = PaintingStyle.fill,
        blue2Paint = Paint()
          ..color = DamazzleColors.orange
          ..style = PaintingStyle.fill,
        blue3Paint = Paint()
          ..color = DamazzleColors.accentOrange
          ..style = PaintingStyle.fill,

        liquidAnim = CurvedAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
          parent: animation,
        ),
        blue2Anim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.7,
            curve: Interval(0, 0.8, curve: SpringCurve()),
          ),
          reverseCurve: Curves.linear,
        ),

        blue3Anim = CurvedAnimation(
          parent: animation,
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),

  super(repaint: animation);
  final Animation<double> liquidAnim;
  final Animation<double> blue2Anim;
  final Animation<double> blue3Anim;

  final Paint blue1Paint;
  final Paint blue2Paint;
  final Paint blue3Paint;
  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need three or more points to create a path.');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    // connect the last two points
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }


  @override
  void paint(Canvas canvas, Size size) {
    print("size");
    paint3Blue(size, canvas);
paintBlue2(size, canvas);
paintBlue1(canvas, size);


  }
  void paintBlue1(Canvas canvas , Size size){
    final path =Path();
    _addPointsToPath(path, [
Point(size.width/1.6, 0),
      Point(size.width/1.5, 0),
      // Point(size.width/1.8, size.height/8),
      Point(size.width/2, size.height/9),
      Point(size.width/4, size.height/10),
      Point(size.width/14, size.height/11),

      Point(0, size.height/9),
    ]);
    canvas.drawPath(path, blue1Paint);

  }
  void paintBlue2(Size size, Canvas canvas) {
    final path = Path();
    path.moveTo(size.width, size.height/2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(
        size.height / 4,
        size.height / 4,
        blue2Anim.value,
      ),
    );
    _addPointsToPath(
      path,
      [
        Point(
          size.width / 4,
          lerpDouble(size.height / 3, size.height /2, liquidAnim.value),
        ),
        Point(
          size.width * 3 / 5,
          lerpDouble(size.height / 4, size.height / 2, liquidAnim.value),
        ),
        Point(
          size.width * 4 / 5,
          lerpDouble(size.height / 6, size.height / 3, blue2Anim.value),
        ),
        Point(
          size.width,
          lerpDouble(size.height / 5, size.height / 3, blue2Anim.value),
        ),
      ],
    );

    canvas.drawPath(path, blue2Paint);
  }
  void paint3Blue(Size size, Canvas canvas) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(0, size.height/2, blue3Anim.value),
    );
    _addPointsToPath(path, [
      Point(
        lerpDouble(0, size.width / 3, blue3Anim.value),
        lerpDouble(0, size.height/1.1, blue3Anim.value),
      ),
      Point(
        lerpDouble(size.width / 2, size.width / 4 * 3, liquidAnim.value),
        lerpDouble(size.height / 2, size.height /2, liquidAnim.value),
      ),
      Point(
        size.width,
        lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value),
      ),
    ]);
    canvas.drawPath(path, blue3Paint);
  }




  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });

  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}
