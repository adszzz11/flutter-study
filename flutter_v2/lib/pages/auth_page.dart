import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2/provider/page_notifier.dart';
import 'package:provider/provider.dart';

class AuthPage extends Page {
  static final pageName = 'AuthPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this, builder: (context) => AuthWidget());
  }
}

class AuthWidget extends StatefulWidget {
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  static final double _cornerRadius = 8.0;
  bool isRegister = false;
  Duration _duration = Duration(milliseconds: 200);
  Curve _curve = Curves.fastOutSlowIn;
  final firebaseAuth = FirebaseAuth.instance;

  OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(_cornerRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0));

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/image.gif'))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                reverse: true,
                padding: EdgeInsets.all(16),
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white54,
                    radius: 36,
                    child: Image.asset('assets/logo.png'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        // color: Colors.white54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_cornerRadius),
                        ),
                        padding: EdgeInsets.all(16),
                        onPressed: () {
                          setState(() {
                            isRegister = false;
                          });
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: isRegister ? Colors.black45 : Colors.black87,
                            fontSize: 18,
                            fontWeight:
                                isRegister ? FontWeight.w400 : FontWeight.w600,
                          ),
                        ),
                      ),
                      FlatButton(
                        // color: Colors.white54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_cornerRadius),
                        ),
                        padding: EdgeInsets.all(16),
                        onPressed: () {
                          setState(() {
                            isRegister = true;
                          });
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: isRegister ? Colors.black87 : Colors.black45,
                            fontSize: 18,
                            fontWeight:
                                isRegister ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  _buildTextFormField("Email Address", _emailController,
                      TextInputType.emailAddress),
                  SizedBox(
                    height: 8,
                  ),
                  _buildTextFormField("Password", _passController, null),
                  AnimatedContainer(
                    height: isRegister ? 8 : 0,
                    duration: _duration,
                    curve: _curve,
                  ),
                  AnimatedContainer(
                    curve: _curve,
                    height: isRegister ? 60 : 0,
                    duration: _duration,
                    child: _buildTextFormField(
                        "Confirm Password", _confirmPassController, null),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FlatButton(
                    color: Colors.white54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_cornerRadius),
                    ),
                    padding: EdgeInsets.all(16),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        if (isRegister) {
                          firebaseAuth.createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passController.text);
                          Provider.of<PageNotifier>(context, listen: false)
                              .goToMain();
                        } else {
                          firebaseAuth.signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passController.text);
                          Provider.of<PageNotifier>(context, listen: false)
                              .goToMain();
                        }
                      }
                    },
                    child: Text(isRegister ? "Register" : "Login"),
                  ),
                  Divider(
                    height: 31,
                    thickness: 1,
                    color: Colors.white54,
                    indent: 16,
                    endIndent: 16,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      buildSocialButton('assets/google.png', () {
                        Provider.of<PageNotifier>(context, listen: false)
                            .goToMain();
                      }),
                      buildSocialButton('assets/facebook.png', () {
                        Provider.of<PageNotifier>(context, listen: false)
                            .goToMain();
                      }),
                      buildSocialButton('assets/apple.png', () {
                        Provider.of<PageNotifier>(context, listen: false)
                            .goToMain();
                      }),
                    ],
                  )
                ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildSocialButton(String imagePath, Function onPressed) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white54),
      child: IconButton(
          icon: ImageIcon(AssetImage(imagePath)), onPressed: onPressed),
    );
  }

  TextFormField _buildTextFormField(String labelText,
      TextEditingController controller, TextInputType textType) {
    return TextFormField(
      keyboardType: textType,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      controller: controller,
      validator: (text) {
        //원하는 값인지 체크할 때
        if (controller != _confirmPassController &&
            (text == null || text.isEmpty)) return '잘못된 형식입니다. 다시 작성해주세요.';

        if (controller == _confirmPassController &&
            isRegister &&
            (text == null || text.isEmpty)) return '잘못된 형식입니다. 다시 작성해주세요.';
        if (isRegister && _confirmPassController.text != _passController.text) {
          return '비밀번호가 일치하지 않습니다.';
        }
        return null;
      },
      decoration: InputDecoration(
          errorBorder: _border.copyWith(
              borderSide: BorderSide(color: Colors.black, width: 3)),
          errorStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          filled: true,
          fillColor: Colors.black45,
          hintText: labelText,
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
          hintStyle: TextStyle(color: Colors.white)),
    );
  }
}
