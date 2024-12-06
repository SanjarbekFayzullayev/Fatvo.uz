import 'package:fatvo_uz/data/core/utils/register/register_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/verify_code_cubit.dart';
import 'package:fatvo_uz/data/core/utils/resrert_password/_reset_password_send_code_email_cubit.dart';
import 'package:fatvo_uz/data/core/utils/resrert_password/resret_password_cubit.dart';
import 'package:fatvo_uz/data/core/utils/resrert_password/resret_password_state.dart';
import 'package:fatvo_uz/presentation/screens/register/reset_new_code.dart';
import 'package:fatvo_uz/presentation/screens/register/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool passWait = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocProvider(
        create: (context) => ResetPasswordSendCodeEmailCubit(),
        child: Scaffold(
          body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, codeState) {
              if (codeState is ResetPasswordSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetNewCode(
                      codeState.secretKey.toString(),
                    ),
                  ),
                );
              } else {
                setState(() {
                  passWait = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color(0xff285359),
                    content: Text(
                      "Parolni  to'g'ri  kiriting!",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return BlocConsumer<ResetPasswordSendCodeEmailCubit,
                  ResetPasswordSendCodeEmailState>(
                listener: (context, state) {
                  if (state is ResetPasswordSendCodeEmailFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: const Color(0xff285359),
                        content: Text(
                          state.error.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/masjidlarbg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state is ResetPasswordSendCodeEmailSuccess
                                ? "Kodni tasdiqlash"
                                : "Parolni tiklash",
                            style: const TextStyle(
                              fontSize: 30,
                              color: Color(0xff285359),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          state is ResetPasswordSendCodeEmailSuccess
                              ? const SizedBox()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 12, right: 12, bottom: 12),
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
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                      ),
                                    ),
                                  ),
                                ),
                          state is ResetPasswordSendCodeEmailSuccess
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 12, right: 12, bottom: 12),
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
                                      keyboardType: TextInputType.phone,
                                      cursorColor: const Color(0xff285359),
                                      decoration: InputDecoration(
                                        hintText: 'Kondni kiriting',
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 28,
                          ),
                          ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Color(0xff285359),
                                ),
                              ),
                              onPressed: () {
                                if (state
                                    is ResetPasswordSendCodeEmailSuccess) {
                                  setState(() {
                                    passWait = true;
                                  });
                                  context.read<ResetPasswordCubit>().verifyCode(
                                        _emailController.text.toString().trim(),
                                        _passController.text.toString().trim(),
                                      );
                                  print(_emailController.text.toString().trim());
                                print(_passController.text.toString().trim(),);
                                } else {
                                  if (_emailController.text
                                          .toString()
                                          .trim()
                                          .contains("@") &&
                                      _emailController.text
                                          .toString()
                                          .trim()
                                          .isNotEmpty) {
                                    final email =
                                        _emailController.text.toString().trim();
                                    context
                                        .read<ResetPasswordSendCodeEmailCubit>()
                                        .sendCode(email);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Color(0xff285359),
                                        content: Text(
                                          "Emailni to'g'ri  kiriting!",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    state is ResetPasswordSendCodeEmailLoading ||
                                            passWait == true
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            "Kirish",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

}
