import 'package:chat/Components/botton.dart';
import 'package:chat/Components/text_field.dart';
import 'package:chat/servises/auth/auth_servises.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogingPage extends StatefulWidget {
  final void Function()? ontap;
  const LogingPage({super.key, required this.ontap});

  @override
  State<LogingPage> createState() => _LogingPageState();
}

class _LogingPageState extends State<LogingPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void signIn() async {
    final authservice = Provider.of<AuthServises>(context, listen: false);
    try {
      await authservice.signinwithemailandpassword(
        emailcontroller.text,
        passwordcontroller.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // icon
                const Icon(
                  Icons.message,
                  size: 110,
                  color: Color.fromARGB(255, 0, 123, 255),
                ),
                const Text("Welcom back ! to CogWave messages."),
                // email
                const SizedBox(
                  height: 50,
                ),
                CTextFeild(
                  controller: emailcontroller,
                  obscureText: false,
                  hintText: 'E-mail',
                ),
                const SizedBox(
                  height: 20,
                ),

                // password
                CTextFeild(
                  controller: passwordcontroller,
                  obscureText: true,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 30,
                ),

                // sign in btn
                Btn(ontap: signIn, text: 'Sign In'),
                const SizedBox(
                  height: 15,
                ),
                // register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.ontap,
                      child: const Text(
                        "Register Now!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
