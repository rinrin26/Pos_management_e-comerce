import 'package:final_project_application_pos/UI/user%20page/my_account_screen.dart';
import 'package:final_project_application_pos/UI/user%20page/notifications_screen.dart';
import 'package:final_project_application_pos/UI/seller_page/inventory_product_screen.dart';
import 'package:final_project_application_pos/UI/user%20page/product_page/products_screen.dart';
import 'package:final_project_application_pos/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          switch (state.index) {
            case 0:
              return const ProductsScreen();
            case 1:
              return const NotificationScreen();
            case 2:
              return const InventoryProductScreen();
            case 3:
              return const MyAccountScreen();
            default:
              return const BerandaScreen();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: context.watch<BottomNavCubit>().state.index,
            onTap: (value) =>
                context.read<BottomNavCubit>().navigateTo(index: value),
            selectedItemColor: Colors.blue.shade900,
            unselectedItemColor: Colors.black,
            selectedIconTheme:
                const IconThemeData(color: Colors.blueAccent, size: 30),
            unselectedIconTheme:
                const IconThemeData(color: Colors.black, size: 25),
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_sharp,
                  size: 25,
                ),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  size: 25,
                ),
                label: 'Notif',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.store,
                  size: 25,
                ),
                label: 'Toko Saya',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 25,
                ),
                label: 'Akun Saya',
              ),
            ],
          );
        },
      ),
    );
  }
}
