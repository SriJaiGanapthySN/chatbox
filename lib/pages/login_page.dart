import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/components/my_button.dart';
import 'package:chat/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final void Function() onTap;
  LoginPage({super.key, required this.onTap});

  //login method
  void login(BuildContext context) async {
    //auth service
    final authservice = AuthService();

    //login
    try {
      await authservice.signInWithEmailAndPassword(
          _emailcontroller.text, _passwordcontroller.text);
    }
    //error handling
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon
            Icon(
              Icons.messenger,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            //welcome-back
            Text(
              "Welcome-Back To ChatBox",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            //login-textfield
            MyTextfield(
              hinttext: "E-mail",
              obscure: false,
              controller: _emailcontroller,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            //password-textfield

            MyTextfield(
              hinttext: "Password",
              obscure: true,
              controller: _passwordcontroller,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            //login-button
            MyButton(
              text: 'Login',
              onTap: () => login(context),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a User?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    " Register-Now",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
