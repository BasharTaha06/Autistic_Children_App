import 'dart:async';
import 'package:autisticchildren/parent/Login/logic/child_logic/child_state.dart';
import 'package:autisticchildren/parent/Login/screens/login_type.dart';
import 'package:autisticchildren/parent/model/child_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';

class ChildAuthCubit extends Cubit<ChildAuthState> {
  ChildAuthCubit() : super(ChildInitState());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ✅ تسجيل الدخول
  Future<void> signIn({required String email, required String password}) async {
    emit(ChildLoadingState());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!(userCredential.user!.emailVerified)) {
        emit(ChildAuthFailure("البريد الإلكتروني غير مُفعل"));
        return;
      }

      emit(ChildSuccessState());
    } catch (e) {
      emit(ChildAuthFailure("فشل تسجيل الدخول: $e"));
    }
  }

  // ✅ تسجيل حساب جديد
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String age,
    required String gender,
    required String parentEmail,
  }) async {
    emit(ChildLoadingState());
    try {
      // إنشاء المستخدم
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? currentUser = userCredential.user;

      // إرسال تأكيد للبريد
      if (currentUser != null && !currentUser.emailVerified) {
        print("🚀 جاري إرسال التحقق على البريد...");
        await currentUser.sendEmailVerification();
        print("✅ تم إرسال الإيميل.");

        // التحقق إن البيرنت موجود
        DocumentSnapshot parentDoc = await FirebaseFirestore.instance
            .collection("parents")
            .where("email", isEqualTo: parentEmail)
            .limit(1)
            .get()
            .then((snapshot) => snapshot.docs.first);

        // تخزين الطفل داخل البيرنت
        Child child = Child(
          name: name,
          age: age,
          gender: gender,
          email: email,
          Parentemail: parentEmail,
          succes: 0,
          fail: 0,
          TotalTry: 0,
        );

        await FirebaseFirestore.instance
            .collection("parents")
            .doc(parentDoc.id) // ID الخاص بالبيرنت
            .collection("children")
            .doc(name) // ممكن تستخدم UID أو أي معرف آخر
            .set(child.toMap());

        emit(ChildWaitingForVerificationState(currentUser));
        checkEmailVerified(currentUser);
      }
    } catch (e) {
      print("❌ خطأ في التسجيل: $e");
      emit(ChildAuthFailure("حدث خطأ أثناء التسجيل: $e"));
    }
  }

  // ✅ تأكيد البريد الإلكتروني
  void checkEmailVerified(User user) {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      await user.reload();
      // User? updatedUser = _auth.currentUser;
      User? updatedUser = FirebaseAuth.instance.currentUser;
      if (updatedUser != null && updatedUser.emailVerified) {
        timer.cancel();
        emit(ChildSuccessState());
      }
    });
  }

  // ✅ نسيت كلمة المرور
  Future<void> resetPassword({required String email}) async {
    emit(ChildLoadingState());
    try {
      await _auth.sendPasswordResetEmail(email: email);
      emit(ChildResetPassState());
    } catch (e) {
      emit(ChildAuthFailure("حدث خطأ أثناء إعادة تعيين كلمة المرور"));
    }
  }

  // ✅ تسجيل الخروج
  Future<void> signOut() async {
    await _auth.signOut();
    print("تم تسجيل الخروج بنجاح");
    emit(ChildInitState());
    // Navigator.pushReplacement(context, (context) => ChooseTeypeOfLodding());
  }
}


/*
عرض الاطفال الخاصين بلبيرنت كلهم 


Future<List<Child>> getChildrenOfParent(String parentID) async {
  final snapshot = await FirebaseFirestore.instance
      .collection("parents")
      .doc(parentID)
      .collection("children")
      .get();

  return snapshot.docs.map((doc) => Child.fromMap(doc.data())).toList();
}
 */