import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerInitial()) {
    on<DrawerEvent>((event, emit) {
      if (event is OpenDrawer) {
        emit(DrawerOpen());
      } else if (event is CLoseDrawer) {
        emit(DrawerClosed());
      }
    });

    on<SelectDrawerItem>((event, emit) {
      emit(DrawerSelected(selectedItem: event.itemName));
    });
  }
}
