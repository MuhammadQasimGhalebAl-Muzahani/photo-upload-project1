import 'package:flutter/material.dart';
import '../app_style.dart';
import '../size_config.dart';

class OnBoardNavBTN extends StatelessWidget {
  const OnBoardNavBTN({
    Key? key,
    required this.name,
    required this.onPressed,
    required this.bgColor,
  }) : super(key: key);
  final String name;
  final VoidCallback onPressed;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      splashColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          height: SizeConfig.blocksSizeH! * 10.8,
          width: SizeConfig.blocksSizeH! * 25,
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              name,
              style: KBodyTextButton,
            ),
            style: TextButton.styleFrom(
              backgroundColor: bgColor,
            ),
          ),
        ),
      ),
    );
  }
}
