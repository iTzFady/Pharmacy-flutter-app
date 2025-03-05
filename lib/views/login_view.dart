import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmacy/constatns/routes.dart';
import 'package:pharmacy/utility/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(191, 234, 255, 1.0),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.all(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 180, 0, 0),
                  child: SvgPicture.asset('assets/images/logo.svg'),
                ),
                Text(
                  'كنيسة العذراء والقديس بولس الرسول \nالحضرة الجديدة',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Align(
              alignment: Alignment(.0, .08),
              child: TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'ُُEnter your e-mail',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment(0, 0.25),
              child: TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Enter your password',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.43),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(39, 174, 97, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () async {
                    final String email = _email.text;
                    final String password = _password.text;
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil(homeRoute, (route) => false);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'invalid-credential' ||
                          e.code == 'wrong-password' ||
                          e.code == 'invalid-email') {
                        await showErrorDialog(
                          context,
                          'Email or password is not correct',
                        );
                      } else if (e.code == 'channel-error') {
                        await showErrorDialog(
                          context,
                          'Email and password cannot be empty',
                        );
                      } else {
                        await showErrorDialog(context, 'Error: ${e.code}');
                      }
                    } catch (e) {
                      await showErrorDialog(context, e.toString());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
