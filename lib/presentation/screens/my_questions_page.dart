import 'dart:convert';
import 'dart:ui';

import 'package:fatvo_uz/data/core/utils/questions/my_questions_cubit.dart';
import 'package:fatvo_uz/presentation/screens/send_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyQuestionsPage extends StatelessWidget {
  MyQuestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyQuestionsCubit()..fetchQuestions(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/profilebg.png"),
                  fit: BoxFit.cover),
            ),
            child: BlocBuilder<MyQuestionsCubit, MyQuestionsState>(
                builder: (context, state) {
              if (state is MyQuestionsLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.blueGrey,
                ));
              } else if (state is MyQuestionsLoaded) {
                final questions = state.questions;
                if (questions.isNotEmpty) {
                  print(questions[0].title!);
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 28, right: 8, bottom: 10),
                    child: ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final question = questions[index];
                        DateTime dateTime = DateTime.parse(
                            question.createdAt.toString().substring(0, 26));

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffEFF6F6),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              border:
                                  Border.all(color: question.isAnswered ==true?Colors.lightGreen:Colors.blueGrey, width: 2),
                              // lightGreen
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                        width: 90,
                                        height: 90,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            question.attachedFile.toString(),
                                            fit: BoxFit.cover,
                                            width: 90,
                                            height: 90,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        const Color(0xff285359),
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            (loadingProgress
                                                                    .expectedTotalBytes ??
                                                                1)
                                                        : null,
                                                  ),
                                                );
                                              }
                                            },
                                            errorBuilder: (BuildContext context,
                                                Object error,
                                                StackTrace? stackTrace) {
                                              return ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(12),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/fatvouzlogo.png",
                                                    height: 90,
                                                    width: 90,
                                                    fit: BoxFit.cover,
                                                  ));
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            "${question.questioner?.firstName} ${question.questioner?.lastName}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            "${dateTime.year}:${dateTime.month}:${dateTime.day} , ${dateTime.hour}:${dateTime.minute}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    decodeUtf8(
                                      question.question.toString(),
                                    ),
                                  ),
                                ),
                                question.isAnswered ==true? InkWell(
                                  onTap: () {
                                 showQuesAnswerDialog(context,question.answer??"");
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(left: 12, right: 12,bottom: 12),
                                    height: 50,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(18)),
                                      color: Colors.lightGreen,
                                    ),
                                    child: const Text(
                                      "Javobni o'qish",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ):const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("⏳ Savol ko'rib chiqilmoqda...",style: TextStyle(color: Colors.grey),),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Hech qanday savol bermagansiz!',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            side: WidgetStatePropertyAll(
                              BorderSide(color: Colors.blueGrey),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SendQuestion(),
                                ));
                          },
                          child: const Text(
                            "Savol yuborish 📝",
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        )
                      ],
                    ),
                  );
                }
              } else if (state is MyQuestionsError) {
                return Center(
                  child: Text('Xatolik yuz berdi: ${state.message}'),
                );
              } else {
                return const Center(
                  child: Text('Hech qanday savol mavjud emas'),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}

String decodeUtf8(String encoded) {
  // Kodlangan matnni UTF-8 formatidan dekodlash
  List<int> bytes = encoded.codeUnits;
  return utf8.decode(bytes);
}
void showQuesAnswerDialog(BuildContext context, String answer) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 12),
                   Text(
                  decodeUtf8(answer),
                    style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
              
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.lightGreen,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:  const Text(
                      "Ortga",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}