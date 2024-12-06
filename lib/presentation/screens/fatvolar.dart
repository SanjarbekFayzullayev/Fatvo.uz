import 'dart:convert';
import 'dart:ui';

import 'package:fatvo_uz/data/core/utils/questions/fatwas_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/user_profile.dart';
import 'package:fatvo_uz/presentation/screens/fatwa_details.dart';
import 'package:fatvo_uz/presentation/screens/send_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class FatwasPage extends StatefulWidget {
  FatwasPage({Key? key}) : super(key: key);

  @override
  State<FatwasPage> createState() => _FatwasPageState();
}

class _FatwasPageState extends State<FatwasPage> {
  List<String> types = [
    "Barchasi",
    "Namoz",
    "Haj",
    "Umra",
    "Zakot",
    "Ro’za",
    "Ilim",
  ];
  List<String> type = [
    " ",
    "Намоз",
    "Ҳаж",

    "Умра",
    "Закот",
    "Рўза",
    "Илим",
  ];

  int select = 0;
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit()..getUserProfile(),
      child: BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: const Color(0xff285359),
            //   onPressed: () {
            //     if (state is UserProfileLoaded) {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => SendQuestion(),
            //           ));
            //     } else {
            //       showMessageDialog(context);
            //     }
            //   },
            //   child: const Icon(
            //     Icons.question_answer_sharp,
            //     color: Colors.white,
            //     size: 30,
            //   ),
            // ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bgpages.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: 56,
                        child: ClipRRect(
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
                              onChanged: (value) {
                                setState(() {
                                  searchController.text = value;
                                });
                                print(searchController.text);
                              },
                              controller: searchController,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                  Icons.search,
                                  color: Color(0xff285359),
                                ),
                                hintText: 'Qidirish...',
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
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: types.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                select = index;
                              });
                              print(select);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: select == index
                                    ? const Color(0xff41686D)
                                    : const Color(0xffF0F0F0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  types[index],
                                  style: select == index
                                      ? const TextStyle(
                                          color: Colors.white, fontSize: 16)
                                      : const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<FatwasCubit, FatwasState>(
                      builder: (context, state) {
                        if (state is FatwasLoading && currentPage == 1) {
                          // return const Padding(
                          //   padding: EdgeInsets.only(top: 30),
                          //   child: Center(
                          //     child: CircularProgressIndicator(
                          //       color: Color(0xff285359),
                          //     ),
                          //   ),
                          // );
                          return Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: 100,
                              itemBuilder: (context, index) {
                                return   Container(
                                  height: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>  DetailsFatwa(),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/fatvouzlogo.png",
                                          width: 80, // Rasm uchun kenglik belgilanmoqda
                                          height: 80, // Rasm uchun balandlik belgilanmoqda
                                          fit: BoxFit
                                              .cover, // Rasmni konteynerga to'liq sig'dirish
                                        ),
                                        const SizedBox(width: 10),
                                        // Matn va rasm orasidagi bo'shliq
                                        const Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            // Matnni chapga hizalash
                                            children: [
                                              Text(
                                                "❓1266-САВОЛ: МАЙЙИТНИНГ ТИЛЛА ТИШЛАРИНИ ОЛИБ ҚЎЙИЛАДИМИ?",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                // Sig'magan qismni kesib tashlash
                                                maxLines:
                                                3, // Matnni maksimal 3 qatorgacha cheklash
                                              ),
                                              SizedBox(height: 8),
                                              // Matnlar orasidagi bo'shliq
                                              Text(
                                                "15-mart, 18:00 . Fatvo.uz",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is FatwasLoaded) {
                          print(currentPage);
                          return Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: state.fatwas.results!.length,
                              itemBuilder: (context, index) {
                                if (index == state.fatwas.results!.length) {
                                  // Yuklanish indikatorini oxirida ko'rsatish
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xff285359),
                                    ),
                                  );
                                }
                                final data = state.fatwas.results![index];
                                DateTime dateTime = DateTime.parse(
                                    data.updatedAt.toString().substring(0, 26));

                                if (decodeUtf8(data.truncatedAnswer!)
                                    .contains(type[select])) {
                                  return decodeUtf8(data.title!)
                                          .contains(searchController.text)
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 130,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: InkWell(
                                              onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsFatwa(
                                                    answer: decodeUtf8(data
                                                            .truncatedAnswer!) ??
                                                        "",
                                                    view: data.view ?? 0,
                                                    quiz: decodeUtf8(
                                                            data.title!) ??
                                                        "",
                                                    date: decodeUtf8(
                                                      "${dateTime.year}:${dateTime.month}:${dateTime.day} , ${dateTime.hour}:${dateTime.minute}" ??
                                                          "",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/images/fatvouzlogo.png",
                                                    width: 80,
                                                    // Rasm uchun kenglik belgilanmoqda
                                                    height: 80,
                                                    // Rasm uchun balandlik belgilanmoqda
                                                    fit: BoxFit
                                                        .cover, // Rasmni konteynerga to'liq sig'dirish
                                                  ),
                                                  const SizedBox(width: 10),
                                                  // Matn va rasm orasidagi bo'shliq
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        // Matnni chapga hizalash
                                                        children: [
                                                          Text(
                                                            decodeUtf8(
                                                                data.title!),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            // Sig'magan qismni kesib tashlash
                                                            maxLines:
                                                                3, // Matnni maksimal 3 qatorgacha cheklash
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 8.0),
                                                              child: Text(
                                                                decodeUtf8(data
                                                                    .truncatedQuestion!),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                // Sig'magan qismni kesib tashlash
                                                                maxLines:
                                                                    3, // Matnni maksimal 3 qatorgacha cheklash
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          // Matnlar orasidagi bo'shliq
                                                          const Text(
                                                            "15-mart, 18:00 . Fatvo.uz",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                } else {
                                  const Center(
                                    child: Text("Malumot yo'q"),
                                  );
                                }
                              },
                            ),
                          );
                        } else if (state is FatwasError) {
                          print(state.error);
                          return Center(child: Text(state.error));
                        } else {
                          // return const Padding(
                          //   padding: EdgeInsets.only(top: 30),
                          //   child: Center(
                          //     child: CircularProgressIndicator(
                          //       color: Color(0xff285359),
                          //     ),
                          //   ),
                          // );
                          return Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: 100,
                              itemBuilder: (context, index) {
                                return   Container(
                                  height: 130,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>  DetailsFatwa(),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/fatvouzlogo.png",
                                          width: 80, // Rasm uchun kenglik belgilanmoqda
                                          height: 80, // Rasm uchun balandlik belgilanmoqda
                                          fit: BoxFit
                                              .cover, // Rasmni konteynerga to'liq sig'dirish
                                        ),
                                        const SizedBox(width: 10),
                                        // Matn va rasm orasidagi bo'shliq
                                        const Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            // Matnni chapga hizalash
                                            children: [
                                              Text(
                                                "❓1266-САВОЛ: МАЙЙИТНИНГ ТИЛЛА ТИШЛАРИНИ ОЛИБ ҚЎЙИЛАДИМИ?",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                // Sig'magan qismni kesib tashlash
                                                maxLines:
                                                3, // Matnni maksimal 3 qatorgacha cheklash
                                              ),
                                              SizedBox(height: 8),
                                              // Matnlar orasidagi bo'shliq
                                              Text(
                                                "15-mart, 18:00 . Fatvo.uz",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );

                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

String decodeUtf8(String encoded) {
  // Kodlangan matnni UTF-8 formatidan dekodlash
  List<int> bytes = encoded.codeUnits;
  return utf8.decode(bytes);
}

void showMessageDialog(BuildContext context) {
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
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Tizimdan ro'yxatdan o'tmagansiz!",
                  style: TextStyle(
                      fontSize: 26,
                      color: Color(0xff446C71),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color(0xff446C71),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Ortga",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
