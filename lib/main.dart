import 'package:final_project_application_pos/bloc/auth_bloc/auth_bloc.dart';
import 'package:final_project_application_pos/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:final_project_application_pos/bloc/cart_bloc/cart_bloc.dart';
import 'package:final_project_application_pos/bloc/cubit_img/images_cubit.dart';
import 'package:final_project_application_pos/bloc/drawer_bloc/drawer_bloc.dart';
import 'package:final_project_application_pos/bloc/inventory_product_bloc/inventory_product_bloc.dart';
import 'package:final_project_application_pos/bloc/order_bloc/order_bloc.dart';
import 'package:final_project_application_pos/bloc/product_bloc/product_bloc.dart';
import 'package:final_project_application_pos/bloc/users_bloc/users_bloc.dart';
import 'package:final_project_application_pos/helper/notification_helper.dart';
import 'package:final_project_application_pos/router/router.dart';
import 'package:final_project_application_pos/services/api_service.dart';
import 'package:final_project_application_pos/services/firestore_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper().initLocalNotifications();
  await Firebase.initializeApp();
  runApp(const PosApp());
}

class PosApp extends StatelessWidget {
  const PosApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider<AuthBloc>(create: (context) => AuthBloc(FirestoreServices())..add( AuthCheckLogIn())),
        BlocProvider<BottomNavCubit>(create: (context) => BottomNavCubit()),
        BlocProvider<UsersBloc>(create: (context) => UsersBloc()),
        BlocProvider<ProductBloc>(
          create: (context) =>
              ProductBloc(ApiService())..add(LoadProductsEvent()),
        ),
        BlocProvider<DrawerBloc>(create: (context) => DrawerBloc()),
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<InventoryProductBloc>(create: (context) => InventoryProductBloc()),
        BlocProvider<ImagesCubit>(
            create: (context) => ImagesCubit()),
         BlocProvider<OrderBloc>(create: (context) => OrderBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'E-Shop Pos App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: AppRouter.shared.router,

      ),
    );
  }
}
