import 'package:flutter/material.dart';
import 'package:musync/config/constants/colors/app_colors.dart';

class GlobalConstants {
  static const Size tabletSize = Size(600, 1024);

  static textStyle({
    family = 'Sans',
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w400,
    Color? color = AppDarkColor.onBackground,
  }) {
    return TextStyle(
      fontFamily: family,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}

class AppIcons {
  static const String logo = 'assets/icons/logo.svg';
  static const String filter = 'assets/icons/filter.svg';
  static const String burger = 'assets/icons/burger.svg';
  static const String cross = 'assets/icons/cross.svg';
  static const String more = 'assets/icons/more.svg';
  static const String queue = 'assets/icons/queue.svg';
  static const String recent = 'assets/icons/recent.svg';
  static const String share = 'assets/icons/share.svg';
  static const String shuffle = 'assets/icons/shuffle.svg';
  static const String pause = 'assets/icons/pasue.svg';
  //
  static const String addFilled = 'assets/icons/add-filled.svg';
  static const String addOutlined = 'assets/icons/add-outlined.svg';
  static const String addQueueFilled = 'assets/icons/add-queue-filled.svg';
  static const String addQueueOutlined = 'assets/icons/add-queue-outlined.svg';
  static const String albumFilled = 'assets/icons/album-filled.svg';
  static const String albumOutlined = 'assets/icons/album-outlined.svg';
  static const String arrowDown = 'assets/icons/arrow-down.svg';
  static const String arrowLeft = 'assets/icons/arrow-left.svg';
  static const String arrowRight = 'assets/icons/arrow-right.svg';
  static const String arrowUp = 'assets/icons/arrow-up.svg';
  static const String artistFilled = 'assets/icons/artist-filled.svg';
  static const String artistOutlined = 'assets/icons/artist-outlined.svg';
  static const String curvedArrowDown = 'assets/icons/curved-arrow-down.svg';
  static const String curvedArrowLeft = 'assets/icons/curved-arrow-left.svg';
  static const String curvedArrowRight = 'assets/icons/curved-arrow-right.svg';
  static const String curvedArrowUp = 'assets/icons/curved-arrow-up.svg';
  static const String deleteFilled = 'assets/icons/delete-filled.svg';
  static const String deleteOutlined = 'assets/icons/delete-outlined.svg';
  static const String emailFilled = 'assets/icons/email-filled.svg';
  static const String emailOutlined = 'assets/icons/email-outlined.svg';
  static const String eyeOff = 'assets/icons/eye-off.svg';
  static const String eyeOn = 'assets/icons/eye-on.svg';
  static const String globeFilled = 'assets/icons/globe-filled.svg';
  static const String globeOutlined = 'assets/icons/globe-outlined.svg';
  static const String heartFilled = 'assets/icons/heart-filled.svg';
  static const String heartOutlined = 'assets/icons/heart-outlined.svg';
  static const String homeFilled = 'assets/icons/home-filled.svg';
  static const String homeOutlined = 'assets/icons/home-outlined.svg';
  static const String infoFilled = 'assets/icons/info-filled.svg';
  static const String infoOutlined = 'assets/icons/info-outlined.svg';
  static const String libraryFilled = 'assets/icons/library-filled.svg';
  static const String libraryOutlined = 'assets/icons/library-outlined.svg';
  static const String lockFilled = 'assets/icons/lock-filled.svg';
  static const String lockOutlined = 'assets/icons/lock-outlined.svg';
  static const String musicFolderFilled =
      'assets/icons/music-folder-filled.svg';
  static const String musicFolderOutlined =
      'assets/icons/music-folder-outlined.svg';
  static const String nextFilled = 'assets/icons/next-filled.svg';
  static const String nextOutlined = 'assets/icons/next-outlined.svg';
  static const String playFilled = 'assets/icons/play-filled.svg';
  static const String playOutlined = 'assets/icons/play-outlined.svg';
  static const String previousFilled = 'assets/icons/previous-filled.svg';
  static const String previousOutlined = 'assets/icons/previous-outlined.svg';
  static const String repeatAll = 'assets/icons/repeat-all.svg';
  static const String repeatOne = 'assets/icons/repeat-one.svg';
  static const String userFilled = 'assets/icons/user-filled.svg';
  static const String userOutlined = 'assets/icons/user-outlined.svg';
}
