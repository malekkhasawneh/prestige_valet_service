import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/valet_history/widgets/history_card_widget.dart';

class ValetHistoryScreen extends StatelessWidget {
  const ValetHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,color: ColorManager.whiteColor,),
        ),
        backgroundColor: ColorManager.primaryColor,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height:
                HomeCubit.get(context).headerBoxHeight(context, screenHeight),
            width: screenWidth,
            color: ColorManager.primaryColor,
            child: Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.05,
                top: HomeCubit.get(context)
                        .headerBoxHeight(context, screenHeight) *
                    0.35,
              ),
              child: Text(
                Strings.carParkedHiString(
                    HomeCubit.get(context).userModel.user.firstName),
                style: const TextStyle(
                    fontFamily: Fonts.sourceSansPro,
                    fontSize: 26,
                    color: ColorManager.whiteColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: HomeCubit.get(context).bodyBoxHeight(context, screenHeight),
            child: HomeCubit.get(context).userHistory.isEmpty
                ? const Center(
                    child: Text(
                      Strings.thereAreNoData,
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: HomeCubit.get(context).userHistory.length,
                    itemBuilder: (context, index) {
                      return HistoryCardWidget(
                        item: HomeCubit.get(context).userHistory[index],
                      );
                    }),
          ),
        ],
      )),
    );
  }
}
