import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TrafficGamePage(),
  ));
}

class TrafficGamePage extends StatefulWidget {
  @override
  _TrafficGamePageState createState() => _TrafficGamePageState();
}

class _TrafficGamePageState extends State<TrafficGamePage> {
  int progress = 0;
  int maxProgress = 100;
  String currentLight = 'red';
  int wins = 0;
  int losses = 0;
  Timer? trafficTimer;

  @override
  void initState() {
    super.initState();
    startTrafficLightCycle();
  }

  void startTrafficLightCycle() {
    trafficTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        if (currentLight == 'red')
          currentLight = 'green';
        else if (currentLight == 'green')
          currentLight = 'yellow';
        else
          currentLight = 'red';
      });
    });
  }

  void movePlayer() {
    if (currentLight == 'red') {
      losses++;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("توقف!"),
          content: Text("حاول مرة أخرى"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  progress = 0;
                });
                Navigator.pop(context);
              },
              child: Text("حسناً"),
            )
          ],
        ),
      );
    } else {
      setState(() {
        if (currentLight == 'yellow')
          progress += 2;
        else if (currentLight == 'green') progress += 4;

        if (progress >= maxProgress) {
          wins++;
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("مبروك!"),
              content: Text("لقد فزت باللعبة!"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      progress = 0;
                    });
                    Navigator.pop(context);
                  },
                  child: Text("إعادة"),
                )
              ],
            ),
          );
        }
      });
    }
  }

  Color getLightColor(String light) {
    if (currentLight == light)
      return light == 'red'
          ? Colors.red
          : light == 'yellow'
              ? Colors.yellow
              : Colors.green;
    else
      return Colors.grey;
  }

  @override
  void dispose() {
    trafficTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(title: Text("Traffic Light Game")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.black12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(backgroundColor: getLightColor('red')),
                      CircleAvatar(backgroundColor: getLightColor('yellow')),
                      CircleAvatar(backgroundColor: getLightColor('green')),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: Lottie.network(
                    'https://assets3.lottiefiles.com/packages/lf20_3rwasyjy.json',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress / maxProgress,
              minHeight: 20,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text("🏁 خط النهاية", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("🏆 المكاسب: $wins", style: TextStyle(fontSize: 18)),
                Text("❌ الخسائر: $losses", style: TextStyle(fontSize: 18)),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: movePlayer,
              child: Text("تحرك"),
            ),
          ],
        ),
      ),
    );
  }
}
