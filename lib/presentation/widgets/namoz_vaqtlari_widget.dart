import 'package:fatvo_uz/data/core/utils/namoz_vaqtlari/namoz_vaqtlari_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:intl/intl.dart';

class NamozVaqtlariListWidget extends StatefulWidget {

  NamozVaqtlariListWidget({Key? key}) : super(key: key);

  @override
  State<NamozVaqtlariListWidget> createState() =>
      _NamozVaqtlariListWidgetState();
}

class _NamozVaqtlariListWidgetState extends State<NamozVaqtlariListWidget> {
  late NamozVaqtlariListCubit _cubit;
  DateTime _selectedDay = DateTime.now();


  @override
  void initState() {
    super.initState();
    _cubit = context.read<NamozVaqtlariListCubit>();
    _cubit.updatePrayerTimes();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NamozVaqtlariListCubit, List<String>>(
      builder: (context, namozVaqtlari) {
        var namozVatlariMin = [
          _cubit.extractTime(namozVaqtlari[0]),
          _cubit.extractTime(namozVaqtlari[1]),
          _cubit.extractTime(namozVaqtlari[2]),
          _cubit.extractTime(namozVaqtlari[3]),
          _cubit.extractTime(namozVaqtlari[4]),
          _cubit.extractTime(namozVaqtlari[5])
        ];

        String currentTime = _cubit.getCurrentTime(); // Hozirgi vaqt
        String closestPrayerTime =
        _cubit.findClosestPrayerTime(namozVatlariMin, currentTime);
        String time=closestPrayerTime??namozVatlariMin[0];
        int differenceInMinutes = _cubit.calculateTimeDifference(
          closestPrayerTime == "" ? currentTime : closestPrayerTime,
          currentTime,
        );
        return Expanded(
          child: ListView.builder(
            itemCount: namozVaqtlari.length,
            itemBuilder: (context, index) =>
                Item(_cubit.names[index],
                    _cubit.extractTime(namozVaqtlari[index]), context,
                    index, time),
          ),
        );
      },
    );
  }

  Widget Item(String namozNomi, String namozVaqti, BuildContext context,
      int index, String closestPrayerTime) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    var size = mediaQueryData.size;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
      child: Card(
        elevation: 6,
        shadowColor: Colors.black,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        child: InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: () {
            _cubit.toggleSelectedIndex(index); // Cubitni ishlatish
          },
          child: Container(
            width: size.width * 0.82,
            height: size.height * 0.096,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: (closestPrayerTime== namozVaqti)
                  ?const Color(0xFF6F999F)
                  : Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(size.height * 0.026),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.height * 0.02, right: size.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    namozNomi,
                    style: TextStyle(
                        color: Colors.black, fontSize: size.height * 0.024),
                  ),
                  Row(
                    children: [
                      Text(
                        namozVaqti,
                        style: TextStyle(
                            color: const Color(0xff285359),
                            fontSize: size.height * 0.021),
                      ),
                      Icon(
                        _cubit.selectedIndex.contains(index)
                            ? Icons.volume_off
                            : Icons.volume_up,
                        color:const Color(0xff285359),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}