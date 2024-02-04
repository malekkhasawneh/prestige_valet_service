import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestige_valet_app/core/resources/color_manager.dart';
import 'package:prestige_valet_app/core/resources/fonts.dart';
import 'package:prestige_valet_app/core/resources/strings.dart';
import 'package:prestige_valet_app/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:prestige_valet_app/features/sign_up/presentation/cubit/sign_up_cubit.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.title,
    this.hintText = '',
    required this.controller,
    required this.textInputType,
    this.selectedCountryKey = '',
    this.addPrefixIcon = false,
    this.addSuffixIcon = false,
    this.isPassword = false,
    this.suffixIcon = const SizedBox(),
    this.readOnly = false,
    this.mustCheck = false,
    this.maxLength = 1000,
    this.errorText = Strings.textFieldError,
    this.doubleCheck = false,
    this.isExpiry = false,
    this.onlyNumbers = false,
    this.isWrongEmail = false,
    this.isFromSignUp = true,
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool addPrefixIcon;
  final bool addSuffixIcon;
  final bool isPassword;
  final Widget suffixIcon;
  final bool readOnly;
  final bool mustCheck;
  final int maxLength;
  final String errorText;
  final bool doubleCheck;
  final bool isExpiry;
  final bool onlyNumbers;
  final bool isWrongEmail;
  final String selectedCountryKey;
  final bool isFromSignUp;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
              widget.title,
              style: const TextStyle(
                fontFamily: Fonts.sourceSansPro,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.062,
            child: Center(
              child: TextFormField(
                readOnly: widget.readOnly,
                obscureText: widget.isPassword,
                controller: widget.controller,
                keyboardType: widget.textInputType,
                inputFormatters: widget.isExpiry
                    ? [
                        CardExpirationFormatter(),
                      ]
                    : widget.onlyNumbers
                        ? [FilteringTextInputFormatter.digitsOnly]
                        : [],
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ((widget.controller.text.isEmpty ||
                                        widget.doubleCheck) &&
                                    widget.mustCheck) ||
                                (widget.controller.text.isNotEmpty &&
                                    widget.isWrongEmail)
                            ? Colors.red
                            : Colors.grey.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ((widget.controller.text.isEmpty ||
                                        widget.doubleCheck) &&
                                    widget.mustCheck) ||
                                (widget.controller.text.isNotEmpty &&
                                    widget.isWrongEmail)
                            ? Colors.red
                            : Colors.grey.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ((widget.controller.text.isEmpty ||
                                        widget.doubleCheck) &&
                                    widget.mustCheck) ||
                                (widget.controller.text.isNotEmpty &&
                                    widget.isWrongEmail)
                            ? Colors.red
                            : Colors.grey.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: InputBorder.none,
                  prefixIcon: widget.addPrefixIcon
                      ? SizedBox(
                          width: 50,
                          child: DropdownButton<String>(
                            value: widget.selectedCountryKey,
                            onChanged: (String? newValue) {
                              widget.isFromSignUp
                                  ? SignUpCubit.get(context)
                                      .setSelectedCountryKey = newValue!
                                  : EditProfileCubit.get(context)
                                      .setSelectedCountryKey = newValue!;
                            },
                            underline: const SizedBox(),
                            padding: EdgeInsets.zero,
                            icon: const SizedBox(),
                            elevation: 16,
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                value: 'JO',
                                child: Text('  +962 - '),
                              ),
                              DropdownMenuItem(
                                value: 'SA',
                                child: Text('  +966 - '),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(
                          width: 7,
                        ),
                  prefixIconConstraints: const BoxConstraints(minHeight: 10),
                  suffixIcon: widget.suffixIcon,
                  suffixIconConstraints: const BoxConstraints(minHeight: 10),
                  counterText: '',
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    fontFamily: Fonts.sourceSansPro,
                    fontSize: 12,
                  ),
                ),
                cursorColor: ColorManager.primaryColor,
                maxLength: widget.maxLength,
              ),
            ),
          ),
          (widget.controller.text.isEmpty || widget.doubleCheck) &&
                  widget.mustCheck
              ? Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    widget.errorText,
                    style: const TextStyle(fontSize: 8, color: Colors.red),
                  ),
                )
              : widget.mustCheck && widget.isWrongEmail
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        widget.errorText,
                        style: const TextStyle(fontSize: 8, color: Colors.red),
                      ),
                    )
                  : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class CardExpirationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != '/') valueToReturn += newValueString[i];
      var nonZeroIndex = i + 1;
      final contains = valueToReturn.contains(RegExp(r'\/'));
      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(contains)) {
        valueToReturn += '/';
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}
