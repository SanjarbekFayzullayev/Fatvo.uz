import 'package:fatvo_uz/data/core/utils/namoz_vaqtlari/namoz_vaqtlari_cubit.dart';
import 'package:fatvo_uz/presentation/widgets/namoz_vaqtlari_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class NamozVaqtlari extends StatefulWidget {
  NamozVaqtlari({Key? key}) : super(key: key);

  @override
  State<NamozVaqtlari> createState() => _NamozVaqtlariState();
}

class _NamozVaqtlariState extends State<NamozVaqtlari> {
  late String lat;
  late String long;
  DateTime _selectedDay = DateTime.now();
  late NamozVaqtlariListCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<NamozVaqtlariListCubit>();
    _cubit.updatePrayerTimes();
    _cubit.initPrefs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<NamozVaqtlariListCubit, List<String>>(
        builder: (context, namozVaqtlari) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: size.height * 0.022, left: size.height * 0.022),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: const Color(0xff285359),
                              size: size.height * 0.036,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Joylashuv",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                                Text(
                                  _cubit.address,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.026,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Divider(
                    color: Colors.grey,
                    height: size.width * 0.002,
                    endIndent: size.width * 0.09,
                    indent: size.width * 0.09,
                  ),
                  SizedBox(
                    width: size.width * 0.86,
                    child: WeeklyDatePicker(
                      weekdays: const [
                        "Du",
                        "Se",
                        "Chor",
                        "Pay",
                        "Ju",
                        "Shan",
                        "Yak",
                      ],
                      backgroundColor: Colors.white,
                      selectedDigitBackgroundColor: const Color(0xff285359),

                      enableWeeknumberText: false,
                      selectedDay: _cubit.dateTime,
                      // DateTime
                      changeDay: (value) {
                        setState(() {
                          _cubit.updateDate(value);
                        });
                      },
                    ),
                  ),
                  // const MainWidgetNPage(),
                  NamozVaqtlariListWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
