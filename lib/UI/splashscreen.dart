import 'package:final_project_application_pos/UI/widget/text_widget.dart';
import 'package:final_project_application_pos/bloc/auth_bloc/auth_bloc.dart';
import 'package:final_project_application_pos/router/route_names.dart';
import 'package:final_project_application_pos/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirestoreServices firestoreServices = FirestoreServices();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCheckLogIn());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.loginSuccess) {
          print('==========loginStatus di splash ${state.loginSuccess}');
           Future.delayed(const Duration(seconds: 8));
           context.pushReplacement(RouteNames.beranda);

          
        } else {
          Future.delayed(const Duration(milliseconds: 1), () {
            context.push(RouteNames.login);
          });
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Center(
              child: Column(
            children: [
              Image.asset(
                'assets/images/shop.png',
                width: 400,
                height: 400,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextWidget(
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  text: 'Easy products and sales management',
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
