import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_one/BookMark/bookmark_page.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends ConsumerState<SignUpPage> {
  //入力されたメールアドレスを入れるデータ
  String newUserEmail = '';
//入力されたパスワードを入れるデータ
  String newUserPassword = '';
// 登録・ログインに関する情報を表示するデータ
  String infoText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "ブックマークを使うには新規登録又はログインしてください",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'メールアドレス', border: OutlineInputBorder()),
                  onChanged: (String value) {
                    setState(() {
                      newUserEmail = value;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'パスワード', border: OutlineInputBorder()),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      newUserPassword = value;
                    });
                  },
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(infoText),
              ),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      // メール/パスワードでユーザー登録
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final UserCredential result =
                          await auth.createUserWithEmailAndPassword(
                        email: newUserEmail,
                        password: newUserPassword,
                      );

                      // 登録に成功した場合
                      setState(() {
                        infoText = '登録成功: ${result.user?.email}';
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const BookmarkList();
                      }));
                    } catch (e) {
                      // 登録に失敗した場合
                      setState(() {
                        infoText = '登録失敗: ${e.toString()}';
                      });
                    }
                  },
                  child: const Text(
                    '登録',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
