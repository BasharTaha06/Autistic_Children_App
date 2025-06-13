import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ImerganceDesplay extends StatefulWidget {
  @override
  _ImerganceDesplayState createState() => _ImerganceDesplayState();
}

class _ImerganceDesplayState extends State<ImerganceDesplay> {
  // قائمة النقاط مع محتوياتها
  final List<Map<String, dynamic>> points = [
    {
      'title': 'نوبة الغضب أو الصراخ',
      'instructions': [
        '• أوقف الضوضاء حوله فورًا (أغلق التلفاز/النوافذ)',
        '• اجلس معه على الأرض وقل بصوت هادئ: "أنا هنا لمساعدتك"',
        '• اعرض له صورة مكان هادئ من التطبيق (مثل غرفته)',
        '• اضغط بلطف على كتفيه (ضغط عميق مهدئ)',
        '• شغّل أغنيته المفضلة من التطبيق',
      ],
      'images': [
        'assets/images/1.1.jpg',
        'assets/images/1.2.jpg',
        'assets/images/1.3.jpg',
      ],
    },
    {
      'title': 'رفض الطعام أو انتقائية الأكل',
      'instructions': [
        '• قدم الطعام في أطباق ملونة (الأزرق/الأخضر عادةً مفضل)',
        '• قطّع الطعام لأشكال مرحة (نجوم - وجوه ضاحكة)',
        '• اجعل دميته المفضلة "تتذوق" الطعام أولاً',
        '• ابدأ بملعقة واحدة صغيرة وقل: "هذه فقطثم نلعب"',
        '• كافئه بلعبة يحبها بعد الأكل (بدون ربط الطعام بالمكافأة)',
      ],
      'images': [
        'assets/images/2.1.jpg',
        'assets/images/2.2.jpg',
        'assets/images/2.3.jpg',
        'assets/images/2.4.jpg',
        'assets/images/2.5.jpg',
        'assets/images/2.6.jpg',
      ],
    },
    {
      'title': 'صعوبة النوم أو الاستيقاظ المتكرر',
      'instructions': [
        '• أطفئ الأضواء الساطعة قبل النوم بساعة',
        '• استخدم روتينًا بصريًا (صور متسلسلة على التطبيق):',
        '  1. حمام دافئ',
        '  2. لبس البيجاما',
        '  3. قراءة قصة',
        '• شغّل صوت موجات البحر من التطبيق',
        '• قدم له "دمية النوم" المخصصة (لا تستخدمها بالنهار)',
      ],
      'images': [
        'assets/images/3.1.jpg',
        'assets/images/3.2.jpg',
        'assets/images/3.3.jpg',
      ],
    },
    {
      'title': 'عدم الاستجابة للأوامر البسيطة',
      'instructions': [
        '• اجلس أمامه على مستوى عينيه',
        '• استخدم جمل قصيرة (3-4 كلمات كحد أقصى)',
        '• بدل الكلام بالصور (أظهر صورة ما تطلبه من التطبيق)',
        '• قدم خيارين فقط (مثل: "تريد الحليب أم العصير؟")',
        '• كرر المحاولة 3 مرات بفاصل 5 دقائق',
      ],
      'images': [],
    },
    {
      'title': 'الحساسية من الأصوات أو الأضواء',
      'instructions': [
        '• احمل معك دائمًا:',
        '- سماعات عازلة للصوت',
        '- نظارة شمسية للأضواء',
        '• حدد "مكانًا آمنًا" في البيت (خيمة صغيرة/ركن مخصص)',
        '• استخدم تطبيق "الضوضاء البيضاء" عند الخروج',
        '• ألبسه ملابس ضيقة قليلاً (الضغط يساعد على الهدوء)',
      ],
      'images': [],
    },
    // معلومات إرشادية كاملة
    {
      'title': ': نصائِح عامَّة',
      'instructions': [
        '✓ حافظ على هدوئك - الطفل يقلد ردود فعلك',
        '✓ كرر المحاولات بهدوء (3 مرات كحد أقصى)',
        '✓ سجل في التطبيق ما ينجح مع طفلك',
      ],
      'images': [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 249, 249, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "نصائِح للتعامل مع الأطفال في مواقف مختلفة",
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 22,
              color: Color.fromRGBO(102, 137, 115, 1),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 5.h),
              Text(
                "قائمة بأهم 5 نقاط للتعامل مع الأطفال",
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 2.h),
              for (int i = 0; i < 5; i++) ...[
                Text("${i + 1}. ${points[i]['title'].toString()}",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.normal)),
                SizedBox(height: 1.h),
              ],
              Divider(
                color: Colors.black,
                thickness: 1,
                height: 4.h,
              ),
              for (int i = 0; i < points.length; i++) ...[
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      points[i]['title'].toString(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    )),
                SizedBox(height: 1.h),
                Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: (points[i]['instructions'] as List<String>)
                          .map((item) => Text(
                                item,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.normal,
                                ),
                              ))
                          .toList(),
                    )),
                SizedBox(height: 1.h),
                if (points[i]['images'].isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: points[i]['images'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            points[i]['images'][index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                Divider(color: Colors.black, thickness: 1, height: 4.h),
              ],
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
