import 'package:final_project_application_pos/UI/auth_screen/register_screen.dart';
import 'package:final_project_application_pos/UI/widget/button_widget.dart';
import 'package:final_project_application_pos/UI/widget/text_field_widget.dart';
import 'package:final_project_application_pos/UI/widget/text_widget.dart';
import 'package:final_project_application_pos/bloc/auth_bloc/auth_bloc.dart';
import 'package:final_project_application_pos/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: ListView(
            children: [
              const TextWidget(
                text: 'Sign in POS account',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              const TextWidget(
                text: 'Welcome! Please Login your account.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(
                height: 40,
              ),
              const TextWidget(
                text: 'Phone number or Email',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              TextFieldWidget(
                controller: _emailController,
                hintText: 'ex. yourname@gmail.com',
                prefixIcon: Icons.email,
                usePrimaryDecoration: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const TextWidget(
                text: 'Password',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              TextFieldWidget(
                obscureText: true,
                controller: _passwordController,
                hintText: 'type your password here',
                prefixIcon: Icons.key,
                suffixIcon: Icons.remove_red_eye_outlined,
                usePrimaryDecoration: true,
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: TextWidget(
                  text: 'Forgot Password',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
             
              ButtonWidget(
                onPressed: () async {
                  context.read<AuthBloc>().add(AuthLogin(
                      email: _emailController.text,
                      password: _passwordController.text));
                  await Future.delayed(const Duration(seconds: 3));
                  context.push(RouteNames.beranda);
                },
                text: 'Login',
                textColor: Colors.white,
                buttonColor: Colors.blueAccent.shade700,
              ),
              const SizedBox(
                height: 30,
              ),
              const TextWidget(
                text: '------------------------ or ---------------------------',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonWidget(
                onPressed: () => {},
                text: 'Sign in with google',
                textColor: Colors.black,
                borderColor: Colors.grey.shade400,
                imgUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
              ),
              const SizedBox(
                height: 60,
              ),
              _textbuttom(context),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      );
    });
  }

  Row _textbuttom(BuildContext context) => Row(
        children: [
          const Text(
            'Dont have an account?',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          const SizedBox(width: 18),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
          ),
        ],
      );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
