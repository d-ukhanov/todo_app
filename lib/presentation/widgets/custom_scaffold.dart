import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/presentation/utils/custom_colors.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  const CustomScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SvgPicture.asset('assets/shape.svg'),
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset('assets/ellipse.svg'),
                ),
              ],
            ),
            body,
          ],
        ),
      ),
    );
  }
}
