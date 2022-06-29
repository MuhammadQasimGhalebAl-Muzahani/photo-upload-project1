import 'package:flutter/material.dart';
import '../app_style.dart';
import '../size_config.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
    required this.bgColor,
  }) : super(key: key);

  final String buttonName;
  final VoidCallback onPressed;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SizedBox(
        height: SizeConfig.blocksSizeH! * 15.5,
        width: SizeConfig.blocksSizeH! * 70,
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonName,
            style: KBodyTextButton,
          ),
          style: TextButton.styleFrom(
            backgroundColor: bgColor,
          ),
        ),
      ),
    );
  }
}
