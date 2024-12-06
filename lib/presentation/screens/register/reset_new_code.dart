import 'package:fatvo_uz/data/core/utils/resrert_password/resret_password_cubit.dart';
import 'package:fatvo_uz/data/core/utils/resrert_password/resret_password_state.dart';
import 'package:fatvo_uz/presentation/screens/bootom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetNewCode extends StatefulWidget {
  String secretKey;

  ResetNewCode(this.secretKey, {Key? key}) : super(key: key);

  @override
  State<ResetNewCode> createState() => _ResetNewCodeState();
}

class _ResetNewCodeState extends State<ResetNewCode> {
  bool visibility = true;
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _passController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ResetPasswordCubit(),
  child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/masjidlarbg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
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
                  controller: _passController,
                  obscureText: visibility,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: const Color(0xff285359),
                  decoration: InputDecoration(
                    hintText: "Yangi parol kiriting",
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          visibility = !visibility;
                        });
                      },
                      icon: Icon(
                        visibility ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xff285359),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
            ClipRRect(
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
                  controller: _passController2,
                  obscureText: visibility,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: const Color(0xff285359),
                  decoration: InputDecoration(
                    hintText: "Parolni qayta kiriting",
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          visibility = !visibility;
                        });
                      },
                      icon: Icon(
                        visibility ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xff285359),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color(0xff285359),
                  ),
                ),
                onPressed: () {
                  if (_passController.text == _passController2.text) {
                     context.read<ResetPasswordCubit>().savePass(
                        _passController.text.trim(), widget.secretKey);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBar(),
                      ),
                    );
                  } else {
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Saqlash",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ))
          ],
        ),
      ),
    );
  },
),
);
  }
}
