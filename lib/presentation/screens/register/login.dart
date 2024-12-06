import 'dart:io';

import 'package:fatvo_uz/data/core/utils/register/user_profile.dart';
import 'package:fatvo_uz/presentation/screens/register/resret_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fatvo_uz/data/core/utils/register/auth_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/login_cubit.dart';
import 'package:fatvo_uz/presentation/screens/profile.dart';
import '../bootom_nav_bar.dart';
import 'register.dart'; // Register screen

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visibility = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool ui = false;

  @override
  Widget build(BuildContext context) {
    return ui == false
        ? BlocProvider(
            create: (context) => AuthCubit(),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                  body: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/masjidlarbg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: double.infinity,
                    width: double.infinity,
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 38, color: Color(0xff285359)),
                            ),
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                              _emailController, 'example@gmail.com', false),
                          buildTextField(_passController, 'Parol', true),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResetPassword(),
                                ),
                              );
                            },
                            child: const Text(
                              "Parolni unutdingizmi?",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff285359),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const Register(),
                              //   ),
                              // );
                              setState(() {
                                ui = true;
                              });
                            },
                            child: const Text(
                              "Ro‘yxatdan o‘tish",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff285359),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 28),
                          InkWell(
                            onTap: () {
                              final email = _emailController.text;
                              final password = _passController.text;
                              context.read<AuthCubit>().login(
                                  email.toString().trim(),
                                  password.toString().trim());
                              print("Mana");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BottomNavBar(),
                                  ));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.only(left: 12, right: 12),
                              height: 50,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                color: Color(0xff285359),
                              ),
                              child: const Text(
                                "Kirish",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : Register();
  }

  Widget buildTextField(
      TextEditingController controller, String hintText, bool isPassword) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 56,
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xffF0F0F0),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: TextField(
          controller: controller,
          obscureText: isPassword ? visibility : false,
          keyboardType: TextInputType.emailAddress,
          cursorColor: const Color(0xff285359),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        visibility = !visibility;
                      });
                    },
                    icon: Icon(
                      visibility ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xff285359),
                    ),
                  )
                : null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ),
    );
  }
}
