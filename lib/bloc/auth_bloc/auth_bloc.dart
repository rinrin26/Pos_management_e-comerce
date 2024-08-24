import 'package:final_project_application_pos/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FirestoreServices firestoreServices = FirestoreServices();
  AuthBloc(this.firestoreServices) : super(AuthState()) {
    monitorAuthState();
    //register event
    on<AuthRegister>((event, emit) async {
      emit(AuthState(isLoading: true));

      try {
        final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email, password: event.password);

        emit(AuthState(userData: res.user));
      } catch (e) {
        emit(AuthState(errorMessage: e.toString()));
      }
    });

    //login event
    on<AuthLogin>((event, emit) async {
      emit(AuthState(isLoading: true));

      try {
        final responseUser = await firestoreServices.signInWithEmailAndPassword(
            event.email, event.password);
        print('=====data AUthLogBloc $responseUser');

        if (responseUser != null) {
          emit(AuthState(userData: responseUser, loginSuccess: true));
        } else {
          emit(AuthState(errorMessage: "Login failed", loginSuccess: false));
        }
      } catch (e) {
        emit(AuthState(errorMessage: e.toString(), loginSuccess: false));
      }
    });

//logout
    on<AuthLogout>((event, emit) async {
      await firestoreServices.signOut();

      emit(AuthState(userData: null, loginSuccess: false));
    });

    // update
    on<AuthUpdated>((event, emit) async {
      emit(AuthState(userData: event.userData));
    });

    on<AuthCheckLogIn>((event, emit) async {
      await Future.delayed(Duration(milliseconds: 100)); //tunggu update
      final isLogin = await firestoreServices.isUserLoggedIn();
      print('======= check login bloc $isLogin');
      if (isLogin) {
        final user = FirebaseAuth.instance.currentUser;
        print('====data check login currentUser $user');
        emit(AuthState(userData: user, loginSuccess: true));
      } else {
        emit(AuthState(loginSuccess: false));
      }
    });
  }

  void monitorAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        add(AuthUpdated(userData: user));
      } else {
        add(AuthCheckLogIn());
      }
    });
  }
}
