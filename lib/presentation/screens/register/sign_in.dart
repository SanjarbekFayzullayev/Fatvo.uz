import 'dart:io';

import 'package:fatvo_uz/data/core/utils/register/auth_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/create_account_cubit.dart';
import 'package:fatvo_uz/presentation/screens/bootom_nav_bar.dart';
import 'package:fatvo_uz/presentation/screens/register/login.dart';
import 'package:fatvo_uz/presentation/screens/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  late String secretKey;
  late String email;

  SignIn(this.secretKey, this.email, {super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool visibility = true;
  late TextEditingController _emailController;
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // widget.email ni boshlang'ich qiymat sifatida belgilaymiz
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bgpages.png"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: BlocProvider(
            create: (context) => CreateAccountCubit(),
            child: BlocConsumer<CreateAccountCubit, CreateAccountState>(
              listener: (context, state) {
                if (state is CreateAccountSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  const LoginPage(),
                    ),
                  );
                } else if (state is CreateAccountFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Color(0xff285359),
                      content: Text(
                        "Nimadir xato ketdi!",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tizimdan \nro‘yxatdan o‘tish",
                          style: TextStyle(
                            color: Color(0xff285359),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "  Ism",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xffF0F0F0),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: TextField(
                              controller: _nameController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: const Color(0xff285359),
                              decoration: InputDecoration(
                                hintText: 'Ismingizni kiriting',
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(16),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "  Familya",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xffF0F0F0),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: TextField(
                              controller: _lastNameController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: const Color(0xff285359),
                              decoration: InputDecoration(
                                hintText: 'Familyangizni kiriting',
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(16),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "  Email",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xffF0F0F0),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: const Color(0xff285359),
                              decoration: InputDecoration(
                                hintText: 'example@gmail.com',
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(16),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "  Parol",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffF0F0F0),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: TextField(
                              controller: _passController,
                              cursorColor: const Color(0xff285359),
                              obscureText: visibility,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      visibility = !visibility;
                                    });
                                  },
                                  icon: Icon(
                                    visibility
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xff285359),
                                  ),
                                ),
                                hintText: 'Parol',
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.all(16),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Ro‘yxatan o‘tish orqali Foydalanish shart va qoidalariga rozilik bildirgan hisoblanasiz",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (_nameController.text.isEmpty ||
                                _lastNameController.text.isEmpty ||
                                _emailController.text.isEmpty ||
                                _passController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Iltimos, barcha maydonlarni to'ldiring."),
                                  backgroundColor: Colors.blueGrey,
                                ),
                              );
                            } else if (!_emailController.text.contains('@')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Iltimos, to'g'ri email manzilini kiriting."),
                                  backgroundColor: Colors.blueGrey,
                                ),
                              );
                            } else if (_passController.text.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Parol kamida 6 ta belgidan iborat bo'lishi kerak."),
                                  backgroundColor: Colors.blueGrey,
                                ),
                              );
                            } else {
                              // Agar hamma narsa to'g'ri bo'lsa, akkauntni yaratish
                              await context
                                  .read<CreateAccountCubit>()
                                  .createAccount(
                                    firstName:
                                        _nameController.text.toString().trim(),
                                    lastName: _lastNameController.text
                                        .toString()
                                        .trim(),
                                    password:
                                        _passController.text.toString().trim(),
                                    email:
                                        _emailController.text.toString().trim(),
                                    key: widget.secretKey,
                                  );
                              // exit(1);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              color: Color(0xff285359),
                            ),
                            child: state is CreateAccountLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Kirish",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Hisobingiz bormi?",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BottomNavBar(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Kirish",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff285359),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
