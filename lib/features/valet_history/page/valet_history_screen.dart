import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:prestige_valet_app/features/valet_history/widgets/history_card_widget.dart';

class ValetHistoryScreen extends StatefulWidget {
  const ValetHistoryScreen({super.key});

  @override
  State<ValetHistoryScreen> createState() => _ValetHistoryScreenState();
}

class _ValetHistoryScreenState extends State<ValetHistoryScreen> {
  @override
  void initState() {
    HomeCubit.get(context).getParkingHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorManager.whiteColor,
            ),
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
            if (state is GetPaymentHistoryLoading) ...[
              SizedBox(
                height:
                    HomeCubit.get(context).bodyBoxHeight(context, screenHeight),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.primaryColor,
                  ),
                ),
              )
            ] else if (state is GetPaymentHistoryLoaded) ...[
              SizedBox(
                height:
                    HomeCubit.get(context).bodyBoxHeight(context, screenHeight),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.paymentHistoryModel.content.length,
                    itemBuilder: (context, index) {
                      return HistoryCardWidget(
                        item: state.paymentHistoryModel.content[index],
                      );
                    }),
              ),
            ]
          ],
        )),
      );
    });
  }
}
