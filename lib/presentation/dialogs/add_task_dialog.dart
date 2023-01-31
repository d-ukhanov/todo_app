import 'package:flutter/material.dart';
import 'package:todo_app/presentation/utils/custom_colors.dart';
import 'package:todo_app/presentation/widgets/custom_text_form_field.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(String task) addTask;

  const AddTaskDialog({
    super.key,
    required this.addTask,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController taskController;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    taskController = TextEditingController();
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: CustomColors.backgroundColor,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22.0,
            vertical: 6.0,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getTaskField(),
                const SizedBox(height: 24.0),
                _getAddTaskButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getTaskField() {
    return CustomTextFormField(
      controller: taskController,
      hint: 'Введите задачу',
      textInputAction: TextInputAction.done,
      height: 90,
      maxLines: 3,
      validator: (val) {
        return val != null ? 'Пустое поле' : null;
      },
    );
  }

  Widget _getAddTaskButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.secondaryColor,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            widget.addTask(taskController.text);

            Navigator.pop(context);
          }
        },
        child: const Text(
          'Поставить задачу',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
