import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fatvo_uz/data/core/utils/questions/_send_question_cubit.dart'; // Cubit faylini import qilish

class SendQuestion extends StatefulWidget {
  SendQuestion({Key? key}) : super(key: key);

  @override
  State<SendQuestion> createState() => _SendQuestionState();
}

class _SendQuestionState extends State<SendQuestion> {
  final TextEditingController questionController = TextEditingController();
  File? attachedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/profilebg.png"),
              fit: BoxFit.cover,
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            // Added SingleChildScrollView to handle overflows
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  style: TextStyle(),
                  controller: questionController,
                  minLines: 1,
                  // Dastlab 1 qator ko'rinadi
                  maxLines: null,
                  // Matn kirilganda balandlik kengayadi
                  decoration: InputDecoration(
                    labelText: 'Savolni kiriting',
                    labelStyle:
                        TextStyle(color: Color(0xff285359), fontSize: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      // Aylana chekka uchun radius
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        // Fokusda bo'lmaganda chegaraning rangi
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      // Fokusda bo'lganda ham aylana chekka
                      borderSide: const BorderSide(
                        color: Color(0xff285359),
                        // Fokusda yozayotganda chegaraning rangi ko'k
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.file_present_rounded,
                      size: 30,
                      color: Color(0xff285359),
                    ),
                    onPressed: () async {
                      // Fayl tanlash
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );
                      if (result != null && result.files.isNotEmpty) {
                        setState(() {
                          attachedFile = File(result.files.single.path!);
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                if (attachedFile != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                        'Tanlangan fayl:${attachedFile!.path.split('/').last}'),
                  ),
                const SizedBox(height: 20),
                BlocProvider(
                  create: (context) => SendQuestionAndFileCubit(),
                  child: BlocConsumer<SendQuestionAndFileCubit,
                      SendQuestionAndFileState>(
                    listener: (context, state) {
                      if (state is SendQuestionAndFileSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: const Color(0xff285359),
                          content: Text(
                            state.message,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ));
                      } else if (state is SendQuestionAndFileError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color(0xff285359),
                            content: Text(
                              "Fayl hajmi katta yokiy Internet hatosi!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is SendQuestionAndFileLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff285359),
                          ),
                        );
                      } else if (state is SendQuestionAndFileSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.message),
                            if (state.fileName != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  state.fileName.toString(),
                                ),
                              ),
                          ],
                        );
                      }
                      return InkWell(
                        onTap: () {
                          context
                              .read<SendQuestionAndFileCubit>()
                              .sendQuestionAndFile(
                                question: questionController.text,
                                file: attachedFile, // Faylni yuboramiz
                              );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 12, right: 12),
                          height: 50,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            color: Color(0xff285359),
                          ),
                          child: const Text(
                            "Yuborish",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
