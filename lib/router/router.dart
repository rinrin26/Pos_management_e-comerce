import 'package:final_project_application_pos/UI/user%20page/cart_page/cart_screen.dart';
import 'package:final_project_application_pos/UI/user%20page/my_account_screen.dart';
import 'package:final_project_application_pos/UI/user%20page/notifications_screen.dart';
import 'package:final_project_application_pos/UI/seller_page/add_product_screen.dart';
import 'package:final_project_application_pos/UI/nav_menu/beranda_screen.dart';
import 'package:final_project_application_pos/UI/seller_page/inventory_product_screen.dart';
import 'package:final_project_application_pos/UI/auth_screen/login_screen.dart';
import 'package:final_project_application_pos/UI/user%20page/order_screen.dart';
import 'package:final_project_application_pos/UI/user%20page/payment/payment_screen.dart';
import 'package:final_project_application_pos/UI/user%20page/product_page/product_detail_page.dart';
import 'package:final_project_application_pos/UI/user%20page/product_page/products_screen.dart';
import 'package:final_project_application_pos/UI/auth_screen/register_screen.dart';
import 'package:final_project_application_pos/UI/seller_page/report_seller_screen.dart';
import 'package:final_project_application_pos/UI/splashscreen.dart';
import 'package:final_project_application_pos/UI/user%20page/payment/status_order_payment_screen.dart';
import 'package:final_project_application_pos/bloc/auth_bloc/auth_bloc.dart';
import 'package:final_project_application_pos/model/inventory_product_model.dart';
import 'package:final_project_application_pos/model/order_model.dart';
import 'package:final_project_application_pos/model/product_model.dart';
import 'package:final_project_application_pos/router/route_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final AppRouter shared = AppRouter._internal();
  factory AppRouter() {
    return shared;
  }
  AppRouter._internal();

  final router = GoRouter(
      routes: [
        GoRoute(
            path: RouteNames.splashScreen,
            builder: (context, state) => const SplashScreen()),
        GoRoute(
            path: RouteNames.register,
            builder: (context, state) => const RegisterScreen()),
        GoRoute(
            path: RouteNames.login,
            builder: (context, state) => const LoginScreen()),
        ShellRoute(
            builder: (context, state, builder) => const BerandaScreen(),
            routes: [
              GoRoute(
                  path: RouteNames.products,
                  builder: (context, state) => const ProductsScreen()),
              GoRoute(
                  path: RouteNames.inventory,
                  builder: (context, state) => const InventoryProductScreen()),
              GoRoute(
                  path: RouteNames.notif,
                  builder: (context, state) => const NotificationScreen()),
              GoRoute(
                  path: RouteNames.myAccount,
                  builder: (context, state) => const MyAccountScreen()),
            ]),
        GoRoute(
            path: RouteNames.beranda,
            builder: (context, state) => const BerandaScreen()),
        GoRoute(
            path: RouteNames.detailProduct,
            builder: (context, state) {
              final product = ProductModel.fromMap(state.uri.queryParameters);
              return ProductDetailPage(product: product);
            }),
        GoRoute(
            path: RouteNames.cart,
            builder: (context, state) => const CartPage()),
        GoRoute(
            path: RouteNames.addProduct,
            builder: (context, state) {
              final queryParams = state.uri.queryParameters;
              final product = queryParams.isNotEmpty
                  ? InventoryProductModel.fromMap(queryParams)
                  : null;
             
              if (product != null) {
                 return AddProductScreen(product: product);
              } else {
                 return const AddProductScreen();
              }
            }),
        GoRoute(
            path: RouteNames.reportSeller,
            builder: (context, state) => const ReportSellerScreen()),
        GoRoute(
            path: RouteNames.payment,
            builder: (context, state) => const PaymentScreen()),
       
        GoRoute(
            path: RouteNames.statusPage,
            builder: (context, state) {
              return StatusOrderPaymentScreen(
                paymentMethodName: state.uri.query,
              );
            }),
        GoRoute(
            path: RouteNames.order, builder: (context, state) => OrderScreen()),
      ],
      redirect: (context, state) {
        final authState = context.read<AuthBloc>().state;
        print('Current location: ${state.matchedLocation}');
        print('Login success: ${authState.loginSuccess}');

        if (authState.loginSuccess) {
          if (state.matchedLocation == RouteNames.login ||
              state.matchedLocation == RouteNames.register) {
            print('masukk siniii router keteika login success');
            return RouteNames.beranda;
          }
        } else {
          if (state.matchedLocation != RouteNames.splashScreen) {
            print('masukk siniii login');
            return RouteNames.login;
          }
        }
        return null;
      });
}
