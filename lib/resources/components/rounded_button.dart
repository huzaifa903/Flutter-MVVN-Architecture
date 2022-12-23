import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/resources/colors.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundedButton({
    Key? key,
    required this.title,
    this.loading = false,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width / 1.5,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          primary: AppColor.blackColor,
        ),
        child: loading ? const CircularProgressIndicator() : Text(title),
      ),
    );
  }
}
