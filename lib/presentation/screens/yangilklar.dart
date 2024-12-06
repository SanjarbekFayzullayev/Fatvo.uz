import 'package:fatvo_uz/presentation/screens/details_news.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff515151),
        ),
        backgroundColor: const Color(0xffF3F9F9),
        centerTitle: true,
        title: const Text(
          "Fatvo.uz",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xff515151),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgpages.png"),
          ),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 12,
              child: InkWell(
                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const DetailsNews(),),),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Color(0xffF0F0F0),
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        height: 190,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          image: DecorationImage(
                              image: AssetImage("assets/images/fatvouzlogo.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Fatvo.uz сайти мобил иловаси иш бошлади!",
                          style: TextStyle(
                              fontSize: 24,
                              color: Color(0xff2C2C2C),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  color: Color(0xff818C99),
                                ),
                                Text(
                                  "21",
                                  style:
                                      TextStyle(color: Color(0xff626D7A), fontSize: 14),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.sms_outlined,
                                  color: Color(0xff818C99),
                                ),
                                Text(
                                  "17",
                                  style:
                                  TextStyle(color: Color(0xff626D7A), fontSize: 14),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.share,
                                  color: Color(0xff818C99),
                                ),
                                Text(
                                  "21",
                                  style:
                                  TextStyle(color: Color(0xff626D7A), fontSize: 14),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.visibility,
                                  color: Color(0xff818C99),
                                ),
                                Text(
                                  "2234",
                                  style:
                                  TextStyle(color: Color(0xff626D7A), fontSize: 14),
                                ),
                              ],
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
