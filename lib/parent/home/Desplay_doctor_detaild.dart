import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class DoctorDetailsPage extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String address;

  const DoctorDetailsPage({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.address,
  });

  @override
  State<DoctorDetailsPage> createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {
  String? selectedTime;
  String? selectedDay;
  String? selectedPrice;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // لدعم اللغة العربية
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تفاصيل الدكتور'),
          backgroundColor: Color.fromARGB(255, 252, 77, 77),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.sp),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        widget.imageUrl,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person,
                                  color: Color.fromARGB(255, 252, 77, 77)),
                              const SizedBox(width: 8),
                              Text(
                                widget.name,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.red),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.address,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              /// ميعاد العمل
              buildSectionTitle('اختر ميعاد العمل'),
              buildDropdown(
                hint: "اختر ميعاد",
                value: selectedTime,
                items: ['10 صباحًا', '2 ظهرًا', '6 مساءً'],
                onChanged: (val) => setState(() => selectedTime = val),
              ),

              /// اليوم
              buildSectionTitle('اختر اليوم'),
              buildDropdown(
                hint: "اختر يوم",
                value: selectedDay,
                items: ['السبت', 'الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء'],
                onChanged: (val) => setState(() => selectedDay = val),
              ),

              /// نوع الكشف
              buildSectionTitle('اختر نوع الكشف'),
              buildRadio("عادي - 100 جنيه", "عادي"),
              buildRadio("مستعجل - 200 جنيه", "مستعجل"),

              const SizedBox(height: 24),

              /// زر التأكيد
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: handleBooking,
                  icon: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "تأكيد الحجز",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 252, 77, 77),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widgets for cleaner layout
  Widget buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget buildDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
  }

  Widget buildRadio(String title, String value) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: selectedPrice,
      onChanged: (val) => setState(() => selectedPrice = val),
      activeColor: Colors.teal,
    );
  }

  void handleBooking() {
    if (selectedTime != null && selectedDay != null && selectedPrice != null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("🎉 تم الحجز بنجاح"),
          content: const Text("سيتم التواصل معك قريبًا لتأكيد الموعد."),
          actions: [
            Lottie.asset(
              'assets/animations/done.json',
              height: 150,
              repeat: true,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("حسنًا"),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("من فضلك اكمل كل البيانات")),
      );
    }
  }
}
