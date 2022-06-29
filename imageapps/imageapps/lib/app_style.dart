// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import './size_config.dart';

Color KPrimaryColor = Color(0xFF5119DF);
Color KSecondaryColor = Color(0xFF515050);
Color KTextButtonsColor = Color(0xFFFFFFFF);

final KBodyText1 = TextStyle(
  color: KSecondaryColor,
  fontSize: SizeConfig.blocksSizeH! * 5.5,
  // fontWeight: FontWeight.bold,
);

final KBodyTextButton = TextStyle(
  color: KTextButtonsColor,
  backgroundColor: KPrimaryColor,
  fontSize: SizeConfig.blocksSizeH! * 5,
  fontWeight: FontWeight.w600,
);
