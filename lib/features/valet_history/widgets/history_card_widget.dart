import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';

class HistoryCardWidget extends StatelessWidget {
  const HistoryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: 15,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      width: screenWidth * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Taj Mall',
                        style: TextStyle(
                          fontFamily: Fonts.sourceSansPro,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '4:30 PM - 6:30 PM',
                        style: TextStyle(
                          fontFamily: Fonts.sourceSansPro,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(height: 2,),
                  Text(
                    'Gate 3',
                    style: TextStyle(
                      fontFamily: Fonts.sourceSansPro,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),


          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Paid in cash',
                style: TextStyle(
                  fontFamily: Fonts.sourceSansPro,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                '5 JD',
                style: TextStyle(
                  fontFamily: Fonts.sourceSansPro,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          )
        ],
      ),
    );
  }
}
