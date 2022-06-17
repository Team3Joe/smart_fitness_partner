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
        title: Text(
          '설정',
          style: TextStyle(
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(3, 3),
                    blurRadius:10
                  )
                ]
              ),
        ),
        backgroundColor: Color.fromARGB(166, 69, 53, 116),
        toolbarHeight: 75,
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
      body: Container(
        color: Color.fromARGB(140, 103, 91, 141),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/Help');
                  },
                  child: SizedBox(
                    width: 350,
                    height: 70,
                    child: Card(
                      color: Color.fromARGB(60, 159, 145, 203),
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
                              width: 20,
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
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: (() {
                    Navigator.pushNamed(context, '/Customer_service');
                  }),
                  child: SizedBox(
                    width: 350,
                    height: 70,
                    child: Card(
                      color: Color.fromARGB(60, 159, 145, 203),
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
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 350,
                  height: 70,
                  child: Card(
                    color: Color.fromARGB(60, 159, 145, 203),
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
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    _versionCheck();
                  },
                  child: SizedBox(
                    width: 350,
                    height: 70,
                    child: Card(
                      color: Color.fromARGB(60, 159, 145, 203),
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
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                     Navigator.pushNamed(context, '/Privacy_policy');
                  },
                  child: SizedBox(
                    width: 350,
                    height: 70,
                    child: Card(
                      color: Color.fromARGB(60, 159, 145, 203),
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
                ),
              ],
            ),
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
