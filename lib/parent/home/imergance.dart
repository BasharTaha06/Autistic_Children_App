import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class ImerganceDesplay extends StatefulWidget {
  String art_name = "بنك الحلول السريعة";
  String art_content = '''
### *بنك الحلول السريعة (زر الطوارئ) لأطفال التوحد*  
يُقدم حلولاً فورية للمواقف الشائعة التي تواجه أطفال التوحد وأهاليهم، مع تفاصيل عملية قابلة للتطبيق فورًا:

---

#### *1. نوبة الغضب أو الصراخ*  
*الحلول المقترحة*:  
- *التدخل البصري*:  
  - اعرض صورة "مكان هادئ" (مثل غرفة مظلمة) على التطبيق.  
  - استخدم *توقيتًا مرئيًا* (مؤقت رمل متحرك) لمساعدة الطفل على التنفس.  
- *النشاط البديل*:  
  - اقتراح لعبة *ضغط الكرة الإسفنجية* (صورة + تعليمات صوتية).  
- *جملة جاهزة للأهل*:  
  > "هذا مؤقت.. سنعد إلى 10 معًا، ثم نلعب بلعبتك المفضلة".  

---

#### *2. رفض الطعام أو انتقائية الأكل*  
*الحلول المقترحة*:  
- *تحويل الطعام إلى لعبة*:  
  - صور لأطعمة مُقطعة بأشكال مرحة (نجوم، قلوب).  
  - فيديو قصير: "لنطعم الدمية أولاً!".  
- *بدائل غذائية*:  
  - قائمة بأطعمة بنفس القيمة الغذائية (مثال: بدل الحليب → زبادي).  
- *نظام المكافآت*:  
  - جدول مرئي: "إذا أكلت 3 لقيمات، سنلعب لعبة الفقاعات!".  

---

#### *3. صعوبة النوم أو الاستيقاظ المتكرر*  
*الحلول المقترحة*:  
- *روتين نوم بصري*:  
  - سلسلة صور: "حمام → لبس البيجاما → قراءة قصة → إطفاء الأنوار".  
- *أداة الاسترخاء*:  
  - موسيقى مهدئة مع تأثير *الضوء الأزرق الخافت* (يُعرض على شاشة التطبيق).  
- *قاعدة "السرير فقط للنوم"*:  
  - صورة توضح: "السرير = نوم، الأريكة = لعب".  

---

#### *4. عدم الاستجابة للأوامر البسيطة*  
*الحلول المقترحة*:  
- *التوجيه البصري*:  
  - بدلًا من: "اجمع ألعابك"، اعرض صورة للعب موضوعة في السلة.  
- *تقنية "الخيارات المحددة"*:  
  - "هل تريد ارتداء القميص الأحمر أم الأزرق؟" (مع صورتين).  
- *نموذج محاكاة*:  
  - فيديو لطفل آخر ينفذ المطلوب (مثال: "شاهد سامي يرتب سريره").  

---

#### *5. الحساسية من الأصوات أو الأضواء*  
*الحلول المقترحة*:  
- *أداة "العزل الحسي"*:  
  - زر يُشغل صوت ضوضاء بيضاء (White Noise) مع تعتيم شاشة الهاتف.  
- *قائمة "الأماكن الآمنة"*:  
  - خريطة لأقرب مكان هادئ (المنزل، السيارة، ركن خاص في المدرسة).  
- *كتم الضوضاء*:  
  - صورة سماعات إلغاء الضوضاء مع جملة: "ضع هذه وستسمع فقط الموسيقى الهادئة".  

---

### *6. كيفية تنفيذ هذه الحلول في التطبيق*  
#### *أ. واجهة زر الطوارئ*:  
plaintext
[ 🚨 زر الطوارئ ]  
↓  
اختر الموقف:  
1. نوبة غضب  
2. رفض الطعام  
3. صعوبة النوم  
4. عدم الاستجابة  
5. حساسية حسية  
  

#### *ب. هيكل البيانات (Firebase مثال):*  
json
{
  "emergency_solutions": {
    "tantrum": {
      "solution1": "عرض صورة مكان هادئ",
      "solution2": "تشغيل موسيقى مهدئة",
      "video": "tantrum_management.mp4"
    }
  }
}


#### *ج. كود Flutter لتحميل الحلول:*  
dart
Future<void> loadSolutions(String issue) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('emergency_solutions')
      .doc(issue)
      .get();
  setState(() {
    _solutions = snapshot.data()!;
  });
}


---

### *7. مصادر للحلول العلمية*  
- *منظمة Autism Speaks*: [نصائح لإدارة السلوك](https://www.autismspeaks.org/tool-kit)  
- *كتاب "The Explosive Child"*: استراتيجيات حل المشكلات التعاوني.  

---

### *8. نصائح لزيادة الفعالية*  
- *التحديث الدوري*: أضف حلولاً جديدة بناءً على ملاحظات الأهل.  
- *التخصيص*: اسمح للأهل بإضافة حلولهم الخاصة (نص أو تسجيل صوتي).  
- *الإشارة إلى المختصين*: عند تكرار المشكلة، ظهر زر "اتصل بالمعالج".  

---

هذه الحلول تُقدم إجابات *فورية، علمية، وقابلة للتخصيص*، مما يجعل التطبيق دليلًا عمليًا في جيب الأهل! 📱✨

''';

  @override
  State<ImerganceDesplay> createState() => _ImerganceDesplayState();
}

class _ImerganceDesplayState extends State<ImerganceDesplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.art_name,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.reemKufi(
                    textStyle: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(height: 3.h),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  // color: const Color.fromARGB(255, 235, 230, 230),
                  child: Text(
                    widget.art_content,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.elMessiri(
                      textStyle: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Divider(
                color: Colors.black,
                indent: 60,
                endIndent: 70,
              ),
              Divider(
                color: Colors.black,
                indent: 80,
                endIndent: 90,
              ),
              Divider(
                color: Colors.black,
                indent: 100,
                endIndent: 110,
              ),
              SizedBox(
                height: 5.h,
              )
            ],
          ),
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
