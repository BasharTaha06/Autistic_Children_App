import 'package:audioplayers/audioplayers.dart';
import 'package:autisticchildren/child/Voice/VoiceItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceScreen extends StatefulWidget {
  final VoiceItem item;

  VoiceScreen({required this.item});

  @override
  _VoiceScreenState createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool isRecording = false;
  bool? comparisonResult;
  String recordedText = '';
  double lastScore = 0;
  String childName = "محمد";
  String parentEmail = "amam@123";
  @override
  void initState() {
    super.initState();
    // _initCamera();
    fetchChildInfo();
  }

// to get the parent email and the child name to store the resoult
  Future<void> fetchChildInfo() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print('No user is currently logged in.');
      return;
    }

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // جلب كل أولياء الأمور
      QuerySnapshot parentSnapshot =
          await firestore.collection('parents').get();

      for (var parentDoc in parentSnapshot.docs) {
        String parentId = parentDoc.id;

        // جلب كل الأطفال لهذا الأب
        QuerySnapshot childrenSnapshot = await firestore
            .collection('parents')
            .doc(parentId)
            .collection('children')
            .get();

        for (var childDoc in childrenSnapshot.docs) {
          Map<String, dynamic> childData =
              childDoc.data() as Map<String, dynamic>;

          if (childData['email'] == currentUser.email) {
            // خزّن البيانات في المتغيرات العامة
            childName = childData['name'] ?? 'غير معروف';
            parentEmail = childData['Parentemail'] ?? 'غير معروف';

            print('Child Name: $childName');
            print('Parent Email: $parentEmail');

            return;
          }
        }
      }

      print('Child not found in Firestore.');
    } catch (e) {
      print('Error fetching child info: $e');
    }
  }

  Future<void> playAudio() async {
    await _audioPlayer.play(AssetSource(widget.item.voicePath));
  }

  Future<void> startListening() async {
    bool available = await _speech.initialize();
    if (!available) {
      print("Speech recognition not available");
      return;
    }

    setState(() {
      isRecording = true;
      recordedText = '';
      comparisonResult = null;
    });

    _speech.listen(
      onResult: (result) {
        setState(() {
          recordedText = result.recognizedWords;
        });

        // When speech is finished, stop and evaluate
        if (result.finalResult) {
          stopListening(); // This will stop and trigger compare
        }
      },
      listenFor: const Duration(seconds: 10),
      pauseFor: const Duration(seconds: 2),
      localeId: 'ar_EG',
      cancelOnError: true,
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
    setState(() => isRecording = false);
    compareText();
    _showComparisonResult(
      lastScore,
    ); // Show dialog immediately
  }

  String normalizeArabic(String input) {
    return input
        .replaceAll(RegExp(r'[ًٌٍَُِّْ]'), '') // remove harakat
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ى', 'ي')
        .replaceAll('ة', 'ه')
        .replaceAll('ؤ', 'و')
        .replaceAll('ئ', 'ي')
        .replaceAll(RegExp(r'[^\u0600-\u06FF\s]'), '') // remove non-Arabic
        .trim();
  }

  void compareText() {
    String expected = normalizeArabic(widget.item.expectedText);
    String spoken = normalizeArabic(recordedText);

    int matchedWords = 0;
    List<String> expectedWords = expected.split(' ');
    List<String> spokenWords = spoken.split(' ');

    for (var word in spokenWords) {
      if (expectedWords.contains(word)) {
        matchedWords++;
      }
    }

    double score = expectedWords.isNotEmpty
        ? (matchedWords / expectedWords.length) * 100
        : 0;

    setState(() {
      lastScore = score;
      comparisonResult = score >= 90;
    });
  }

  void _showComparisonResult(double score) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('نتيجة المقارنة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'درجة التطابق: ${score.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              score >= 90 ? 'شاطر!' : 'حاول مرة أخرى',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: score >= 70 ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('حسنا'),
          ),
        ],
      ),
    );
  }

  /* فيرجن 2 من تخزين الداتا 
  void _showComparisonResult({
    required double score,
    required String parentEmail,
    required String childName,
  }) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // البحث عن ولي الأمر
      QuerySnapshot parentSnapshot = await firestore
          .collection('parents')
          .where('email', isEqualTo: parentEmail)
          .get();

      if (parentSnapshot.docs.isNotEmpty) {
        String parentId = parentSnapshot.docs.first.id;

        DocumentReference childRef = firestore
            .collection('parents')
            .doc(parentId)
            .collection('children')
            .doc(childName);

        DocumentSnapshot childDoc = await childRef.get();

        if (childDoc.exists) {
          int currentSuccess = childDoc.get('succes') ?? 0;
          int currentFail = childDoc.get('fail') ?? 0;
          int currentTotalTry = childDoc.get('TotalTry') ?? 0;

          // تحديث القيم حسب الدرجة
          if (score >= 80) {
            currentSuccess += 1;
          } else {
            currentFail += 1;
          }
          currentTotalTry += 1;

          await childRef.update({
            'succes': currentSuccess,
            'fail': currentFail,
            'TotalTry': currentTotalTry,
          });
        }
      }
    } catch (e) {
      print('❌ حدث خطأ أثناء تحديث النتيجة: $e');
    }

    // عرض النتيجة بعد التخزين
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('نتيجة المقارنة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'درجة التطابق: ${score.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              score >= 80 ? 'شاطر!' : 'حاول مرة أخرى',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: score >= 80 ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسنا'),
          ),
        ],
      ),
    );
  }
*/
/*  void _showComparisonResult({
    required double score,
    required String parentEmail,
    required String childName,
  }) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // البحث عن ولي الأمر
      QuerySnapshot parentSnapshot = await firestore
          .collection('parents')
          .where('email', isEqualTo: parentEmail)
          .get();

      if (parentSnapshot.docs.isNotEmpty) {
        String parentId = parentSnapshot.docs.first.id;

        DocumentReference childRef = firestore
            .collection('parents')
            .doc(parentId)
            .collection('children')
            .doc(childName);

        DocumentSnapshot childDoc = await childRef.get();

        if (childDoc.exists) {
          int currentSuccess = childDoc.get('succes') ?? 0;
          int currentFail = childDoc.get('fail') ?? 0;
          int currentTotalTry = childDoc.get('TotalTry') ?? 0;

          if (score >= 80) {
            currentSuccess += 1;
            currentFail = currentFail > 0 ? currentFail - 1 : 0;
          } else if (score < 80) {
            currentFail += 1;
            // currentSuccess = currentSuccess > 0 ? currentSuccess - 1 : 0;
          }

          currentTotalTry += 1;

          await childRef.update({
            'succes': currentSuccess,
            'fail': currentFail,
            'TotalTry': currentTotalTry,
          });
        }
      }
    } catch (e) {
      print('❌ حدث خطأ أثناء تحديث النتيجة: $e');
    }

    // عرض النتيجة بعد التخزين
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('نتيجة المقارنة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'درجة التطابق: ${score.toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              score >= 80 ? 'شاطر!' : 'حاول مرة أخرى',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: score >= 80 ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigator.pop(context);
            },
            child: const Text('حسنا'),
          ),
        ],
      ),
    );
  }*/

  void reset() {
    setState(() {
      recordedText = '';
      comparisonResult = null;
      lastScore = 0;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _speech.stop();
    super.dispose();
  }

  Widget buildRecordButton() {
    return GestureDetector(
      onTap: isRecording ? stopListening : startListening,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isRecording ? Colors.red : Colors.green,
        ),
        child: Icon(
          isRecording ? Icons.stop : Icons.mic,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice Match")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(widget.item.imagePath),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: playAudio,
              child: const Text("تشغيل الصوت"),
            ),
            const SizedBox(height: 20),
            buildRecordButton(),
            const SizedBox(height: 20),
            const Text(
              "نصك المسجل:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              recordedText,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (comparisonResult != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _showComparisonResult(
                      lastScore,
                    ),
                    child: const Text("عرض النتيجة"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
