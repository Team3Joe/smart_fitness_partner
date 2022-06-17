import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '도움말 & 사용설명서',
          style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 23,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(3, 3),
                    blurRadius:10
                  )
                ]
              ),
          ),
        backgroundColor: Color.fromARGB(198, 58, 34, 131),
        toolbarHeight: 75,
      ),
    );
  }
}
