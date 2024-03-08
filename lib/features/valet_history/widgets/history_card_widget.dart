import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/features/valet/data/model/park_history_model.dart';

class HistoryCardWidget extends StatelessWidget {
  const HistoryCardWidget({super.key, required this.item});

  final ParkHistoryContent item;

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
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.valet.location!.locationName!,
                    style: const TextStyle(
                      fontFamily: Fonts.sourceSansPro,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('12/10/2023  4:30 PM - 7:55 PM',style: TextStyle(fontSize: 10),),

                ],
              ),
              const SizedBox(height: 2,),
               Text(
                item.retrievingGate,
                style: const TextStyle(
                  fontFamily: Fonts.sourceSansPro,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          const SizedBox(height: 20,),
          const Row(
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
