import 'package:autisticchildren/parent/Logic/parent_login_cubit.dart';
import 'package:autisticchildren/login_type.dart';
import 'package:autisticchildren/parent/home/display_Articel.dart';
import 'package:autisticchildren/parent/home/imergance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class Articales extends StatefulWidget {
  @override
  State<Articales> createState() => _ArticalesState();
}

class _ArticalesState extends State<Articales> {
  String name = 'with us';
  User? user = FirebaseAuth.instance.currentUser;
  final List articels_Name = [
    "دور الأسرة والمجتمع في التعامل مع طفل التوحد",
    "كيف تجعل الطفل يبتسم"
  ];
  final List articels_source = ["جمعية الطفل العالميه ", "محمد لاشين "];
  final List articels_Content = [
    '''
يعتبر اضطراب طيف التوحد (ASD) من الاضطرابات النمائية التي تؤثر على حياة الطفل وأسرته بشكل عميق. نظراً لأن التوحد يؤثر على التواصل، التفاعل الاجتماعي، والسلوك، فإن دعم الأسرة والمجتمع يُعد عاملاً حاسماً في مساعدة الطفل على التكيف، التعلم، وتحقيق إمكاناته الكاملة. في هذا المقال، سنستعرض بالتفصيل الأدوار التي يمكن أن تلعبها الأسرة والمجتمع في دعم أطفال التوحد، مع التركيز على استراتيجيات عملية لتحسين جودة حياتهم.



1. دور الأسرة في دعم طفل التوحد.
الأسرة هي البيئة الأولى التي يتفاعل معها الطفل، وبالتالي فإن دورها محوري في تقديم الدعم العاطفي، التعليمي، والاجتماعي. فيما يلي تفصيل لدور كل فرد من أفراد الأسرة:

أ. دور الوالدين
(1) التثقيف والبحث عن المعلومات
فهم طبيعة التوحد: يجب على الوالدين تعلم كل ما يتعلق بالتوحد، من أعراضه، أنواعه، إلى أحدث طرق العلاج.
- البحث عن مصادر موثوقة: مثل مواقع منظمة Autism Speaks، CDC، أو الجمعيات المحلية المتخصصة.
- التواصل مع أخصائيين: مثل أطباء الأطفال، أخصائيي النطق، والمعالجين السلوكيين.

(2) توفير بيئة داعمة ومنظمة 
- إنشاء روتين يومي ثابت: لأن الأطفال ذوي التوحد يعتمدون على الروتين لتقليل القلق.
- استخدام الأدوات البصرية: مثل الجداول المصورة لمساعدة الطفل على فهم الخطوات اليومية (مثل وقت النوم، الأكل، المدرسة).
- توفير مساحة آمنة: خالية من المثيرات الحسية المزعجة (كالأضواء الساطعة أو الضوضاء العالية).

(3) تعزيز التواصل والتفاعل الاجتماعي 
- استخدام طرق التواصل البديل (AAC): مثل لغة الإشارة، برامج التواصل بالصور (PECS)، أو الأجهزة اللوحية المخصصة.
- (للعب التفاعلي:) تشجيع الطفل على المشاركة في ألعاب بسيطة مثل الفقاعات، الألغاز، أو الألعاب الحركية.
- (القراءة القصص الاجتماعية) :التي تساعد الطفل على فهم المواقف اليومية وكيفية التصرف فيها.

(4) التعامل مع التحديات السلوكية .
-  استخدام التعزيز الإيجابي: مكافأة السلوك الجيد بمديح، لعبة مفضلة، أو نشاط محبب.
- تجنب العقاب القاسي: 
لأن الطفل قد لا يفهم سبب العقاب، مما يزيد من توتره.
- التعاون مع معالجين سلوكيين:
لتطبيق برامج مثل (ABA) لتحسين السلوك.

(5) الاهتمام بالصحة النفسية للوالدين
- البحث عن دعم نفسي: عبر مجموعات الدعم للأهالي أو الاستشارات النفسية.
- تقسيم المهام بين الوالدين: 
لتجنب الإرهاق العاطفي والجسدي.
- أخذ فترات راحة: 
لأن رعاية طفل توحد تتطلب طاقة كبيرة.

ب. دور الإخوة والأقارب .
- التوعية حول التوحد:
شرح طبيعة حالة الطفل لإخوته حتى يكونوا أكثر تفهماً.
- تشجيع التفاعل الإيجابي:
مثل مشاركة الطفل في أنشطة بسيطة (الرسم، اللعب الهادئ).
- تجنب التمييز بين الأطفال: حتى لا يشعر الإخوة بالغبن أو الإهمال.



2. دور المجتمع في دعم أطفال التوحد. 
المجتمع بمؤسساته المختلفة (المدارس، المراكز الصحية، الأماكن العامة) يلعب دوراً حيوياً في دمج أطفال التوحد ومساعدتهم على العيش بكرامة.

أ. دور المدرسة والمعلمين
(1) توفير تعليم شامل
- دمج الطفل في الفصول العادية مع دعم إضافي: 
- مثل مساعد معلم أو تعديل المنهج.
- استخدام استراتيجيات تعليمية مناسبة: مثل:
  - التعليم البصري (الصور، الفيديوهات).
  - تقسيم المهام إلى خطوات صغيرة.
  - السماح بفترات راحة بين الدروس.

(2) تدريب المعلمين والكادر التعليمي .
- ورش عمل حول خصائص التوحد:
لتعزيز فهم المعلمين لاحتياجات الطفل.
- تعلم أساليب إدارة السلوك:
مثل التعزيز الإيجابي أو جدولة المهام.

(3) منع التنمر وتعزيز القبول
- توعية الطلاب حول التوحد: 
عبر أنشطة تثقيفية تبين أن الاختلاف طبيعي.
- تشجيع الصداقات:
 عبر برامج "رفيق التوحد" التي تدمج الطفل مع أقرانه.

ب. دور المراكز الصحية والمتخصصين
- التشخيص المبكر:
عبر فحوصات النمو الروتينية.
- توفير العلاج المناسب: 
مثل جلسات التخاطب، العلاج الوظيفي، أو التدخلات السلوكية.
- الدعم الأسري: 
- تقديم استشارات لأهالي الأطفال ذوي التوحد.

ج. دور الأماكن العامة والمجتمع المحلي .
(1) التوعية المجتمعية .
- حملات توعية:
لإزالة الوصمة الاجتماعية حول التوحد.
-  تشجيع القبول في الأماكن العامة: 
مثل المطاعم، الحدائق، ودور السينما.

(2) تكييف البيئة لذوي الاحتياجات الحسية
- وفير أماكن هادئة: في المراكز التجارية أو المطارات للأطفال الذين يعانون من الحساسية الحسية.
- تقليل المثيرات الحسية: مثل إطفاء الأضواء الساطعة أو تخفيض الأصوات في الأماكن المزدحمة.

(3) دعم التوظيف في المستقبل .
-  برامج تدريب مهني: لمساعدة المراهقين والبالغين من ذوي التوحد على الانخراط في سوق العمل.
- تشجيع الشركات على توظيف أفراد التوحد: خاصة في مجالات مثل البرمجة، التحليل البيانات، أو الفنون.



 3. التحديات التي تواجه الأسر والمجتمع
أ. التحديات الأسرية .
- الصعوبات المالية: بسبب تكاليف العلاجات والجلسات التأهيلية.
-  الإرهاق العاطفي: نتيجة الضغوط اليومية في رعاية الطفل.
-  النظرة الاجتماعية السلبية: في بعض المجتمعات التي لا تفهم طبيعة التوحد.

ب. التحديات المجتمعية 
-  نقص المراكز المتخصصة: خاصة في المناطق النائية.
-  قلة الوعي: مما يؤدي إلى التنمر أو العزلة الاجتماعية.
- صعوبات الدمج في المدارس: بسبب عدم توفر الكوادر المدربة.''',
    "hello mohamedh₫w are u , u can make the chid smile by give him some thing to eat ",
  ];

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  Future<void> getUserName() async {
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('parents') // ← هنا غيرناها لـ parents
            .doc(user!.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            name = userDoc['name'];
          });
        } else {
          print('Document does not exist');
        }
      } catch (e) {
        print('Error fetching name: $e');
      }
    } else {
      print('No user is logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome, ",
              style: TextStyle(fontSize: 15.sp, color: Colors.red),
            ),
            SizedBox(
              width: 1.w,
            ),
            Text(
              "$name",
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Container(
              alignment: Alignment.center,
              height: 20.h,
              width: 20.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Image.asset(
                'assets/images/APP-LOGO.png',
                //fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: InkWell(
                onTap: () {
                  context.read<ParentLoginCubit>().signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ChooseTeypeOfLodding()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("تسجيل الخروج"),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.logout_rounded))
                  ],
                ),
              ),
            ),
            Divider(),
            SizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImerganceDesplay()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("الطوارئ "),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.tips_and_updates))
                  ],
                ),
              ),
            ),
            Divider()
          ],
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: articels_Name.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4), // اتجاه الظل (يمين/يسار، فوق/تحت)
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => DisplayArticel(
                                    art_name: articels_Name[index],
                                    art_content: articels_Content[index],
                                    art_source: articels_source[index],
                                  )));
                    },
                    title: Text(articels_Name[index]),
                    subtitle: Text(" المصدر :  ${articels_source[index]}"),
                    trailing: Icon(Icons.article, color: Colors.red),
                    subtitleTextStyle: TextStyle(color: Colors.red),
                    titleTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 17.sp),
                  )
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
