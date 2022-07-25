import 'package:flutter/material.dart';
import 'package:kipsy/core/themes/colors_manager.dart';
import 'package:kipsy/core/themes/theme_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.text,
      this.borderRadius,
      this.color,
      this.onTap,
      this.fontColor,
      this.borderColor,
      this.padding,
      this.radius,
      this.height,
      this.width})
      : super(key: key);

  final Color? color, borderColor, fontColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Function? onTap;
  final String? text;
  final double? radius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 50,
      child: RaisedButton(
        elevation: 0.0,
        highlightElevation: 0.0,
        color: color ??
            (ThemeManager.isDark(context)
                ? ColorManager.greyColor
                : ColorManager.white),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            side:
                BorderSide(color: borderColor ?? Colors.transparent, width: 2)),
        onPressed: () {
          onTap!.call();
        },
        child: Text(
          text ?? '',
          style: TextStyle(
              color: fontColor ??
                  (ThemeManager.isDark(context)
                      ? ColorManager.greyColor
                      : ColorManager.blue),
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class CustomButtonChildIcon extends StatelessWidget {
  const CustomButtonChildIcon(
      {Key? key,
      this.childIcon,
      this.borderRadius,
      this.color,
      this.onTap,
      this.fontColor,
      this.borderColor,
      this.padding,
      this.radius,
      this.height,
      this.width})
      : super(key: key);

  final Color? color, borderColor, fontColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Function? onTap;
  final Widget? childIcon;
  final double? radius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 50,
      child: RaisedButton(
        elevation: 0.0,
        highlightElevation: 0.0,
        color: color ??
            (ThemeManager.isDark(context)
                ? ColorManager.greyColor
                : ColorManager.white),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            side:
                BorderSide(color: borderColor ?? Colors.transparent, width: 2)),
        onPressed: () {
          onTap!.call();
        },
        child: childIcon,
      ),
    );
  }
}
