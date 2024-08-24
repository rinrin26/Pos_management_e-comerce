import 'package:final_project_application_pos/bloc/drawer_bloc/drawer_bloc.dart';
import 'package:final_project_application_pos/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<DrawerBloc, DrawerState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue.shade900),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/store.avif'),
                ),
                accountName: const Text('Toko Rinrin'),
                accountEmail: const Text('toko-rinrin@gmail.com'),
              ),
              _drawerItem(context, 'Report Penjualan', Icons.assessment,
                  RouteNames.reportSeller),
              const Divider(),
              _drawerItem(context, 'Riwayat Penjualan', Icons.history, null),
              const Divider(),
              _drawerItem(context, 'Program penjualan', Icons.trending_up, null),
              const Divider(),
              _drawerItem(context, 'Promosi toko', Icons.campaign, null),

              const Divider(),
              _drawerItem(context, 'Keuangan', Icons.account_balance_wallet, null),
              const Divider(),
              _drawerItem(context, 'Settings', Icons.settings, null),
              const Divider(),
            ],
          );
        },
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context, String title, IconData icon, String? routeName) {
    //mengecheck state yang dipilih DrawerSelected & memeriksa apakah selectedItem  sama dengan title dari item menu
    final isSelected = context.select<DrawerBloc, bool>(
      (bloc) =>
          bloc.state is DrawerSelected &&
          (bloc.state as DrawerSelected).selectedItem == title,
    );

    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : Colors.black),
      title: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.blue : Colors.black),
      ),
      onTap: () {
        context.read<DrawerBloc>().add(SelectDrawerItem(title));
        routeName != null
            ? context.push(routeName)
            : Navigator.of(context).pop();
      },
    );
  }
}
