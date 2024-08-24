part of 'drawer_bloc.dart';

@immutable
sealed class DrawerEvent{}

class OpenDrawer  extends DrawerEvent{
  @override
 List<Object> get props => [];
  
}

class CLoseDrawer extends DrawerEvent {
  @override
  List<Object> get props => [];
}

class SelectDrawerItem extends DrawerEvent {
  final String itemName;

  SelectDrawerItem(this.itemName);

  @override
  List<Object> get props => [itemName];
}
