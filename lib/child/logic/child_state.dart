import 'package:firebase_auth/firebase_auth.dart';

abstract class ChildAuthState {}

class ChildInitState extends ChildAuthState {}

class ChildLoadingState extends ChildAuthState {}

class ChildSuccessState extends ChildAuthState {}

class ChildResetPassState extends ChildAuthState {}

class ChildAuthFailure extends ChildAuthState {
  final String error;
  ChildAuthFailure(this.error);
}

class ChildWaitingForVerificationState extends ChildAuthState {
  final User user;
  ChildWaitingForVerificationState(this.user);
}
