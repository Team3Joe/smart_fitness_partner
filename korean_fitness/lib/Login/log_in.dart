import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:korean_fitness/Main/splashscreen.dart';
import 'package:korean_fitness/message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
    GoogleSignInAccount? _currentUser;
  String _contactText = '';
  // Property
  late TextEditingController idController;
  late TextEditingController pwController;
  late String id;
  late String pw;
  late int uq; //user탈퇴여부

  late List data;

  @override
  void initState() {
    super.initState();

      _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async{
      setState(() {
        _currentUser = account;
        
      });
            final GoogleSignInAccount? user = _currentUser;
                    if(user != null){
                   // print(user.displayName);
                   // print(user.email);
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setString('id', user.email.toString());
                  sharedPreferences.setString('name', user.displayName.toString());
                  Get.to(SplashPage());
                    }
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
        
      }
    });
    _googleSignIn.signInSilently();
    

    idController = TextEditingController();
    pwController = TextEditingController();
    id = '';
    pw = '';
    uq = 0;
    data = [];
  }

    Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
      

   
    });
  }
  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

   Future<void> _handleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
   
  
    } catch (error) {
      print(error);
    }

      
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(240, 255, 255, 255),
          image: DecorationImage(
            image: AssetImage(
              "images/fitnesscenter4.png"
            ), 
            fit: BoxFit.fill,
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 50,
                    color: Color.fromARGB(255, 47, 40, 100),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                      child: TextField(
                        controller: idController,
                        decoration: const InputDecoration(
                          labelText: 'ID | ',
                          hintText: 'ID를 입력하세요(Enter your ID)',
                          filled: true,
                          fillColor: Color.fromARGB(225, 255, 255, 255),
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 69, 41, 152),
                          ),
                          hintStyle: TextStyle(
                           color: Color.fromARGB(159, 101, 71, 191),
                           fontSize: 14
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(width: 2.5, color: Color.fromARGB(255, 61, 51, 133)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 91, 80, 177)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        cursorColor: const Color.fromARGB(255, 164, 154, 239),
                        onChanged: (value) {
                          //
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                      child: TextField(
                        controller: pwController,
                        decoration: const InputDecoration(
                          labelText: 'PW | ',
                          hintText: 'PW를 입력하세요(Enter your PW)',
                          filled: true,
                          fillColor: Color.fromARGB(220, 255, 255, 255),
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 69, 41, 152),
                          ),
                          hintStyle: TextStyle(
                           color: Color.fromARGB(159, 101, 71, 191),
                           fontSize: 14
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(width: 2.5, color: Color.fromARGB(255, 61, 51, 133)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 91, 80, 177)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        cursorColor: const Color.fromARGB(255, 164, 154, 239),
                        onChanged: (value) {
                          //
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 102, 90, 190),
                        minimumSize: const Size(100, 46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (idController.text.trim().isEmpty) {
                          emptyID(context);
                        } else if (pwController.text.trim().isEmpty) {
                          emptyPW(context);
                        } else {
                          setState(() {
                            id = idController.text.trim();
                            pw = pwController.text.trim();
                          });
                          _getJSONData()
                              .then((value) => logInCheck(context)); // data 오류
                        }
                      },
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                          color: Color.fromARGB(255, 226, 207, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '아직 회원이 아니신가요?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 23, 0, 60),
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        SizedBox(
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Sign_up');
                            },
                            child: const Text(
                              '회원가입 하기',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Find_id');
                            },
                            child: const Text(
                              '아이디 찾기',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Find_pw');
                            },
                            child: const Text(
                              '비밀번호 찾기',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    _handleSignIn(context); //Google-Log-In
                    // _handleSignOut();//Google-Log-Out
                

                  },
                  child: Image.asset(
                    "images/google-signin-button.png",
                    width: 450,
                    height: 65,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Functions
  emptyID(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ID를 입력하세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  emptyPW(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PW를 입력하세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  logInCheck(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          if (data.isEmpty) {
            return AlertDialog(
              title: const Text(
                '로그인 실패!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: const Text('ID와 PW를 확인해주세요.'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            );
          } else if (uq == 1) {
            return AlertDialog(
              title: const Text(
                '로그인 실패!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: const Text('탈퇴된 계정입니다.'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            );
          } else {
            return AlertDialog(
              title: const Text(
                '로그인 성공!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: const Text('로그인에 성공하였습니다.'),
              actions: [
                ElevatedButton(
                    onPressed: () async{
                      Message.uId = data[0]['uId'];
                      Message.uPw = data[0]['uPw'];
                      Message.uName = data[0]['uName'];
                      Message.uBirth = data[0]['uBirth'];
                      Message.uEmail = data[0]['uEmail'];
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString( 'id', idController.text.trim());
                      sharedPreferences.setString( 'name', data[0]['uName']);
                      sharedPreferences.setString( 'email', data[0]['uEmail']);
                      Get.to(SplashPage());
                      //Navigator.popAndPushNamed(context, '/Mainpage');
                    },
                    child: const Text('OK'))
              ],
            );
          }
        });
  }

  Future<bool> _getJSONData() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/fitness/user_select.jsp?id=$id&pw=$pw');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    List result = dataConvertedJSON['results'];
    setState(() {
      data = [];
      data.addAll(result);
    });
    if (data.isEmpty) {
      //없는 계정입력시
      return true;
    } else {
      var userquite = data[0]['uQuit']; //탈퇴여부 값 받아오기
      uq = userquite;
      return true;
    }
  }
}//end


