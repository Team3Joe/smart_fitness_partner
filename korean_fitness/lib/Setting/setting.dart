import 'package:flutter/material.dart';
import 'package:korean_fitness/main.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  // Property
  late bool darkModeSwitch;
  late String version;

  @override
  void initState() {
    super.initState();
    darkModeSwitch = false;
    version = '1.0.1';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          '설정',
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/Mainpage');
                },
                child: const Icon(Icons.home),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/Help');
                },
                child: Card(
                  // color: const Color.fromARGB(255, 164, 154, 239),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.circle,
                          // color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '도움말',
                          style: TextStyle(
                            fontSize: 20,
                            // color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (() {
                  Navigator.pushNamed(context, '/Customer_service');
                }),
                child: Card(
                  // color: const Color.fromARGB(255, 164, 154, 239),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.circle,
                          // color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '고객센터',
                          style: TextStyle(
                            fontSize: 20,
                            // color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                // color: const Color.fromARGB(255, 164, 154, 239),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.circle,
                        // color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '다크모드',
                        style: TextStyle(
                          fontSize: 20,
                          // color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 130,
                      ),
                      Switch(
                        value: darkModeSwitch,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        // activeColor: Colors.deepPurple,
                        onChanged: (value) {
                          setState(() {
                            darkModeSwitch = value;
                            if (MyApp.themeNotifier.value == ThemeMode.dark) {
                              MyApp.themeNotifier.value = ThemeMode.light;
                            } else {
                              MyApp.themeNotifier.value = ThemeMode.dark;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _versionCheck();
                },
                child: Card(
                  // color: const Color.fromARGB(255, 164, 154, 239),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.circle,
                          // color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '버전 확인',
                          style: TextStyle(
                            fontSize: 20,
                            // color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                   Navigator.pushNamed(context, '/Privacy_policy');
                },
                child: Card(
                  // color: const Color.fromARGB(255, 164, 154, 239),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.circle,
                          // color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '이용약관 & 개인정보 보호방침',
                          style: TextStyle(
                            fontSize: 20,
                            // color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Functions
  _versionCheck() {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text(
            'app 버전',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text('현재 버전은 $version입니다.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
