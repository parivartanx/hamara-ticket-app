import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '/features/privacy-policy/privacy_policy.dart';
import '/extensions/media_query_ext.dart';
import 'verification.dart';
import '/providers/color_provider.dart';
import 'package:page_transition/page_transition.dart';
import '../home/presentation/screens/home.dart';
import '../../utils/botton.dart';
import '../../utils/ctextfield.dart';
import '../../utils/itextfield.dart';

import 'presentation/screens/login.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {

 

  bool _obscureText = true;
  bool obscureText_ = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void toggle() {
    setState(() {
      obscureText_ = !obscureText_;
    });
  }

  @override
  void initState() {
    super.initState();
    ref.read(colorProvider.notifier).getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(colorProvider);
    final height = context.height;
    final width = context.width;
    return ScreenUtilInit(
      builder:  (BuildContext context, child) =>  Scaffold(
        backgroundColor: notifire.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height / 20),
              Row(
                children: [
                  SizedBox(
                    width: width / 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        color: notifire.primaryColor,
                        child: Icon(Icons.arrow_back,
                            color: notifire.whiteColor)),
                  ),
                ],
              ),
              SizedBox(
                height: height / 100,
              ),
              Center(
                child: Image.asset(
                  "assets/image/getevent.png",
                  height: height / 13,
                ),
              ),
              Text(
                "Hamara Ticket",
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Gilroy Medium',
                  color: notifire.textColor,
                ),
              ),
              SizedBox(height: height / 30),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy Medium',
                        color: notifire.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Customtextfild.textField(
                  "Name",
                  Colors.grey,
                  notifire.whiteColor,
                  "assets/image/Profile.png",
                ),
              ),
              SizedBox(height: height / 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Customtextfild.textField(
                  "User",
                  Colors.grey,
                  notifire.whiteColor,
                  "assets/image/Message.png",
                ),
              ),
              SizedBox(height: height / 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Customtextfild2.textField(
                  _obscureText,
                  "Password",
                  Colors.grey,
                  notifire.whiteColor,
                  "assets/image/Lock.png",
                  GestureDetector(
                    onTap: () {
                      _toggle();
                    },
                    child: _obscureText
                        ? Image.asset("assets/image/eye.png")
                        : const Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                  ),
                ),
              ),
              SizedBox(height: height / 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Customtextfild2.textField(
                  obscureText_,
                  "Password",
                  Colors.grey,
                  notifire.whiteColor,
                  "assets/image/Lock.png",
                  GestureDetector(
                    onTap: () {
                      toggle();
                    },
                    child: obscureText_
                        ? Image.asset("assets/image/eye.png")
                        : const Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                  ),
                ),
              ),
              SizedBox(height: height / 40),
              Center(
                child: SizedBox(
                  width: context.width*.8,
                  child: Text.rich(TextSpan(children: [
                    const TextSpan(text: "By signing up,you agree to our "),
                    TextSpan(text: "Privacy Policy ",
                    recognizer: TapGestureRecognizer()..onTap=(){
                       context.pushNamed(PrivacyPolicyScreen.routeName);
                                           
                      },
                    style:TextStyle(color: notifire.buttonColor) ),
                    const TextSpan(text: "and "),
                    TextSpan(text: "Terms & conditions",style: TextStyle(color: notifire.buttonColor))
                  ]),textAlign: TextAlign.center,),
                ),
              ),
              SizedBox(height: context.height*.02,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const Verification(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Custombutton.button(
                    notifire.buttonsColor,
                    "SIGN UP",
                    SizedBox(
                      width: width / 3,
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height / 60),
              Text(
                "OR",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.sp,
                  fontFamily: 'Gilroy Medium',
                ),
              ),
              SizedBox(height: height / 60),
              log(notifire.blackColor, "Login with Google",
                  "assets/image/google.png", notifire.whiteColor),
              SizedBox(height: height / 50),
              log(notifire.blackColor, "Login with Facebook",
                  "assets/image/facebook.png", notifire.whiteColor),
              SizedBox(height: height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: notifire.whiteColor,
                      fontSize: 12.sp,
                      fontFamily: 'Gilroy Medium',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const Login(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        color: Color(0xff5669FF),
                        fontFamily: 'Gilroy Medium',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.height*.02,)
            ],
          ),
        ),
      ),
    );
  }

  Widget log(clr, name, img, clr2) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: const Home()));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: const Color(0xffdcdbdb),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: clr,
          ),
          height: context.height / 15,
          width: context.width / 1.5,
          child: Row(
            children: [
              SizedBox(
                width: context.width / 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: Image.asset(img),
              ),
              SizedBox(
                width: context.width / 20,
              ),
              Text(
                name,
                style: TextStyle(
                    color: clr2,
                    fontFamily: 'Gilroy Medium',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
