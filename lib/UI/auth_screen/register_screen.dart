import 'package:final_project_application_pos/UI/widget/button_widget.dart';
import 'package:final_project_application_pos/UI/widget/text_field_widget.dart';
import 'package:final_project_application_pos/UI/widget/text_widget.dart';
import 'package:final_project_application_pos/bloc/auth_bloc/auth_bloc.dart';
import 'package:final_project_application_pos/bloc/users_bloc/users_bloc.dart';
import 'package:final_project_application_pos/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
        child: ListView(
          children: [
            const TextWidget(
              text: 'Sign up POS account',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            const TextWidget(
              text: 'Welcome! Please register your account.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(
              height: 40,
            ),
            const TextWidget(
              text: 'Email',
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
              text: 'Phone Number',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            TextFieldWidget(
              controller: _noHpController,
              hintText: 'ex. 62-889-94839-333',
              textPrefixIcon: '+62',
              prefixIconText: Icons.arrow_drop_down_sharp,
            ),
            const SizedBox(
              height: 20,
            ),
            const TextWidget(
              text: 'Nama',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            TextFieldWidget(
              controller: _nameController,
              hintText: 'ex. Rinrin Karmila',
              prefixIcon: Icons.account_circle_outlined,
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
              controller: _passwordController,
              hintText: 'type your password here',
              prefixIcon: Icons.key,
              obscureText: true,
              suffixIcon: Icons.remove_red_eye_outlined,
              usePrimaryDecoration: true,
            ),
            const SizedBox(
              height: 40,
            ),
            buttonRegister(),
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
              onPressed: () => context.push(RouteNames.login),
              text: 'Sign up with google',
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
  }

  Widget buttonRegister() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return AnimatedSwitcher(
        duration: const Duration(microseconds: 250),
        child: state.isLoading
            ? const CircularProgressIndicator()
            : ButtonWidget(
                onPressed: () {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final nama = _nameController.text;
                  final noHp = _noHpController.text;

                  if (email.isNotEmpty ||
                      password.isNotEmpty ||
                      nama.isNotEmpty ||
                      noHp.isNotEmpty) {
                    //register
                    context.read<AuthBloc>().add(AuthRegister(
                        email: _emailController.text,
                        password: _passwordController.text));
                    //save to firestore
                    context.read<AuthBloc>().stream.listen((state) {
                      if (state.userData != null) {
                        context.read<UsersBloc>().add(UsersAdded(
                            uid: state.userData!.uid,
                            email: email,
                            nama: nama,
                            noHP: noHp));
                      }
                    });
                    const SnackBar(
                      content: Text('Selamat, anda berhasil registrasi!!'),
                      duration: Duration(seconds: 2),
                    );
                    context.push(RouteNames.login);
                  }
                },
                text: 'Register',
                textColor: Colors.white,
                buttonColor: Colors.blueAccent.shade700,
              ),
      );
    });
  }

  Row _textbuttom(BuildContext context) => Row(
        children: [
          const Text(
            'Does not have an account?',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          const SizedBox(width: 18),
          InkWell(
            onTap: () => context.push(RouteNames.login),
            child: const Text(
              'Sign In',
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
          ),
        ],
      );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _noHpController.dispose();
    super.dispose();
  }
}
