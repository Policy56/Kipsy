import 'package:flutter/material.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';

class CustomDropDown<T> extends StatefulWidget {
  CustomDropDown(
      {Key? key,
      required this.listOfElement,
      this.hintText,
      this.title,
      this.childButton,
      this.dropdownValue})
      : super(key: key);
  final String? hintText, title;
  final Widget? childButton;
  List<T> listOfElement;

  T? dropdownValue;

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
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
                widget.title ?? '',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
              // TODO(ccl): type de List en param T
              Expanded(
                flex: 6,
                child: DropdownButtonFormField<T>(
                  value: widget.dropdownValue,
                  dropdownColor: ThemeManager.isDark(context)
                      ? ColorManager.greyColor
                      : ColorManager.lightGrey2,
                  items: widget.listOfElement
                      .map((label) => DropdownMenuItem(
                            child: Text(label.toString()),
                            value: label,
                          ))
                      .toList(),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      border: inputBorder,
                      enabledBorder: inputBorder,
                      focusedBorder: inputBorder,
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(
                          color: ColorManager.lightGrey2,
                          fontWeight: FontWeight.w400),
                      counterText: ''),
                  onChanged: (T? newValue) {
                    setState(() {
                      widget.dropdownValue = newValue;
                    });
                  },
                ),
              ),
              (widget.childButton != null)
                  ? const SizedBox(
                      width: 20,
                    )
                  : Container(),
              (widget.childButton != null)
                  ? Expanded(
                      child: widget.childButton ?? Container(),
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
