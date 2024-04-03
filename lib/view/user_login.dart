import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ipix_test/const.dart';
import 'package:ipix_test/controller/controller.dart';
import 'package:ipix_test/view/home_screen.dart';
import 'package:provider/provider.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginController = Provider.of<Controller>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: loginController.loginKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.10),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/login_vector.png',
                      scale: size.height * 0.010,
                    )),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Log in\nyour account',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: loginController.userNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*required field";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'User Name',
                    hintStyle: GoogleFonts.poppins(),
                    isDense: true,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: loginController.userPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "*required field";
                    } else {
                      return null;
                    }
                  },
                  obscureText:
                      loginController.obscureText == true ? true : false,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: GoogleFonts.poppins(),
                      isDense: true,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            loginController.changeObscure();
                          },
                          icon: Icon(loginController.obscureText == true
                              ? Iconsax.eye_slash
                              : Iconsax.eye))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: loginController.rememberme == false ? false : true,
                      onChanged: (value) {
                        loginController.rememberUser();
                      },
                    ),
                    Text(
                      'Remember me',
                      style: GoogleFonts.poppins(),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password',
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (loginController.loginKey.currentState!.validate()) {
                        loginController.saveLoginCredentials(
                            loginController.userNameController.text,
                            loginController.userPasswordController.text,
                            context);
                      }
                    },
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll<OutlinedBorder>(
                          ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                        minimumSize: MaterialStatePropertyAll<Size>(
                          Size.fromHeight(50),
                        ),
                        backgroundColor:
                            MaterialStatePropertyAll(defaultColor)),
                    child: Text(
                      'Login Now',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
