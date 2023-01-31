import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/presentation/pages/home.dart';
import 'package:todo_app/presentation/pages/register.dart';
import 'package:todo_app/presentation/utils/custom_colors.dart';
import 'package:todo_app/presentation/widgets/custom_scaffold.dart';
import 'package:todo_app/presentation/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const SizedBox(height: 18),
          const Text(
            'С возвращением!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          SvgPicture.asset('assets/login_pic.svg'),
          const SizedBox(height: 33),
          Padding(
            padding: const EdgeInsets.only(left: 27.0, right: 23.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getEmailTextFormField(),
                  const SizedBox(height: 21.0),
                  _getPasswordTextFormField(),
                  const SizedBox(height: 12.0),
                  _getForgotPasswordButton(context),
                  const SizedBox(height: 12.0),
                  _getSignUpButton(context),
                ],
              ),
            ),
          ),
          const SizedBox(height: 23.0),
          GestureDetector(
            onTap: () async {
              Navigator.of(context).push(
                PageTransition(
                  child: const RegisterPage(),
                  alignment: Alignment.bottomCenter,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
            child: const Text.rich(
              TextSpan(
                text: 'Нет учетной записи? ',
                style: TextStyle(fontSize: 13),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Зарегистрироваться',
                    style: TextStyle(
                      color: CustomColors.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 34.0),
        ],
      ),
    );
  }

  Widget _getEmailTextFormField() {
    return CustomTextFormField(
      controller: emailController,
      validator: (val) => val == null || val.isEmpty ? 'Введите email' : null,
      hint: 'Введите email',
      textInputAction: TextInputAction.next,
    );
  }

  Widget _getPasswordTextFormField() {
    return CustomTextFormField(
      controller: passwordController,
      obscureText: true,
      hint: 'Введите пароль',
      textInputAction: TextInputAction.done,
      validator: (val) {
        return val != null && val.length < 6
            ? 'Длина пароля должна превышать\n6 символов'
            : null;
      },
    );
  }

  Widget _getForgotPasswordButton(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Забыли пароль?',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _getSignUpButton(BuildContext context) {
    return SizedBox(
      height: 62,
      width: 325,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.secondaryColor,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            Navigator.of(context).push(
              PageTransition(
                child: const HomePage(),
                alignment: Alignment.bottomCenter,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 300),
                reverseDuration: const Duration(milliseconds: 300),
                type: PageTransitionType.leftToRight,
              ),
            );
          }
        },
        child: const Text(
          'Войти',
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
