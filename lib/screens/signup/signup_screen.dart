import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otlop_app/helpers/custom_button.dart';
import 'package:otlop_app/helpers/colors.dart';
import 'package:otlop_app/helpers/custom_form.dart';
import 'package:otlop_app/helpers/custom_title.dart';
import 'package:otlop_app/helpers/header.dart';
import 'package:otlop_app/helpers/validators.dart';
import 'package:otlop_app/screens/log_in_screen/log_in_screen.dart';

import '../../auth_data_source.dart';
import '../../cubits/sign_up_cubit.dart';
import '../../cubits/sign_up_state.dart';
import '../nav_bar_screen/nav_bar_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool rememberMe = true;
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    phonecontroller.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(AuthDataSource()),
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
                    headerTitle: 'Create an account',
                    headerSubTitle: 'Connect with your friends today!',
                  ),
                  const SizedBox(height: 42),
                  AuthTitle(title: 'Name'),
                  CustomForm(
                    hintText: 'Enter your name',
                    controller: namecontroller,
                    validator: (name) => Validator.validateUserName(name!),
                  ),
                  const SizedBox(height: 12),
                  AuthTitle(title: 'Email Address'),
                  CustomForm(
                    hintText: 'Enter your email',
                    controller: emailcontroller,
                    validator: (email) => Validator.validateEmail(email!),
                  ),
                  const SizedBox(height: 12),
                  AuthTitle(title: 'Phone Number'),
                  CustomForm(
                    hintText: 'Enter your phone',
                    controller: phonecontroller,
                    validator: (phone) => Validator.validatePhoneNumber(phone!),
                  ),
                  const SizedBox(height: 12),
                  AuthTitle(title: 'Password'),
                  CustomForm(
                    controller: passcontroller,
                    hintText: 'Please Enter Your Password',
                    suffix: Icons.visibility,
                    validator: (pass) => Validator.validatePassword(pass!),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      SizedBox(
                        width: 22,
                        height: 22,
                        child: Checkbox(
                          value: rememberMe,
                          side: const BorderSide(color: Color(0xFFD5D9E5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value ?? false;
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: Color(primarycolor),
                        ),
                      ),
                      const Text('Remember Me', style: TextStyle(fontSize: 12)),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  BlocConsumer<SignupCubit, SignupState>(
                    listener: (context, state) {
                      if (state is SignupSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Account created successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNavBar()),
                        );
                      } else if (state is SignupFailure) {
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
                        title: state is SignupLoading ? 'Loading...' : 'Sign Up',
                        onpressserd: state is SignupLoading
                            ? () {}
                            : () {
                                if (!formkey.currentState!.validate()) return;
                                context.read<SignupCubit>().signUp(
                                      name: namecontroller.text,
                                      email: emailcontroller.text,
                                      pass: passcontroller.text,
                                      phone: phonecontroller.text,
                                    );
                              },
                      );
                    },
                  ),
                  const SizedBox(height: 18),
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
                            minimumSize: const Size(0, 38),
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
                              SvgPicture.asset('assets/icons/gitlab-seeklogo.com 1.svg'),
                              const SizedBox(width: 8),
                              const Text('GitLab', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account ?',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Color(primarycolor),
                            fontWeight: FontWeight.bold,
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
