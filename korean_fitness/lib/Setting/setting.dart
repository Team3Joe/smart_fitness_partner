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
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, shadows: [
            Shadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(3, 3),
                blurRadius: 10)
          ]),
        ),
        backgroundColor: Color.fromARGB(180, 58, 34, 131),
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
        color: Color.fromARGB(63, 150, 131, 213),
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
                      color: const Color.fromARGB(134, 182, 167, 239),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.circle,
                              size: 13,
                              // color: Color.fromARGB(186, 30, 22, 56),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              '도움말',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                //color: Color.fromARGB(174, 17, 1, 65),
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
                  height: 20,
                ),
                GestureDetector(
                  onTap: (() {
                    Navigator.pushNamed(context, '/Customer_service');
                  }),
                  child: SizedBox(
                    width: 350,
                    height: 70,
                    child: Card(
                      color: const Color.fromARGB(134, 182, 167, 239),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.circle,
                              size: 13,
                              // color: Color.fromARGB(186, 30, 22, 56),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              '고객센터',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                //color: Color.fromARGB(174, 17, 1, 65),
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
                  height: 20,
                ),
                SizedBox(
                  width: 350,
                  height: 70,
                  child: Card(
                    color: const Color.fromARGB(134, 182, 167, 239),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                              Icons.circle,
                              size: 13,
                              // color: Color.fromARGB(186, 30, 22, 56),
                            ),
                          const SizedBox(
                            width: 30,
                          ),
                          const Text(
                            '다크모드',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              //color: Color.fromARGB(174, 17, 1, 65),
                              // color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          Switch(
                            value: darkModeSwitch,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            // activeColor: Colors.deepPurple,
                            onChanged: (value) {
                              setState(() {
                                darkModeSwitch = value;
                                if (MyApp.themeNotifier.value ==
                                    ThemeMode.dark) {
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
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _versionCheck();
                  },
                  child: SizedBox(
                    width: 350,
                    height: 70,
                    child: Card(
                      color: const Color.fromARGB(134, 182, 167, 239),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.circle,
                              size: 13,
                              // color: Color.fromARGB(186, 30, 22, 56),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              '버전 확인',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                //color: Color.fromARGB(174, 17, 1, 65),
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
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/Privacy_policy');
                  },
                  child: SizedBox(
                    width: 350,
                    height: 70,
                    child: Card(
                      color: const Color.fromARGB(134, 182, 167, 239),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.circle,
                              size: 13,
                              // color: Color.fromARGB(186, 30, 22, 56),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              '이용약관 & 개인정보 보호방침',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                //color: Color.fromARGB(195, 27, 18, 52),
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
