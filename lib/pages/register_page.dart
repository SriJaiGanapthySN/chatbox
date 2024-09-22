import 'package:chat/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chat/components/my_button.dart';
import 'package:chat/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  final void Function() onTap;
  RegisterPage({super.key, required this.onTap});

  //register method

  void register(BuildContext context) async {
    //auth service
    final authService = AuthService();
    //validating the passwords
    if (_passwordcontroller.text == _confirmpasswordcontroller.text) {
      //register
      try {
        await authService.signUpWithEmailAndPassword(
            _emailcontroller.text, _confirmpasswordcontroller.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Passwords You entered Are not same"),
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
              "Let's create An Account",
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
              height: height * 0.02,
            ),
            //cf-password-textfield

            MyTextfield(
              hinttext: "Confirm-Password",
              obscure: true,
              controller: _confirmpasswordcontroller,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            //login-button
            MyButton(
              text: 'Register',
              onTap: () => register(context),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already a User?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    " Login-Now",
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
