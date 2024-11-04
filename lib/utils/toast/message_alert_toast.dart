import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/theme/colors.dart';

class MessageAlertToast extends StatelessWidget {
  final String title, message;
  final Color? titleColor;
  final Color? subtitleColor;
  final Widget leading;
  const MessageAlertToast({
    super.key,
    required this.title,
    required this.message,
    required this.leading,
    required this.titleColor,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return ToastCard(
      color: colorScheme.surface,
      leading: leading,
      title: Text(
        title,
        style: defaultTextStyle(
          fontWeight: FontWeight.w900,
          color: titleColor,
          fontSize: 16,
          letterSpacing: -1.0,
        ),
      ),
      subtitle: Text(
        message,
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
        style: defaultTextStyle(
          fontWeight: FontWeight.w800,
          color: subtitleColor ?? kTextBoldHeadingColor,
          fontSize: 12,
          letterSpacing: -1.0,
        ),
      ),
    );
  }
}
