import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/home_book_trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';

selectPaymentMethodModal(
  HomeBookTripScreenController controller,
  Size size,
  ColorScheme colorScheme,
) {
  // return Obx(
  //   () {
  return AnimatedContainer(
    duration: Duration(milliseconds: 800),
    curve: Curves.easeIn,
    width: size.width,
    padding: const EdgeInsets.all(20),
    decoration: ShapeDecoration(
      color: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kLightGreyColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(Assets.paymentMethodIconSvg),
            ),
          ),
          20.toHeight,
          Text(
            "Choose your Payment Method",
            textAlign: TextAlign.center,
            style: defaultTextStyle(
              color: kTextBlackColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          10.toHeight,
          Text(
            "Set a comfortable Payment method to ease your ride everytime",
            textAlign: TextAlign.center,
            maxLines: 2,
            style: defaultTextStyle(
              color: kTextGreyColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          20.toHeight,
          ListTile(
            onTap: () {},
            leading: SvgPicture.asset(Assets.cashIconSvg),
            enableFeedback: true,
            dense: true,
            minTileHeight: 40,
            title: Text(
              "Cash",
              textAlign: TextAlign.start,
              maxLines: 2,
              style: defaultTextStyle(
                color: kTextGreyColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(Icons.chevron_right, color: kGreyColor),
          ),
          Divider(
            thickness: .5,
            color: kGreyColor,
            height: 0,
            indent: 16,
            endIndent: 28,
          ),
          ListTile(
            onTap: () {},
            leading: SvgPicture.asset(Assets.walletIconSvg),
            enableFeedback: true,
            dense: true,
            minTileHeight: 40,
            title: Text(
              "Wallet",
              textAlign: TextAlign.start,
              maxLines: 2,
              style: defaultTextStyle(
                color: kTextGreyColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Icon(Icons.chevron_right, color: kGreyColor),
          ),
          Divider(
            thickness: .5,
            color: kGreyColor,
            height: 0,
            indent: 16,
            endIndent: 28,
          ),
        ],
      ),
    ),
    //   );
    // },
  );
}
