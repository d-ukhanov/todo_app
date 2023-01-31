import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/presentation/pages/home.dart';
import 'package:todo_app/presentation/pages/login.dart';
import 'package:todo_app/presentation/utils/custom_colors.dart';
import 'package:todo_app/presentation/widgets/custom_scaffold.dart';
import 'package:todo_app/presentation/widgets/custom_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const SizedBox(height: 41),
          const Text(
            'Добро пожаловать!',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 14),
          const Text(
            'Давайте справимся с вашими задачами',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 49),
          Padding(
            padding: const EdgeInsets.only(left: 27.0, right: 23.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  _getNameTextFormField(),
                  const SizedBox(height: 21.0),
                  _getEmailTextFormField(),
                  const SizedBox(height: 21.0),
                  _getPasswordTextFormField(),
                  const SizedBox(height: 21.0),
                  _getConfirmPasswordTextFormField(),
                  const SizedBox(height: 50.0),
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
                  child: const LoginPage(),
                  alignment: Alignment.bottomCenter,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  type: PageTransitionType.leftToRight,
                ),
              );
            },
            child: const Text.rich(
              TextSpan(
                text: 'Уже есть учетная запись? ',
                style: TextStyle(fontSize: 13),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Войти',
                    style: TextStyle(
                      color: CustomColors.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 58.0),
        ],
      ),
    );
  }

  Widget _getNameTextFormField() {
    return CustomTextFormField(
      controller: nameController,
      validator: (val) => val == null || val.isEmpty ? 'Введите имя' : null,
      hint: 'Введите имя',
      textInputAction: TextInputAction.next,
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
      textInputAction: TextInputAction.next,
      validator: (val) {
        return val != null && val.length < 6
            ? 'Длина пароля должна превышать\n6 символов'
            : null;
      },
    );
  }

  Widget _getConfirmPasswordTextFormField() {
    return CustomTextFormField(
      controller: confirmPasswordController,
      obscureText: true,
      hint: 'Подтвердите пароль',
      textInputAction: TextInputAction.send,
      validator: (val) {
        return val != null && val != passwordController.text
            ? 'Пароли не совпадают'
            : null;
      },
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
          'Зарегистрироваться',
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
