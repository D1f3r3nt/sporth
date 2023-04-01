import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';

class PopButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const PopButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.keyboard_arrow_left_sharp,
                color: ColorsUtils.black,
              ),
              Text(
                text,
                style: TextUtils.kanit_18_black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
