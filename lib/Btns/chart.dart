import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';

class ChildProgressPage extends StatefulWidget {
  const ChildProgressPage({Key? key}) : super(key: key);

  @override
  State<ChildProgressPage> createState() => _ChildProgressPageState();
}

class _ChildProgressPageState extends State<ChildProgressPage>
    with SingleTickerProviderStateMixin {
  String? parentId;
  String? childName;
  String username = '';
  bool loading = true;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    getMyInfo();
  }

  Future<void> getMyInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final result = await findParentAndChildInfo(user.email!);
      if (result != null) {
        parentId = result['parentId'];
        childName = result['childName'];
        setState(() => loading = false);
        _controller.forward(); // نشغل الأنميشن مرة واحدة فقط
      } else {
        setState(() => loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لم يتم العثور على بيانات الطفل')),
        );
      }
    }
  }

  Future<Map<String, String>?> findParentAndChildInfo(String childEmail) async {
    final parentsSnapshot =
        await FirebaseFirestore.instance.collection('parents').get();

    for (var parentDoc in parentsSnapshot.docs) {
      final childrenSnapshot =
          await parentDoc.reference.collection('children').get();

      for (var childDoc in childrenSnapshot.docs) {
        final data = childDoc.data();
        if (data['email'] == childEmail) {
          return {
            'parentId': parentDoc.id,
            'childName': childDoc.id,
          };
        }
      }
    }

    return null;
  }

  double getExtraTries(int total, int success, int fail) {
    final result = total - success - fail;
    if (result < 0 || result.isNaN) return 0;
    return result.toDouble();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('تقدمك')),
      body: loading || parentId == null || childName == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('parents')
                  .doc(parentId)
                  .collection('children')
                  .doc(childName)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(
                      child: Text('لم يتم العثور على البيانات'));
                }

                final data = snapshot.data!.data() as Map<String, dynamic>;
                final succes = data['succes'] ?? 0;
                final fail = data['fail'] ?? 0;
                final totalTry = data['TotalTry'] ?? 0;
                final name = data['name'] ?? childName!;
                final extra = getExtraTries(totalTry, succes, fail);

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('$name , مرحباً 👋',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 20),
                      FadeTransition(
                        opacity: _controller,
                        child: AspectRatio(
                          aspectRatio: 1.3,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(
                                  color: Colors.green,
                                  value: succes.toDouble(),
                                  title: 'ناجح',
                                  radius: 60,
                                  titleStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                PieChartSectionData(
                                  color: Colors.red,
                                  value: fail.toDouble(),
                                  title: 'فشل',
                                  radius: 60,
                                  titleStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                PieChartSectionData(
                                  color: Colors.blue,
                                  value: extra,
                                  title: 'محاولات',
                                  radius: 60,
                                  titleStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text('✅ النجاح: $succes',
                          style: const TextStyle(fontSize: 16)),
                      Text('❌ الفشل: $fail',
                          style: const TextStyle(fontSize: 16)),
                      Text('📊 إجمالي المحاولات: $totalTry',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
