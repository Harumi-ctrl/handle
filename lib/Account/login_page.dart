import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hand_one/Account/reset_password_page.dart';
import 'package:hand_one/BookMark/bookmark_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends ConsumerState<LoginPage> {
  //入力されたメールアドレスを入れるデータ
  String loginUserEmail = '';
  //入力されたパスワードを入れるデータ
  String loginUserPassword = '';
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
                child: Text("ブックマークを使うには新規登録又はログインしてください"),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: 'メールアドレス', border: OutlineInputBorder()),
                  onChanged: (String value) {
                    setState(() {
                      loginUserEmail = value;
                    });
                  },
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
                      loginUserPassword = value;
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
                      // メール/パスワードでログイン
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final UserCredential result =
                          await auth.signInWithEmailAndPassword(
                        email: loginUserEmail,
                        password: loginUserPassword,
                      );
                      // ログインに成功した場合
                      final User? user = result.user;
                      setState(() {
                        infoText = 'ログイン成功: ${user?.email}';
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const BookmarkList();
                      }));
                    } catch (e) {
                      // ログインに失敗した場合
                      setState(() {
                        infoText = 'ログインに失敗しました: ${e.toString()}';
                      });
                    }
                  },
                  child: const Text(
                    'ログイン',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'パスワードを忘れた場合',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
