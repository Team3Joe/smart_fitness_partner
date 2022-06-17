import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '이용약관 & 개인정보처리방침',
          style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 21,
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
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                children: const [
                  Text(
                    "제1조 목적\n",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      " 본 회원약관은 3조(이하 '갑'이라 한다)이 운영하는 인터넷관련 서비스(이하 '서비스'라 한다)를 이용함에 있어 관리자와 이용자(이하 '회원'이라 한다)의 권리, 의무 및 책임사항을 규정함을 목적으로 한다.\n"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "제2조 약관의 효력\n",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      "1.본 약관은 '갑'에 회원 가입 시 회원들에게 통지함으로써 효력을 발생합니다.\n2.'갑'은 이 약관의 내용을 변경할 수 있으며, 변경된 약관은 제1항과 같은 방법으로 공지 또는 통지함으로써 효력을 발생합니다.\n3.약관의 변경사항 및 내용은 '갑'의 홈페이지에 게시하는 방법으로 공시합니다.\n"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "제3조 약관 이외의 준칙\n",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      " 이 약관에 명시되지 않은 사항이 전기 통신 기본법, 전기통신 사업법, 기타 관련 법령에 규정되어 있는 경우 그 규정에 따릅니다.\n"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "제4조 이용계약의 체결\n",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      " 회원 가입 시 회원 약관 밑에 있는 동의버튼을 누르면 약관에 동의하여 이 계약이 체결된 것으로 간주한다.\n"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "제5조 용어의 정의\n",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      " 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.\n1.회원: '갑'과 서비스 이용에 관한 계약을 체결한 자.\n2.아이디(ID): 회원 식별과 회원의 서비스 이용을 위하여 회원이 선정하고 '갑'이 승인하는 문자와 숫자의 조합.\n3.비밀번호: 회원이 통신상의 자신의 비밀을 보호하기 위해 선정한 문자와 숫자의 조합\n"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "제6조 이용신청\n",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      "1.회원 가입은 온라인으로 가입신청 양식에 기록하여 '갑'에 제출함으로써 이용신청을 할 수 있습니다.\n2.가입희망 회원은 반드시 자신의 본명 및 주민등록번호로 이용신청을 하여야 하며, 1개의 ID만 신청을 할 수 있습니다.\n"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "제7조 회원가입의 승낙\n",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      " '갑'의 회원 가입 신청 양식에 가입 희망 회원이 인터넷으로 제6조와 같이 신청하면 '갑'은 바로 가입을 승인하여 서비스를 이용할 수 있다.\n"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "제8조 회원가입 신청거절 및 강제 탈퇴\n",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      "1.'갑'은 타인의 명의나 주민등록번호를 도용하여 회원가입신청을 할 경우 회원가입신청을 거절할 수 있다.\n2. 회원가입신청이 승인이 된 후에도 허위사실의 기재가 발각되거나 '갑'의 명예를 훼손시키거나 음란물이나 불건전한 내용을 게재할 경우 회원의 자격을 강제 탈퇴시킬 수 있다.\n"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "제9조 서비스 제공의 중지\n",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      "1.'갑'은  계속적, 안정적으로 서비스를 제공할 수 있도록 최선의 노력을 다하여야 합니다.\n2.'갑'은 항상 회원의 신용정보를 포함한 개인신상정보의 보안에 대하여 관리에 만전을 기함으로서 회원의 정보보안에 최선을 다하여야 합니다.\n"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "제10조 '갑'의 의무\n",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      " '갑'은 다음 각 호의 1에 해당하는 경우 서비스의 제공을 중지할 수 있습니다.\n1.설비의 보수 등을 위하여 부득이한 경우.\n2.전기통신사업법에 규정된 기간통신사업자가 전기통신서비스를 중지하는 경우.\n3.기타 '갑'이 서비스를 제공할 수 없는 사유가 발생한 경우.\n"),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "제11조 개인정보보호\n",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      "1.'갑'은 이용자의 정보수집시 서비스의 제공에 필요한 최소한의 정보를 수집합니다.\n2.제공된 개인정보는 당해 이용자의 동의없이 목적외의 이용이나  제3자에게 제공할 수 없으며, 이에 대한 모든 책임은 '갑'이 집니다. 다만, 다음의 경우에는 예외로 합니다.\n\n ①통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로 제공하는 경우\n ②전기통신기본법 등 법률의 규정에 의해 국가기관의 요구가 있는 경우\n ③범죄에 대한 수사상의 목적이 있거나 정보통신윤리 위원회의 요청이 있는 경우\n ④기타 관계법령에서 정한 절차에 따른 요청이 있는 경우\n\n 3.회원은 언제든지 '갑'이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 '갑'은 이에 대해 지체없이 처리합니다.\n"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
