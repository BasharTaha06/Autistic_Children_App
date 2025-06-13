import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GeometricShapesColorsGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShapeQuestionScreen();
  }
}

class ShapeQuestionScreen extends StatefulWidget {
  @override
  _ShapeQuestionScreenState createState() => _ShapeQuestionScreenState();
}

class _ShapeQuestionScreenState extends State<ShapeQuestionScreen> {
  final List<Shape> shapes = [
    Shape.square,
    Shape.circle,
    Shape.triangle,
    Shape.diamond,
  ];

  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.brown,
    Colors.black,
  ];

  late ShapeOption correct;
  ShapeOption? selected;

  List<ShapeOption> options = [];

  final _rng = Random();

  void generateQuestionAndOptions() {
    correct = ShapeOption(
      shape: shapes[_rng.nextInt(shapes.length)],
      color: colors[_rng.nextInt(colors.length)],
    );

    options = [correct];
    while (options.length < 8) {
      var option = ShapeOption(
        shape: shapes[_rng.nextInt(shapes.length)],
        color: colors[_rng.nextInt(colors.length)],
      );

      if (!options.contains(option)) {
        options.add(option);
      }
    }

    options.shuffle();

    setState(() {});
  }

  void checkAnswer(ShapeOption choice) {
    setState(() {
      selected = choice;
    });

    if (choice == correct) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('إجابة صحيحة!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/animations/tasqef.json',
                height: 150,
                repeat: true,
              ),
              Text('اخترت الشكل الصحيح'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                generateQuestionAndOptions();
              },
              child: Text('تمام'),
            )
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Align(
              alignment: Alignment.centerRight, child: Text('!إجابة خاطئة')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/animations/sadAnimation.json',
                height: 150,
                repeat: true,
                animate: true,
              ),
              Text('حاول مرة أخرى'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('تمام'),
            )
          ],
        ),
      );
    }
  }

  String getArabicName(Shape shape) {
    switch (shape) {
      case Shape.square:
        return 'مربع';
      case Shape.circle:
        return 'دائرة';
      case Shape.triangle:
        return 'مثلث';
      case Shape.diamond:
        return 'معين';
      default:
        return '';
    }
  }

  Widget _buildShape(ShapeOption option, {bool clickable = true}) {
    double shapeSize = MediaQuery.of(context).size.width * 0.20;

    Widget shapeWidget;

    if (option.shape == Shape.square) {
      shapeWidget = Container(
        width: shapeSize,
        height: shapeSize,
        color: option.color,
        child: Center(
          child:
              Icon(Icons.square, color: Colors.black26, size: shapeSize * 0.5),
        ),
      );
    } else if (option.shape == Shape.circle) {
      shapeWidget = Container(
        width: shapeSize,
        height: shapeSize,
        decoration: BoxDecoration(
          color: option.color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child:
              Icon(Icons.circle, color: Colors.black26, size: shapeSize * 0.5),
        ),
      );
    } else if (option.shape == Shape.triangle) {
      shapeWidget = CustomPaint(
        size: Size(shapeSize, shapeSize),
        painter: TrianglePainter(option.color),
      );
    } else if (option.shape == Shape.diamond) {
      shapeWidget = Transform.rotate(
        angle: 0.79,
        child: Container(
          width: shapeSize,
          height: shapeSize,
          color: option.color,
          child: Center(
            child: Icon(Icons.diamond,
                color: Colors.black26, size: shapeSize * 0.5),
          ),
        ),
      );
    } else {
      shapeWidget = Container(width: shapeSize, height: shapeSize);
    }

    return clickable
        ? GestureDetector(
            onTap: () => checkAnswer(option),
            child: Card(
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    shapeWidget,
                    SizedBox(height: 10),
                    Text(
                      getArabicName(option.shape),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          )
        : Card(
            color: Colors.white,
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  shapeWidget,
                  SizedBox(height: 10),
                  Text(
                    getArabicName(correct.shape),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    generateQuestionAndOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(194, 217, 209, 1),
        centerTitle: false,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text('اختر الشكل الصحيح حسب اللون والنمط'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'اختر الشكل الذي يتطابق مع التالي',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildShape(correct, clickable: false),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // <- disable its own scroll
                itemCount: (options.length / 2).ceil(), // number of rows
                itemBuilder: (context, index) {
                  int first = index * 2;
                  int? second = first + 1 < options.length ? first + 1 : null;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildShape(options[first]),
                        if (second != null) _buildShape(options[second]),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Shape { square, circle, triangle, diamond }

class ShapeOption {
  final Shape shape;
  final Color color;

  ShapeOption({required this.shape, required this.color});

// To enable comparison:
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShapeOption && other.shape == shape && other.color == color;

  @override
  int get hashCode => shape.hashCode ^ color.hashCode;
}

class TrianglePainter extends CustomPainter {
  TrianglePainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter old) => false;
}
