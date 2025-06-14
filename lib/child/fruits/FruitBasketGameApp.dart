import 'package:flutter/material.dart';

void main() {
  runApp(FruitBasketGameApp());
}

class FruitBasketGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FruitBasketGameScreen();
  }
}

class FruitBasketGameScreen extends StatefulWidget {
  @override
  _FruitBasketGameScreenState createState() => _FruitBasketGameScreenState();
}

class _FruitBasketGameScreenState extends State<FruitBasketGameScreen> {
  int appleCount = 0;
  int grapeCount = 0;
  int bananaCount = 0;

  final int maxCount = 5;

  bool appleFull = false;
  bool grapeFull = false;
  bool bananaFull = false;

  void _onDrop(String item, String basket) {
    if (item == basket) {
      setState(() {
        if (item == 'apple') {
          if (appleCount < maxCount) {
            appleCount++;
            if (appleCount == maxCount) appleFull = true;
          }
        } else if (item == 'grape') {
          if (grapeCount < maxCount) {
            grapeCount++;
            if (grapeCount == maxCount) grapeFull = true;
          }
        } else if (item == 'banana') {
          if (bananaCount < maxCount) {
            bananaCount++;
            if (bananaCount == maxCount) bananaFull = true;
          }
        }
      });

      if (appleFull && grapeFull && bananaFull) {
        _showCompletionDialog();
      }
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('شاطر 👏'),
        content: Text('لقد أكملت اللعبة!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // اذا أردت أن تعيد اللعبة
              setState(() {
                appleCount = 0;
                grapeCount = 0;
                bananaCount = 0;

                appleFull = false;
                grapeFull = false;
                bananaFull = false;
              });
            },
            child: Text('إعادة اللعبة'),
          )
        ],
      ),
    );
  }

  Widget _buildDraggable(String item, String emoji) {
    return Draggable<String>(
      data: item,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Text(emoji, style: TextStyle(fontSize: 50)),
      ),
      feedback: Material(
        color: Colors.transparent,
        child: Text(emoji, style: TextStyle(fontSize: 50)),
      ),
      childWhenDragging: Opacity(
          opacity: 0.5, child: Text(emoji, style: TextStyle(fontSize: 50))),
    );
  }

  Widget _buildTarget(String basketId, String label, bool isFull, int count) {
    return Column(
      children: [
        DragTarget<String>(
          builder: (context, candidate, _) {
            return Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 5)),
                ],
                image: DecorationImage(
                  image: AssetImage('assets/images/box2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  if (isFull)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Icon(Icons.star, color: Colors.yellow, size: 30),
                    ),
                ],
              ),
            );
          },
          onAccept: (item) {
            _onDrop(item, basketId);
          },
        ),
        SizedBox(height: 8),
        Text(
          "$label\n$count/$maxCount",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        centerTitle: true,
        title: Text('لعبة سلة الفواكه 🍉',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[100]!, Colors.green[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'اسحب الفاكهة إلى السلة الصحيحه',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // الفواكه في الأعلى
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDraggable('apple', '🍏'),
                _buildDraggable('grape', '🍇'),
                _buildDraggable('banana', '🍌'),
              ],
            ),
            // السلة في الأسفل
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTarget('apple', 'سلة تفاح', appleFull, appleCount),
                _buildTarget('grape', 'سلة عنب', grapeFull, grapeCount),
                _buildTarget('banana', 'سلة موز', bananaFull, bananaCount),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
