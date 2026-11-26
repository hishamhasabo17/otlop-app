import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otlop_app/auth_data_source.dart';
import 'package:otlop_app/helpers/custom_button.dart';
import 'package:otlop_app/helpers/colors.dart';
import 'package:otlop_app/helpers/custom_form.dart';
import 'package:otlop_app/helpers/custom_title.dart';
import 'package:otlop_app/helpers/header.dart';
import 'package:otlop_app/helpers/validators.dart';
import 'package:otlop_app/screens/nav_bar_screen/nav_bar_screen.dart';
import 'package:otlop_app/screens/signup/signup_screen.dart';

import '../../cubits/login_cubit.dart';
import '../../cubits/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = true;
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailcontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(AuthDataSource()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  AuthHeader(
                    headerTitle: 'Otlop',
                    headerSubTitle: 'Hello again, you’ve been missed!',
                  ),
                  const SizedBox(height: 50),
                  AuthTitle(title: 'Email'),
                  CustomForm(
                    hintText: 'Enter Your Email',
                    controller: emailcontroller,
                    validator: (email) => Validator.validateEmail(email!),
                  ),
                  const SizedBox(height: 12),
                  AuthTitle(title: 'Password'),
                  CustomForm(
                    controller: passcontroller,
                    hintText: 'Please Enter Your Password',
                    suffix: Icons.visibility,
                    validator: (pass) => Validator.validatePassword(pass!),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value ?? false;
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: Color(primarycolor),
                          side: const BorderSide(color: Color(0xFFD5D9E5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Remember Me',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 35),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNavBar()),
                        );
                      } else if (state is LoginFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        title: state is LoginLoading ? 'Loading...' : 'Log In',
                        onpressserd: state is LoginLoading
                            ? () {}
                            : () {
                                if (!formkey.currentState!.validate()) return;
                                context.read<LoginCubit>().login(
                                      email: emailcontroller.text,
                                      pass: passcontroller.text,
                                    );
                              },
                      );
                    },
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(color: Colors.grey, thickness: 0.8)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Or With',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      const Expanded(
                          child: Divider(color: Colors.grey, thickness: 0.8)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: const BorderSide(color: Color(0xFFD5D9E5)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/icon-github-1 1.svg'),
                              const SizedBox(width: 8),
                              const Text('GitHub', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: const BorderSide(color: Color(0xFFD5D9E5)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            minimumSize: const Size(0, 38),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/gitlab-seeklogo.com 1.svg',
                              ),
                              const SizedBox(width: 8),
                              const Text('GitLab', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 190),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don’t have an account ?',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SignupScreen()),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(left: 8),
                          minimumSize: const Size(0, 35),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(primarycolor),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
