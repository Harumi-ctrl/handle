import 'package:flutter/material.dart';
import 'package:hand_one/Account/signup_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'login_page.dart';

class SignUpLoginPage extends ConsumerStatefulWidget {
  const SignUpLoginPage({super.key});

  @override
  SignUpLoginState createState() => SignUpLoginState();
}

class SignUpLoginState extends ConsumerState<SignUpLoginPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: const TabBar(
              tabAlignment: TabAlignment.center,
              isScrollable: true,
              tabs: [
                Tab(
                  text: '新規登録',
                ),
                Tab(
                  text: 'ログイン',
                ),
              ],
            )),
        backgroundColor: Colors.white,
        body: const TabBarView(
          children: [
            SignUpPage(),
            LoginPage(),
          ],
        ),
      ),
    );
  }
}
