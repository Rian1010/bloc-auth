import 'package:auth_bloc_practice/auth_repository.dart';
import 'package:auth_bloc_practice/form_submission_status.dart';
import 'package:auth_bloc_practice/login/login_event.dart';
import 'package:auth_bloc_practice/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository? authRepo;

  LoginBloc({this.authRepo}) : super(LoginState()) {
    on<LoginUsernameChanged>(
      (event, emit) => emit(
        state.copyWith(username: event.username),
      ),
    );
    on<LoginPasswordChanged>(
      (event, emit) => emit(
        state.copyWith(password: event.password),
      ),
    );
    on<LoginSubmitted>(
      (event, emit) => emit(
        state.copyWith(
          formStatus: FormSubmitting(),
        ),
      ),
    );
    try {
      authRepo!.login();
      state.copyWith(formStatus: SubmissionSuccess());
    } catch (e) {
      state.copyWith(formStatus: SubmissionFailed(e));
    }
  }

  // @override
  // Stream<LoginState> mapEventToState(LoginEvent event) async* {
  //   // Username updated
  //   if (event is LoginUsernameChanged) {
  //     yield state.copyWith(username: event.username);

  //     // Password updated
  //   } else if (event is LoginPasswordChanged) {
  //     yield state.copyWith(password: event.password);

  //     // Form submitted
  //   } else if (event is LoginSubmitted) {
  //     yield state.copyWith(formStatus: FormSubmitting());

  //     try {
  //       await authRepo!.login();
  //       yield state.copyWith(formStatus: SubmissionSuccess());
  //     } catch (e) {
  //       yield state.copyWith(formStatus: SubmissionFailed(e));
  //     }
  //   }
  // }
}
