import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/presentation/dialogs/add_task_dialog.dart';
import 'package:todo_app/presentation/utils/custom_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int hour;
  late String msg;
  late List<String> tasks;
  List<String> completedTasks = [];

  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    hour = DateTime.now().hour;

    if (hour < 5) {
      msg = 'Доброй ночи';
    } else if (hour < 12) {
      msg = 'Доброе утро';
    } else if (hour < 16) {
      msg = 'Добрый день';
    } else {
      msg = 'Добрый вечер';
    }

    tasks = [
      'Приготовить завтрак в 9 утра',
      'Дочитать книгу до 12 часов',
      'Пообедать в 13 часов',
      'Сходить за продуктами в 15',
      'Поужинать в 8 вечера',
    ];

    scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _getUserAvatarContainer(),
                SvgPicture.asset('assets/shape.svg'),
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset('assets/ellipse.svg'),
                ),
              ],
            ),
            const SizedBox(height: 26),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 33),
                child: Text(
                  msg,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.75)),
                ),
              ),
            ),
            const SizedBox(height: 2),
            _getClockWidget(),
            const SizedBox(height: 19),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Text(
                  'Список задач',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.75),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _getTaskContainer(),
          ],
        ),
      ),
    );
  }

  Widget _getUserAvatarContainer() {
    return Container(
      height: 264,
      color: CustomColors.secondaryColor,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 27),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/user_icon.png'),
              const SizedBox(height: 13),
              const Text(
                'Здравствуйте, UserName',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getClockWidget() {
    return AnalogClock(
      decoration: const BoxDecoration(
        color: Color(0xFFF5EFEF),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(0, 4), // Shadow position
          ),
        ],
      ),
      width: 120.0,
      height: 120,
      isLive: true,
      numberColor: const Color(0xFF332A6C).withOpacity(0.75),
      showNumbers: true,
      showAllNumbers: false,
      textScaleFactor: 1.6,
      showSecondHand: true,
      secondHandColor: const Color(0xFFC1C0C0),
      minuteHandColor: CustomColors.secondaryColor,
      hourHandColor: CustomColors.secondaryColor,
      showTicks: false,
      showDigitalClock: false,
      datetime: DateTime.now(),
    );
  }

  Widget _getTaskContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26, bottom: 50),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 15,
              offset: Offset(0, 4), // Shadow position
            ),
          ],
        ),
        child: StatefulBuilder(builder: (context, setTaskListState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 19),
                  child: IconButton(
                    onPressed: () async {
                      await _showAddTaskDialog(context, setTaskListState);
                    },
                    icon: SvgPicture.asset('assets/plus_circle.svg'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Text(
                  'Список задач',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black.withOpacity(0.75),
                  ),
                ),
              ),
              const SizedBox(height: 29),
              _getTaskListView(),
            ],
          );
        }),
      ),
    );
  }

  Widget _getTaskListView() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: ListView(
            padding: EdgeInsets.zero,
            controller: scrollController,
            children: tasks.map((task) => _getTaskTile(task)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _getTaskTile(String task) {
    return StatefulBuilder(builder: (context, setTileState) {
      return CheckboxListTile(
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
        value: completedTasks.contains(task),
        checkColor: CustomColors.secondaryColor,
        activeColor: CustomColors.secondaryColor,
        title: Text(
          task,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black.withOpacity(0.75),
          ),
        ),
        onChanged: (value) {
          if (value == true) {
            setTileState(() => completedTasks.add(task));
          } else {
            setTileState(() => completedTasks.remove(task));
          }
        },
      );
    });
  }

  Future<void> _showAddTaskDialog(
    BuildContext context,
    StateSetter setTaskListState,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AddTaskDialog(
        addTask: (task) => setTaskListState(() => tasks.add(task)),
      ),
    );
  }
}
