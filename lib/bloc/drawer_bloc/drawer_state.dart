
part of 'drawer_bloc.dart';

@immutable
sealed class DrawerState {}

final class DrawerInitial extends DrawerState {
  @override
  List<Object> get props => [];
}
 class DrawerOpen extends DrawerState {
  @override
  List<Object> get props => [];
}

 class DrawerClosed extends DrawerState {
  @override
  List<Object> get props => [];
}

class DrawerSelected extends DrawerState {
  final String selectedItem;

  DrawerSelected({ required this.selectedItem});

  @override
  List<Object?> get props => [selectedItem];
  
}