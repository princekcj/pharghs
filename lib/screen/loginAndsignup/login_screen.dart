// ignore_for_file: non_constant_identifier_names, unused_field, prefer_const_constructors, unnecessary_brace_in_string_interps, avoid_print, file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:pharmafast/Api/data_store.dart';
import 'package:pharmafast/controller/login_controller.dart';
import 'package:pharmafast/helpar/routes_helper.dart';
import 'package:pharmafast/model/fontfamily_model.dart';
import 'package:pharmafast/utils/Colors.dart';
import 'package:pharmafast/utils/Custom_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String cuntryCode = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        body: Container(
          color: transparent,
          height: Get.height,
          child: Stack(
            clipBehavior: Clip.none,
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
                child: Form(
                  key: _formKey,
                  child: Container(
                    height: Get.height * 0.57,
                    width: Get.width * 0.9,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: WhiteColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign in !".tr,
                          style: TextStyle(
                            color: BlackColor,
                            fontFamily: "Gilroy Bold",
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.005,
                        ),
                        Text(
                          "Welcome back you’ve been missed! ".tr,
                          style: TextStyle(
                            color: BlackColor,
                            fontFamily: "Gilroy Medium",
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        IntlPhoneField(
                          keyboardType: TextInputType.number,
                          cursorColor: BlackColor,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: loginController.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          disableLengthCheck: true,
                          dropdownIcon: Icon(
                            Icons.arrow_drop_down,
                            color: greytext,
                          ),
                          dropdownTextStyle: TextStyle(
                            color: greytext,
                          ),
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyMedium,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: BlackColor,
                          ),
                          onCountryChanged: (value) {
                            loginController.number.text = '';
                            loginController.password.text = '';
                          },
                          onChanged: (value) {
                            cuntryCode = value.countryCode;
                          },
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
                          invalidNumberMessage:
                              "Please enter your mobile number".tr,
                        ),
                        SizedBox(height: Get.height * 0.03),
                        GetBuilder<LoginController>(builder: (context) {
                          return TextFormField(
                            controller: loginController.password,
                            obscureText: loginController.showPassword,
                            cursorColor: BlackColor,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: BlackColor,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password'.tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  loginController.showOfPassword();
                                },
                                child: !loginController.showPassword
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          "assets/showpassowrd.png",
                                          height: 10,
                                          width: 10,
                                          color: greytext,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          "assets/HidePassword.png",
                                          height: 10,
                                          width: 10,
                                          color: greytext,
                                        ),
                                      ),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/Unlock.png",
                                  height: 10,
                                  width: 10,
                                  color: greytext,
                                ),
                              ),
                              labelText: "Password".tr,
                              labelStyle: TextStyle(
                                color: greytext,
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: Get.height * 0.01),
                        Row(
                          children: [
                            Expanded(
                              child: GetBuilder<LoginController>(
                                  builder: (context) {
                                return Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor: BlackColor),
                                      child: Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        value: loginController.isChecked,
                                        activeColor: BlackColor,
                                        onChanged: (value) async {
                                          loginController
                                              .changeRememberMe(value);

                                          save('Remember', true);
                                          // save("Remember", value);
                                        },
                                      ),
                                    ),
                                    Text(
                                      "Remember me".tr,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Gilroy Medium",
                                        color: BlackColor,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.resetPassword);
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  "Forgot Password?".tr,
                                  style: TextStyle(
                                    fontFamily: FontFamily.gilroyBold,
                                    color: blueColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.02),
                        GestButton(
                          Width: Get.size.width,
                          height: 50,
                          buttoncolor: blueColor,
                          margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                          buttontext: "Login".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            color: WhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          onclick: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              loginController.getLoginApiData(cuntryCode);
                            } else {}
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Don't have an account?".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                color: greyColor,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(Routes.signUpScreen);
                              },
                              child: Text(
                                "Sign Up".tr,
                                style: TextStyle(
                                  color: blueColor,
                                  fontFamily: FontFamily.gilroyBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
