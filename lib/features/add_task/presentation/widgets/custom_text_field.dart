import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.maxLines,
      this.textInputAction,
      this.title,
      this.keyboardType,
      this.maxLength,
      this.inputFormatter,
      this.childButton})
      : super(key: key);
  final TextEditingController? controller;
  final String? hintText, title;
  final TextInputType? keyboardType;
  final int? maxLength, maxLines;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? childButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                title ?? '',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ThemeManager.isDark(context)
                        ? ColorManager.lightGrey
                        : ColorManager.blue,
                    fontWeight: FontWeight.w700),
              ),
              const Expanded(
                child: Divider(
                  indent: 12,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: controller,
                  cursorColor: ThemeManager.isDark(context)
                      ? ColorManager.lightGrey2
                      : ColorManager.blue,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  maxLines: maxLines,
                  textInputAction: textInputAction,
                  inputFormatters: inputFormatter,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      border: inputBorder,
                      enabledBorder: inputBorder,
                      focusedBorder: inputBorder,
                      hintText: hintText,
                      hintStyle: const TextStyle(
                          color: ColorManager.lightGrey2,
                          fontWeight: FontWeight.w400),
                      counterText: ''),
                ),
              ),
              (childButton != null)
                  ? const SizedBox(
                      width: 20,
                    )
                  : Container(),
              (childButton != null)
                  ? Expanded(
                      child: childButton ?? Container(),
                      flex: 1,
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  InputBorder get inputBorder => const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: ColorManager.lightGrey));
}
