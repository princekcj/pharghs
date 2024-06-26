// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unnecessary_string_interpolations, sort_child_properties_last, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pharmafast/controller/signup_controller.dart';
import 'package:pharmafast/helpar/routes_helper.dart';
import 'package:pharmafast/model/fontfamily_model.dart';
import 'package:pharmafast/utils/Colors.dart';
import 'package:pharmafast/utils/Custom_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  SignUpController signUpController = Get.find();
  TextEditingController number = TextEditingController();
  String cuntryCode = "";
  final _formKey = GlobalKey<FormState>();

  static String verifay = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Container(
          color: transparent,
          height: Get.height,
          child: Stack(
            children: [
              Container(
                height: Get.height * 0.55,
                width: double.infinity,
                decoration: BoxDecoration(gradient: gradient.btnGradient),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.1),
                      child: Image.asset(
                        "assets/loginLogo.png",
                        height: 60,
                        color: WhiteColor,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      "PharmaFast".tr,
                      style: TextStyle(
                        color: WhiteColor,
                        fontFamily: FontFamily.gilroyBold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      "Medicine Solution".tr,
                      style: TextStyle(
                        color: WhiteColor,
                        letterSpacing: 2,
                        fontFamily: FontFamily.gilroyMedium,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: Get.width * 0.05,
                top: Get.height * 0.32,
                child: Container(
                  height: Get.height * 0.52,
                  width: Get.width * 0.9,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reset Password".tr,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Gilroy Bold",
                          color: BlackColor,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Please enter your phone number to request a\npassword reset"
                            .tr,
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "Gilroy Medium",
                          color: greytext,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: IntlPhoneField(
                          keyboardType: TextInputType.number,
                          cursorColor: BlackColor,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          initialCountryCode: 'IN',
                          controller: number,
                          onChanged: (value) {
                            cuntryCode = value.countryCode;
                          },
                          onCountryChanged: (value) {
                            number.text = '';
                          },
                          dropdownIcon: Icon(
                            Icons.arrow_drop_down,
                            color: greytext,
                          ),
                          dropdownTextStyle: TextStyle(
                            color: greytext,
                          ),
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: BlackColor,
                          ),
                          decoration: InputDecoration(
                            helperText: null,
                            labelText: "Mobile Number".tr,
                            labelStyle: TextStyle(
                              color: greytext,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (p0) {
                            if (p0!.completeNumber.isEmpty) {
                              return 'Please enter your number'.tr;
                            } else {}
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestButton(
                        Width: Get.size.width,
                        height: 50,
                        buttoncolor: blueColor,
                        margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                        buttontext: "Request OTP".tr,
                        style: TextStyle(
                          fontFamily: "Gilroy Bold",
                          color: WhiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        onclick: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            signUpController.checkMobileInResetPassword(
                                number: number.text, cuntryCode: cuntryCode);
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "You remember your password?".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: greytext,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.loginScreen);
                            },
                            child: Text(
                              "Log In".tr,
                              style: TextStyle(
                                color: blueColor,
                                fontFamily: FontFamily.gilroyMedium,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: WhiteColor,
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

Future<void> sendOTP(
  String phonNumber,
  String cuntryCode,
) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: '${cuntryCode + phonNumber}',
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {
      print(e.toString());
    },
    timeout: Duration(seconds: 60),
    codeSent: (String verificationId, int? resendToken) {
      ResetPasswordScreen.verifay = verificationId;
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}
