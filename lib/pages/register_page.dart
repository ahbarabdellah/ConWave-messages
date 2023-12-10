import 'package:chat/Components/botton.dart';
import 'package:chat/Components/text_field.dart';
import 'package:chat/servises/auth/auth_servises.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? ontap;
  const RegisterPage({super.key, required this.ontap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  void signUp() async {
    final authservice = Provider.of<AuthServises>(context, listen: false);
    if (passwordcontroller.text == confirmpassword.text) {
      try {
        await authservice.signUpwithemailandpassword(
          emailcontroller.text,
          passwordcontroller.text,
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Passwords Does not match",
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
                  height: 40,
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
                  height: 20,
                ),

                // Confirm password
                CTextFeild(
                  controller: confirmpassword,
                  obscureText: true,
                  hintText: 'Confirm Password',
                ),
                const SizedBox(
                  height: 20,
                ),

                // sign in btn
                Btn(ontap: signUp, text: 'Sign Up'),
                const SizedBox(
                  height: 10,
                ),
                // register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a Member?"),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.ontap,
                      child: const Text(
                        "Login Now",
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
