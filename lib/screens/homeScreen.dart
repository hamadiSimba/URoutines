import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:uroutines/model/assignments.dart';
import 'package:uroutines/model/user.dart';
import 'package:uroutines/screens/addAssignment.dart';
import 'package:uroutines/screens/addModulesScreen.dart';
import 'package:uroutines/screens/addSessionScreen.dart';
import 'package:uroutines/screens/assignmentsScreen.dart';
import 'package:uroutines/screens/registeredCourses.dart';
import 'package:uroutines/screens/userUpdate.dart';
import 'package:uroutines/widgets/header.dart';
import 'package:flutter/material.dart';
import '../model/modules.dart';
import '../model/sessions.dart';
import '../services/notification.dart';
import '../utility/db.dart';
import '../widgets/cardUse.dart';
import '../widgets/recentAssignments.dart';
import '../widgets/recentsAlerts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotifyHelper _notifyHelper = NotifyHelper();
  UserDetails existingUser = UserDetails();
  String userName = "No User Name";
  String userReg = "No registration";
  int numCourses = 0;
  int num2Day = 0;
  int numAssignments = 0;
  DateTime today = DateTime.now();

  //Side Button.
  bool isClicked = false;
  double button = 450;
  double box = 480;

  late double newHeight;

  double tops = 950;
  double lefts = 380;

  @override
  void initState() {
    _fetchUser();
    super.initState();
    _notifyHelper.initializeNotification();
  }

  _fetchUser() async {
    List<UserDetails> xUser = await DbHelper.userQuery();
    List<Modules> x = await DbHelper.courseQuery();
    List<Assignments> assignNums = await DbHelper.allAssignmentQuery();
    List<Sessions> toDaySess =
        await DbHelper.sessionsQuery(DateFormat.E().format(today));

    try {
      setState(() {
        existingUser = xUser.first;
        userName = existingUser.fullName!;
        userReg = existingUser.regNumber!;
        numCourses = x.length;
        num2Day = toDaySess.length;
        numAssignments = assignNums.length;
      });
    } catch (e) {
      print("User retrival error!");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (isClicked == false) {
      button = MediaQuery.of(context).size.width * 0.92;
      box = MediaQuery.of(context).size.width * 1;
      newHeight = MediaQuery.of(context).size.width * 0;
    }
    return Stack(
      children: [
        ListView(
          children: [
            const Header(),
            Container(
              height: size.height * 0.2,
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(left: 28.0, right: 28.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 3.0,
                      spreadRadius: 0.5,
                      offset: Offset(0, 1),
                    ),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                  child: Text(
                                userName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              )),
                              FittedBox(
                                  child: Text(
                                userReg,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              )),
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UserIpdate()));
                              },
                              child: const Text("Update Profile")),
                        ],
                      ),
                    ),
                    Container(
                      height: 1.0,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FittedBox(
                          child: CardColumn(
                            count: numCourses.toString(),
                            title: "All Courses",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const RegisteredCourses())));
                            },
                          ),
                        ),
                        Container(
                          width: 1.0,
                          height: size.height * 0.04,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        FittedBox(
                          child: CardColumn(
                            count: num2Day.toString(),
                            title: "Today's Sessions",
                            onTap: () {},
                          ),
                        ),
                        Container(
                          width: 1.0,
                          height: 42.0,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        FittedBox(
                          child: CardColumn(
                            count: numAssignments.toString(),
                            title: "Assignments",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const AllAssignment())));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 1.0,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${existingUser.college}, ${existingUser.institute}",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(
                            width: 32.0,
                          ),
                          Text(
                            "${existingUser.program} ${existingUser.academicYear}",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(35.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recent Alerts",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const RecentsAlerts(),
                  Center(
                      child: Text(
                    "View All",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 15.0,
                    ),
                  )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "Recent Assignments",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const RecentAssignments(),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const AllAssignment())));
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        AnimatedPositioned(
          curve: Curves.bounceOut,
          duration: const Duration(milliseconds: 400),
          top: size.height * 0.55,
          left: button,
          child: GestureDetector(
            onTap: () {
              print(
                  "Screen Width is ${size.width} and Height is ${size.height}");
              if (isClicked == false) {
                setState(() {
                  isClicked = true;
                  button = size.width * 0.78;
                  box = size.width * 0.85;
                  // newHeight = size.height * 1;
                });
              } else {
                setState(() {
                  isClicked = false;
                  button = size.width * 0.92;
                  box = size.width * 1;
                });
              }
            },
            child: AnimatedContainer(
              height: 70.0,
              width: 50,
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                  color: isClicked
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.blueGrey,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 3.0,
                      spreadRadius: 0.5,
                      offset: Offset(-1, 1),
                    ),
                  ]),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  isClicked
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_left,
                  size: 36,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          curve: Curves.bounceOut,
          duration: const Duration(milliseconds: 400),
          top: size.height * 0.43,
          left: box,
          child: AnimatedContainer(
            transformAlignment: FractionalOffset.center,
            padding: EdgeInsets.only(left: size.height * 0.01),
            height: size.height * 0.3,
            width: 70,
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
                color: isClicked
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.blueGrey,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 3.0,
                    spreadRadius: 0.5,
                    offset: Offset(-1, -1),
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SiseButton(
                  icon: CupertinoIcons.book,
                  title: "Courses",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddModules()),
                    );
                    setState(() {
                      isClicked = false;
                      button = size.width * 0.92;
                      box = size.width * 1;
                    });
                  },
                ),
                SiseButton(
                  icon: CupertinoIcons.pen,
                  title: "Sessions",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddSession()),
                    );
                    setState(() {
                      isClicked = false;
                      button = size.width * 0.92;
                      box = size.width * 1;
                    });
                  },
                ),
                SiseButton(
                  icon: CupertinoIcons.person_crop_circle_badge_checkmark,
                  title: "Exams",
                  onPress: () {},
                ),
                SiseButton(
                  icon: CupertinoIcons.device_laptop,
                  title: "Works",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddAssignments()),
                    );
                    setState(() {
                      isClicked = false;
                      button = size.width * 0.92;
                      box = size.width * 1;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          height: newHeight,
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.95),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        AnimatedContainer(
          curve: Curves.bounceOut,
          height: newHeight,
          duration: const Duration(milliseconds: 1000),
          margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 3.0,
                  spreadRadius: 0.5,
                  offset: Offset(-1, 1),
                ),
              ]),
        ),
        AnimatedPositioned(
          curve: Curves.bounceOut,
          duration: const Duration(milliseconds: 400),
          top: size.height * 0.55,
          left: button,
          child: GestureDetector(
            onTap: () {
              print(
                  "Screen Width is ${size.width} and Height is ${size.height}");
              if (isClicked == false) {
                setState(() {
                  isClicked = true;
                  button = size.width * 0.78;
                  box = size.width * 0.85;
                  // newHeight = size.height * 1;
                });
              } else {
                setState(() {
                  isClicked = false;
                  button = size.width * 0.92;
                  box = size.width * 1;
                });
              }
            },
            child: AnimatedContainer(
              height: 70.0,
              width: size.width * 0.07,
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: isClicked
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.blueGrey,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16)),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  isClicked
                      ? Icons.keyboard_arrow_right
                      : Icons.keyboard_arrow_left,
                  size: 36,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SiseButton extends StatelessWidget {
  final onPress;
  final String title;
  final IconData icon;

  const SiseButton(
      {required this.title, required this.icon, this.onPress, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPress,
      child: Column(
        children: [
          Container(
            height: size.height * 0.04,
            width: size.width * 0.1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 36,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          FittedBox(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }
}
