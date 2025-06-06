import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Categories extends StatefulWidget {
  final List<Map<String, dynamic>> data = [
    {
      "cat-name": "الوجوه",
      "cat-img": "assets/images/smil.png",
      "cat-nave": "Facespage", //still not add it will be an widget ( page  )
    },
    {
      "cat-name": "الصوت",
      "cat-img": "assets/images/voic.jpg",
      "cat-nave": "Viocepage", //still not add it will be an widget ( page  )
    },
    {
      "cat-name": "اختبار",
      "cat-img": "assets/images/quizes.webp",
      "cat-nave": "Quizespage", //still not add it will be an widget ( page  )
    }
  ];
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final List<String> children = [
    'احمد',
    'محمد',
    'بشار',
    'ليلي',
    'ريم',
  ];
  String? selectedChild;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.all(3.w),
        child: ListView(
          // shrinkWrap: true,
          children: [
            Container(
              height: 50.h,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.w,
                    mainAxisSpacing: 3.h),
                itemBuilder: (BuildContext context, int index) {
                  final data = widget.data[index];
                  return InkWell(
                    onTap: () {
                      print(data["cat-nave"]);
                    },
                    child: Card(
                      elevation: 15,
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            child: Image(
                              image: AssetImage(
                                data["cat-img"],
                              ),
                              fit: BoxFit.fill,
                              height: 130,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            data["cat-name"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.sp),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 60.w, // متحكم في عرض الـ Dropdown هنا
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: const Text("اختر الطفل"),
                    value: selectedChild,
                    icon: const Icon(
                        Icons.arrow_drop_down), // الأيقونة هتفضل في آخر اليمين
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedChild = newValue;
                        print(selectedChild);
                      });
                    },
                    items:
                        children.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            if (selectedChild != null)
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 70.w, // خليها نص عرض الشاشة مثلاً أو أي قيمة تناسبك
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$selectedChild',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 86, 109, 172),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        ':  الطفل المختار',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
