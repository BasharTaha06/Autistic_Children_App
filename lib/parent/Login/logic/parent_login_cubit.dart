import 'dart:async';

import 'package:autisticchildren/parent/Login/logic/autho_state.dart';
import 'package:autisticchildren/parent/model/parent_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentLoginCubit extends Cubit<ParentAthoState> {
  ParentLoginCubit() : super(ParentInitState());

  final FirebaseAuth user = FirebaseAuth.instance;

//the sing in method

  Future<void> singIn({required String email, required String pass}) async {
    emit(ParentLodingState());
    try {
      UserCredential newUser =
          await user.signInWithEmailAndPassword(email: email, password: pass);
      if (!(newUser.user!.emailVerified)) {
        emit(AuthFailure("لم يتم توثيق الايميل بعد"));
        print("********\ncatch error in cubit failer validet\n\n************");
        return;
      }
      emit(ParentSuccessState());
    } catch (e) {
      emit(AuthFailure("Wrong pass or email"));
      print("********\ncatch error in cubit failer $e\n\n************");
      return;
    }
  }
//the sing Up method

//   Future<void> singUp(
//       {required String email,
//       required String pass,
//       required String name,
//       required String phone}) async {
//     emit(ParentLodingState());
//     try {
//       //create user
//       UserCredential newUser = await user.createUserWithEmailAndPassword(
//           email: email, password: pass);
//       // validet the email
//       User? currentUser = newUser.user;
//       if (currentUser != null && !currentUser.emailVerified) {
//         await currentUser.sendEmailVerification();
//       }

//       //store the user data
//       Parent parent = Parent(name: name, phone: phone, email: email);
//       await FirebaseFirestore.instance
//           .collection("parents")
//           .doc(currentUser!.uid)
//           .set(parent.toMap());

//       emit(ParentSuccessState());
//     } catch (e) {
//       emit(AuthFailure("Wrong pass or email"));
//       print("********\ncatch error in cubit failer $e\n\n************");
//     }
//   }

// // reset the pass

  Future<void> resetPassword({required String email}) async {
    emit(ParentLodingState());
    try {
      user.sendPasswordResetEmail(email: email);
      emit(ParentResetPassState());
    } catch (e) {
      emit(AuthFailure("الاميل الذي ادخلت غير صحيح "));
    }
  }

  Future<void> signOut() async {
    await user.signOut();

    emit(ParentInitState());
  }

  Future<void> singUp({
    required String email,
    required String pass,
    required String name,
    required String phone,
  }) async {
    emit(ParentLodingState());
    try {
      UserCredential newUser = await user.createUserWithEmailAndPassword(
          email: email, password: pass);
      User? currentUser = newUser.user;

      if (currentUser != null && !currentUser.emailVerified) {
        await currentUser.sendEmailVerification();

        // خزّن بيانات المستخدم
        Parent parent = Parent(name: name, phone: phone, email: email);
        await FirebaseFirestore.instance
            .collection("parents")
            .doc(currentUser.uid)
            .set(parent.toMap());

        emit(ParentWaitingForVerificationState(currentUser));
      }
    } catch (e) {
      print(" Lash   Firebase signup error: $e");
      emit(AuthFailure("حدث خطأ أثناء التسجيل: $e"));
    }
  }

  void checkEmailVerified(User user) {
    Timer.periodic(Duration(seconds: 5), (timer) async {
      await user.reload();
      User? updatedUser = FirebaseAuth.instance.currentUser;
      if (updatedUser != null && updatedUser.emailVerified) {
        timer.cancel();
        emit(ParentSuccessState());
      }
    });
  }
}
