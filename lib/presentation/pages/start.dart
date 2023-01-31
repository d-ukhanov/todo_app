import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/presentation/pages/login.dart';
import 'package:todo_app/presentation/utils/custom_colors.dart';
import 'package:todo_app/presentation/widgets/custom_scaffold.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const SizedBox(height: 21),
          SvgPicture.asset('assets/start_pic.svg'),
          const SizedBox(height: 46),
          const Text(
            'Выполняйте задачи\nс помощью TODO',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          const Padding(
            padding: EdgeInsets.only(left: 51, right: 43),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Interdum dictum tempus, interdum at dignissim metus. Ultricies sed nunc.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 92),
          _getStartButton(context),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _getStartButton(BuildContext context) {
    return SizedBox(
      height: 62,
      width: 325,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.secondaryColor,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          Navigator.of(context).push(
            PageTransition(
              child: const LoginPage(),
              alignment: Alignment.bottomCenter,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              type: PageTransitionType.leftToRight,
            ),
          );
        },
        child: const Text(
          'Начать',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
