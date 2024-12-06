import 'package:fatvo_uz/data/core/utils/register/auth_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/user_profile.dart';
import 'package:fatvo_uz/presentation/screens/my_questions_page.dart';
import 'package:fatvo_uz/presentation/screens/register/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/profilebg.png"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: LoginPage(),

          // BlocProvider(
          //   create: (context) => UserProfileCubit()..getUserProfile(),
          //   child: BlocBuilder<UserProfileCubit, UserProfileState>(
          //     builder: (context, state) {
          //       if (state is UserProfileLoading) {
          //         return const Center(
          //           child: CircularProgressIndicator(
          //             color: Colors.blueGrey,
          //           ),
          //         );
          //       } else if (state is UserProfileLoaded) {
          //         final userProfile = state.userProfile;
          //         return Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             Column(
          //               children: [
          //                 Container(
          //                   width: 80,
          //                   height: 80,
          //                   decoration: BoxDecoration(
          //                     color: Colors.blueGrey,
          //                     borderRadius: BorderRadius.circular(100),
          //                   ),
          //                   child: const Icon(
          //                     CupertinoIcons.person_fill,
          //                     color: Colors.white,
          //                     size: 60,
          //                   ),
          //                 ),
          //                 const SizedBox(
          //                   height: 10,
          //                 ),
          //                 Text(
          //                   "${userProfile['first_name']} ${userProfile['last_name']}",
          //                   style: const TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 24,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(left: 20, bottom: 78),
          //               child: Column(
          //                 children: [
          //                   InkWell(
          //                     onTap: () {
          //                       Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                           builder: (context) => MyQuestionsPage(),
          //                         ),
          //                       );
          //                     },
          //                     child: const Row(
          //                       children: [
          //                         Icon(
          //                           Icons.question_answer,
          //                           color: Color(0xff446D71),
          //                           size: 36,
          //                         ),
          //                         SizedBox(
          //                           width: 6,
          //                         ),
          //                         Text(
          //                           "Mening savollarim",
          //                           style: TextStyle(
          //                               fontSize: 20,
          //                               color: Color(0xff454545),
          //                               fontWeight: FontWeight.bold),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   const SizedBox(
          //                     height: 18,
          //                   ),
          //                   const Row(
          //                     children: [
          //                       Icon(
          //                         Icons.share,
          //                         color: Color(0xff446D71),
          //                         size: 36,
          //                       ),
          //                       SizedBox(
          //                         width: 6,
          //                       ),
          //                       Text(
          //                         "Ulashish",
          //                         style: TextStyle(
          //                             fontSize: 20,
          //                             color: Color(0xff454545),
          //                             fontWeight: FontWeight.bold),
          //                       ),
          //                     ],
          //                   ),
          //                   const SizedBox(
          //                     height: 18,
          //                   ),
          //                   const Row(
          //                     children: [
          //                       Icon(
          //                         Icons.settings,
          //                         color: Color(0xff446D71),
          //                         size: 36,
          //                       ),
          //                       SizedBox(
          //                         width: 6,
          //                       ),
          //                       Text(
          //                         "Sozlanmalar",
          //                         style: TextStyle(
          //                             fontSize: 20,
          //                             color: Color(0xff454545),
          //                             fontWeight: FontWeight.bold),
          //                       ),
          //                     ],
          //                   ),
          //                   const SizedBox(
          //                     height: 18,
          //                   ),
          //                   const Row(
          //                     children: [
          //                       Icon(
          //                         Icons.notifications,
          //                         color: Color(0xff446D71),
          //                         size: 36,
          //                       ),
          //                       SizedBox(
          //                         width: 6,
          //                       ),
          //                       Text(
          //                         "Bildirishnomalar",
          //                         style: TextStyle(
          //                             fontSize: 20,
          //                             color: Color(0xff454545),
          //                             fontWeight: FontWeight.bold),
          //                       ),
          //                     ],
          //                   ),
          //                   const SizedBox(
          //                     height: 18,
          //                   ),
          //                   InkWell(
          //                     onTap: ()  {
          //
          //                       final userProfileCubit = UserProfileCubit();
          //                       userProfileCubit.showLogoutDialog(context, userProfileCubit, userProfile['first_name'], userProfile['last_name']);
          //                     },
          //                     child: const Row(
          //                       children: [
          //                         Icon(
          //                           Icons.exit_to_app,
          //                           color: Color(0xff446D71),
          //                           size: 36,
          //                         ),
          //                         SizedBox(
          //                           width: 6,
          //                         ),
          //                         Text(
          //                           "Chiqish",
          //                           style: TextStyle(
          //                               fontSize: 20,
          //                               color: Color(0xff454545),
          //                               fontWeight: FontWeight.bold),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         );
          //       } else if (state is UserProfileError) {
          //         print("error bo'ldiyov");
          //         return const LoginPage();
          //       } else {
          //         print("error bo'ldiyov");
          //
          //         return const LoginPage();
          //       }
          //     },
          //   ),
          // ),
        ),
      ),
    );
  }

}
