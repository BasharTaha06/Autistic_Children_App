import 'dart:io';
import 'package:autisticchildren/child/Face/reactii_model.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CameraComparisonScreen extends StatefulWidget {
  final Reaction selectedReaction;
  final bool useFrontCamera;

  const CameraComparisonScreen({
    super.key,
    required this.selectedReaction,
    required this.useFrontCamera,
  });

  @override
  State<CameraComparisonScreen> createState() => _CameraComparisonScreenState();
}

class _CameraComparisonScreenState extends State<CameraComparisonScreen> {
  CameraController? _controller;
  bool _isCameraReady = false;
  bool _isProcessing = false;
  double? _similarityScore;
  String childName = "محمد";
  String parentEmail = "amam@123";
  @override
  void initState() {
    super.initState();
    _initCamera();
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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final camera = widget.useFrontCamera
        ? cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.front,
          )
        : cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.back,
          );

    _controller = CameraController(camera, ResolutionPreset.medium);
    await _controller!.initialize();
    if (!mounted) return;
    setState(() => _isCameraReady = true);
  }

  Future<void> _captureAndCompare() async {
    if (_isProcessing || !_isCameraReady) return;
    setState(() => _isProcessing = true);

    try {
      final image = await _controller!.takePicture();
      final faces = await _detectFaces(image.path);

      if (faces.isNotEmpty) {
        final face = faces.first;
        final score = _compareWithReaction(face);
        setState(() => _similarityScore = score);
        _showComparisonResult(
            score: score, childName: childName, parentEmail: parentEmail);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('No face detected')));
      }

      await _deleteTempFile(image.path);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _deleteTempFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('Error deleting temp file: $e');
    }
  }

  Future<List<Face>> _detectFaces(String imagePath) async {
    final options = FaceDetectorOptions(
      performanceMode: FaceDetectorMode.accurate,
      enableLandmarks: true,
      enableClassification: true,
    );
    final faceDetector = FaceDetector(options: options);
    final inputImage = InputImage.fromFilePath(imagePath);
    final faces = await faceDetector.processImage(inputImage);
    await faceDetector.close();
    return faces;
  }

  double _compareWithReaction(Face face) {
    // Extract facial features
    final mouthWidth = _getMouthWidth(face);
    final eyebrowTension = _getEyebrowTension(face);
    final eyeOpenness = _getEyeOpenness(face);
    final smileProb = face.smilingProbability ?? 0;
    final mouthCornersDown = _getMouthCornersDown(face);

    // Get target values
    final target = widget.selectedReaction.keyPoints;

    // Calculate similarity scores (0-100)
    final mouthWidthScore =
        100 - (mouthWidth - target['mouthWidth']).abs() * 0.5;
    final eyebrowScore =
        100 - (eyebrowTension - target['eyebrowTension']).abs() * 2;
    final eyeScore = 100 - (eyeOpenness - target['eyeOpenness']).abs() * 50;
    final smileScore =
        100 - (smileProb - target['smileProbability']).abs() * 100;
    final mouthCornersScore = target.containsKey('mouthCornersDown')
        ? 100 - (mouthCornersDown - target['mouthCornersDown']).abs() * 3
        : 50; // Neutral score if this parameter doesn't exist for reaction

    // Weighted average (adjust weights based on importance)
    return (mouthWidthScore * 0.25 +
            eyebrowScore * 0.25 +
            eyeScore * 0.15 +
            smileScore * 0.15 +
            mouthCornersScore * 0.2)
        .clamp(0, 100);
  }

  int _getMouthWidth(Face face) {
    final left = face.landmarks[FaceLandmarkType.leftMouth]?.position.x ?? 0;
    final right = face.landmarks[FaceLandmarkType.rightMouth]?.position.x ?? 0;
    return right - left;
  }

  int _getEyebrowTension(Face face) {
    final left = face.landmarks[FaceLandmarkType.leftEye]?.position.y ?? 0;
    final right = face.landmarks[FaceLandmarkType.rightEye]?.position.y ?? 0;
    return (right - left).abs();
  }

  double _getEyeOpenness(Face face) {
    final leftOpen = face.leftEyeOpenProbability ?? 0;
    final rightOpen = face.rightEyeOpenProbability ?? 0;
    return (leftOpen + rightOpen) / 2;
  }

  double _getMouthCornersDown(Face face) {
    final leftMouth =
        face.landmarks[FaceLandmarkType.leftMouth]?.position.y ?? 0;
    final rightMouth =
        face.landmarks[FaceLandmarkType.rightMouth]?.position.y ?? 0;
    final mouthBottom =
        face.landmarks[FaceLandmarkType.bottomMouth]?.position.y ?? 0;

    // Calculate how much the corners are lower than the center
    return ((leftMouth + rightMouth) / 2) - mouthBottom;
  }

  // void _showComparisonResult(double score) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('نتيجة المقارنة'),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             score >= 70 ? 'شاطر!' : 'حاول مرة أخرى',
  //             style: TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.bold,
  //               color: score >= 70 ? Colors.green : Colors.orange,
  //             ),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //             Navigator.pop(context);
  //           },
  //           child: const Text('حسنا'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _showComparisonResult(
      {required double score,
      required String parentEmail,
      required String childName}) async {
    // تحديث البيانات في Firestore قبل عرض الرسالة
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
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

          if (score > 80) {
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
      print('حدث خطأ أثناء تحديث النتيجة: $e');
    }

    // عرض الرسالة بعد التخزين
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('نتيجة المقارنة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              score >= 80 ? 'شاطر!' : 'حاول مرة أخرى',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: score >= 80 ? Colors.green : Colors.orange,
              ),
            ),
            if (score >= 80)
              Lottie.asset(
                'assets/animations/tasqef.json',
                height: 150,
                repeat: true,
              ),
            if (score < 80)
              Lottie.asset('assets/animations/sadAnimation.json',
                  height: 150, repeat: true, animate: true),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedReaction.name}'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if (_isCameraReady) CameraPreview(_controller!),
          if (!_isCameraReady) const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: _captureAndCompare,
                child: _isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
