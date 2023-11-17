import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/features/add_credit_card/presentation/cubit/add_credit_card_cubit.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.title,
    this.hintText = '',
    required this.controller,
    required this.textInputType,
    this.addPrefixIcon = false,
    this.addSuffixIcon = false,
    this.isPassword = false,
    this.suffixIcon = const SizedBox(),
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool addPrefixIcon;
  final bool addSuffixIcon;
  final bool isPassword;
  final Widget suffixIcon;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<AddCreditCardCubit, AddCreditCardState>(
        builder: (context, state) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: Fonts.sourceSansPro,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: TextFormField(
                  obscureText: isPassword,
                  controller: controller,
                  maxLength: 5,
                  keyboardType: textInputType,
                  decoration: InputDecoration(
                      prefixIcon: addPrefixIcon
                          ? const Text('+962 - ')
                          : const SizedBox(
                              width: 7,
                            ),
                      prefixIconConstraints:
                          const BoxConstraints(minHeight: 10),
                      suffixIcon: suffixIcon,
                      suffixIconConstraints:
                          const BoxConstraints(minHeight: 10),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 7, bottom: 6, top: addSuffixIcon ? 9 : 0),
                      counterText: '',
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        fontFamily: Fonts.sourceSansPro,
                        fontSize: 12,
                      )),
                  cursorColor: ColorManager.primaryColor,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
