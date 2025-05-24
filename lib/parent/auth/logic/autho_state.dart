import 'package:firebase_auth/firebase_auth.dart';

abstract class ParentAthoState {}

class ParentInitState extends ParentAthoState {}

class ParentLodingState extends ParentAthoState {}

class ParentSuccessState extends ParentAthoState {}

class ParentResetPassState extends ParentAthoState {}

class AuthFailure extends ParentAthoState {
  final String error;
  AuthFailure(this.error);
}

class ParentWaitingForVerificationState extends ParentAthoState {
  final User user;
  ParentWaitingForVerificationState(this.user);
}
