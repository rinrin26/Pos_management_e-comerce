import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project_application_pos/services/firestore_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
   FirestoreServices firestoreServices = FirestoreServices();
  final db = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? streamSubscription;

  UsersBloc() : super(UsersState()) {
    //users fetch
    on<UsersFetch>((event, emit) {
      final collection = db.collection('users');

      streamSubscription = collection.snapshots().listen((data) {
        add(UsersUpdated(users: data.docs.map((e) => e.data()).toList()));
      });
    });

    // users add
    on<UsersAdded>((event, emit) async {
      await firestoreServices.addUser(event.uid,event.email, event.nama, event.noHP);
    });

    // users update
    on<UsersUpdated>((event, emit) async {
      emit(UsersState(users: event.users));
    });
  }
}
