/*
*  home_customer_screen.dart
*  home_consumer_screen
*
*  Created by Yakub Pasha.
*  Copyright © 2020 tara.id. All rights reserved.
    */

import 'package:flutter/material.dart';
import '../../common/constants/values.dart';


class HomeCustomerScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 248,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 190,
                      decoration: BoxDecoration(
                        gradient: Gradients.primaryGradient,
                      ),
                      child: Container(),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 24,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 56,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 101,
                                  height: 32,
                                  margin: EdgeInsets.only(left: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 62,
                                          height: 24,
                                          margin: EdgeInsets.only(left: 4),
                                          child: Image.asset(
                                            "assets/images/combined-shape-5.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        margin: EdgeInsets.only(top: 3, right: 28),
                                        child: Text(
                                          " ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 18, 52, 86),
                                            fontFamily: "",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.33333,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 60,
                                height: 38,
                                margin: EdgeInsets.only(top: 9, right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "Hello",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(128, 18, 52, 86),
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "Bambang",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 18, 52, 86),
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          height: 1.42857,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 29,
                                height: 29,
                                margin: EdgeInsets.only(top: 12, right: 4),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      right: 4,
                                      child: Image.asset(
                                        "assets/images/icon-7.png",
                                        fit: BoxFit.none,
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        width: 14,
                                        height: 14,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 249, 80, 116),
                                          borderRadius: BorderRadius.all(Radius.circular(7)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(horizontal: 4),
                                              child: Text(
                                                "3",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 33,
                                  height: 33,
                                  margin: EdgeInsets.only(right: 16),
                                  child: Image.asset(
                                    "assets/images/avatar-2.png",
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 16, top: 16, right: 16),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(179, 255, 255, 255),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(26, 0, 0, 0),
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                margin: EdgeInsets.only(left: 8),
                                child: Image.asset(
                                  "assets/images/icon-3.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(right: 41),
                                child: Text(
                                  "Try typing action, contact or merchant...",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 96,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 78,
                                height: 96,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      height: 56,
                                      margin: EdgeInsets.symmetric(horizontal: 11),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 19, 53, 86),
                                        borderRadius: BorderRadius.all(Radius.circular(28)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            height: 33,
                                            margin: EdgeInsets.symmetric(horizontal: 12),
                                            child: Image.asset(
                                              "assets/images/icon-9.png",
                                              fit: BoxFit.none,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      margin: EdgeInsets.only(left: 22, right: 22, bottom: 14),
                                      child: Text(
                                        "Send",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.primaryText,
                                          fontFamily: "",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 78,
                                height: 96,
                                margin: EdgeInsets.only(left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      height: 56,
                                      margin: EdgeInsets.symmetric(horizontal: 11),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 19, 53, 86),
                                        borderRadius: BorderRadius.all(Radius.circular(28)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            height: 33,
                                            margin: EdgeInsets.symmetric(horizontal: 12),
                                            child: Image.asset(
                                              "assets/images/icon-22.png",
                                              fit: BoxFit.none,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      margin: EdgeInsets.only(left: 12, right: 12, bottom: 14),
                                      child: Text(
                                        "Receive",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.primaryText,
                                          fontFamily: "",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: 78,
                                height: 96,
                                margin: EdgeInsets.only(right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      height: 56,
                                      margin: EdgeInsets.symmetric(horizontal: 11),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 19, 53, 86),
                                        borderRadius: BorderRadius.all(Radius.circular(28)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            height: 33,
                                            margin: EdgeInsets.symmetric(horizontal: 12),
                                            child: Image.asset(
                                              "assets/images/icon-14.png",
                                              fit: BoxFit.none,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 14),
                                      child: Text(
                                        "Add Beneficiary",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.primaryText,
                                          fontFamily: "",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 78,
                                height: 96,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      height: 56,
                                      margin: EdgeInsets.symmetric(horizontal: 11),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 19, 53, 86),
                                        borderRadius: BorderRadius.all(Radius.circular(28)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            height: 33,
                                            margin: EdgeInsets.symmetric(horizontal: 12),
                                            child: Image.asset(
                                              "assets/images/icon-8.png",
                                              fit: BoxFit.none,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      margin: EdgeInsets.only(left: 21, right: 21, bottom: 14),
                                      child: Text(
                                        "Shop",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.primaryText,
                                          fontFamily: "",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              margin: EdgeInsets.only(left: 16, top: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 227,
                    margin: EdgeInsets.only(top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "My Accounts",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "",
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 227,
                            height: 40,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    width: 103,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 19, 53, 86),
                                      borderRadius: Radii.k8pxRadius,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 24,
                                          margin: EdgeInsets.symmetric(horizontal: 14),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: 46,
                                                  height: 18,
                                                  margin: EdgeInsets.only(left: 3),
                                                  child: Image.asset(
                                                    "assets/images/combined-shape-7.png",
                                                    fit: BoxFit.none,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "Wallet",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 18, 52, 86),
                                                  fontFamily: "",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 8.89043,
                                                  height: 1.33333,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    width: 116,
                                    height: 40,
                                    margin: EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(
                                      border: Border.fromBorderSide(Borders.secondaryBorder),
                                      borderRadius: Radii.k8pxRadius,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 25,
                                          height: 25,
                                          margin: EdgeInsets.only(left: 8),
                                          child: Image.asset(
                                            "assets/images/icon-2.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          margin: EdgeInsets.only(right: 12),
                                          child: Text(
                                            "Add Bank",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 141,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 59,
                            height: 24,
                            margin: EdgeInsets.only(right: 48),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  child: Text(
                                    "SEE ALL",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontFamily: "",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryElement,
                                    ),
                                    child: Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 141,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.fromBorderSide(Borders.secondaryBorder),
                              borderRadius: Radii.k8pxRadius,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  margin: EdgeInsets.only(left: 8),
                                  child: Image.asset(
                                    "assets/images/icon-2.png",
                                    fit: BoxFit.none,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(right: 12),
                                  child: Text(
                                    "Add E-Money",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontFamily: "",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 128,
              margin: EdgeInsets.only(left: 16, top: 24, right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 160,
                    height: 128,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Transfer to",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "",
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 160,
                            height: 92,
                            margin: EdgeInsets.only(top: 11),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 76,
                                    height: 92,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBackground,
                                      boxShadow: [
                                        Shadows.primaryShadow,
                                      ],
                                      borderRadius: Radii.k8pxRadius,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.only(left: 18, top: 8, right: 18),
                                          decoration: BoxDecoration(
                                            color: AppColors.accentElement,
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                          ),
                                          child: Container(),
                                        ),
                                        Spacer(),
                                        Container(
                                          margin: EdgeInsets.only(left: 18, right: 18, bottom: 1),
                                          child: Text(
                                            "Tara\nUsers",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 76,
                                    height: 92,
                                    margin: EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBackground,
                                      boxShadow: [
                                        Shadows.primaryShadow,
                                      ],
                                      borderRadius: Radii.k8pxRadius,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.only(left: 18, top: 8, right: 18),
                                          decoration: BoxDecoration(
                                            color: AppColors.accentElement,
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                          ),
                                          child: Container(),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 8),
                                          child: Text(
                                            "Bank Account",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 76,
                    height: 92,
                    margin: EdgeInsets.only(top: 36, right: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      boxShadow: [
                        Shadows.primaryShadow,
                      ],
                      borderRadius: Radii.k8pxRadius,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 18, top: 8, right: 18),
                          decoration: BoxDecoration(
                            color: AppColors.accentElement,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Container(),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8, top: 8, right: 8),
                          child: Text(
                            "E-Money",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "",
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 76,
                    height: 92,
                    margin: EdgeInsets.only(top: 36),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      boxShadow: [
                        Shadows.primaryShadow,
                      ],
                      borderRadius: Radii.k8pxRadius,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 40,
                          margin: EdgeInsets.only(left: 18, top: 8, right: 18),
                          decoration: BoxDecoration(
                            color: AppColors.accentElement,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Container(),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, bottom: 1),
                          child: Text(
                            "My\nAccount",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "",
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              height: 118,
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 157,
                    height: 116,
                    margin: EdgeInsets.only(top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Payment",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "",
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 157,
                            height: 78,
                            margin: EdgeInsets.only(top: 13),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 72,
                                    height: 78,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 56,
                                          margin: EdgeInsets.symmetric(horizontal: 8),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  height: 56,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primaryElement,
                                                    boxShadow: [
                                                      Shadows.primaryShadow,
                                                    ],
                                                    borderRadius: BorderRadius.all(Radius.circular(28)),
                                                  ),
                                                  child: Container(),
                                                ),
                                              ),
                                              Positioned(
                                                left: 12,
                                                top: 12,
                                                right: 12,
                                                child: Image.asset(
                                                  "assets/images/assets---icon---m---mobile-2.png",
                                                  fit: BoxFit.none,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 13),
                                          child: Text(
                                            "Mobile",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 72,
                                    height: 78,
                                    margin: EdgeInsets.only(left: 13),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 56,
                                          margin: EdgeInsets.symmetric(horizontal: 8),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  height: 56,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primaryElement,
                                                    boxShadow: [
                                                      Shadows.primaryShadow,
                                                    ],
                                                    borderRadius: BorderRadius.all(Radius.circular(28)),
                                                  ),
                                                  child: Container(),
                                                ),
                                              ),
                                              Positioned(
                                                left: 12,
                                                top: 12,
                                                right: 12,
                                                child: Image.asset(
                                                  "assets/images/assets---icon---m---mobile-4.png",
                                                  fit: BoxFit.none,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 9),
                                          child: Text(
                                            "Internet",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 72,
                    height: 78,
                    margin: EdgeInsets.only(top: 40, right: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 56,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                right: 0,
                                child: Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                    boxShadow: [
                                      Shadows.primaryShadow,
                                    ],
                                    borderRadius: BorderRadius.all(Radius.circular(28)),
                                  ),
                                  child: Container(),
                                ),
                              ),
                              Positioned(
                                left: 12,
                                top: 12,
                                right: 12,
                                child: Image.asset(
                                  "assets/images/assets---icon---m---mobile-3.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 21),
                          child: Text(
                            "PLN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "",
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 72,
                    height: 118,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 60,
                            height: 24,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  child: Text(
                                    "SEE ALL",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontFamily: "",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryElement,
                                    ),
                                    child: Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 72,
                            height: 78,
                            margin: EdgeInsets.only(top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 56,
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          height: 56,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryElement,
                                            boxShadow: [
                                              Shadows.primaryShadow,
                                            ],
                                            borderRadius: BorderRadius.all(Radius.circular(28)),
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 12,
                                        top: 12,
                                        right: 12,
                                        child: Image.asset(
                                          "assets/images/assets---icon---m---mobile.png",
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 17),
                                  child: Text(
                                    "BPJS",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontFamily: "",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 277,
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 27,
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 2),
                            child: Text(
                              "Transactions",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontFamily: "",
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 60,
                            height: 24,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  child: Text(
                                    "SEE ALL",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontFamily: "",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryElement,
                                    ),
                                    child: Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 72,
                    margin: EdgeInsets.only(top: 13),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            "assets/images/rectangle.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 72,
                          top: 19,
                          right: 16,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 98,
                                  height: 36,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "TODAY • 12:33",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.secondaryText,
                                            fontFamily: "",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 4),
                                          child: Text(
                                            "Andi Ruhiyat",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "- Rp 300.000",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 249, 80, 116),
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 72,
                    margin: EdgeInsets.only(top: 8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            "assets/images/rectangle-7.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 72,
                          top: 19,
                          right: 16,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 150,
                                  height: 36,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "TUE, AUG 7 2020  • 02:19",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.secondaryText,
                                            fontFamily: "",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 4),
                                          child: Text(
                                            "Marie Ruhani",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "- Rp 55.000",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 249, 80, 116),
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 72,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            "assets/images/rectangle-6.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 72,
                          top: 19,
                          right: 16,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 150,
                                  height: 36,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "TUE, AUG 7 2020  • 02:19",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.secondaryText,
                                            fontFamily: "",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 4),
                                          child: Text(
                                            "Abdul Malik",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "+ Rp 55.000",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 178, 247, 226),
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 84,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 28,
                    right: 0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.primaryElement,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(36, 0, 0, 0),
                                  offset: Offset(0, 2),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Container(),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          right: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 76,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          margin: EdgeInsets.only(top: 8),
                                          child: Image.asset(
                                            "assets/images/icon-6.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        margin: EdgeInsets.only(left: 21, right: 21, bottom: 4),
                                        child: Text(
                                          "Home",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.primaryText,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 76,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          margin: EdgeInsets.only(top: 8),
                                          child: Image.asset(
                                            "assets/images/icon-10.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        margin: EdgeInsets.only(left: 25, right: 25, bottom: 4),
                                        child: Text(
                                          "Chat",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.secondaryText,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 76,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          margin: EdgeInsets.only(top: 8),
                                          child: Image.asset(
                                            "assets/images/icon-3-2.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 4),
                                        child: Text(
                                          "My Orders",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.secondaryText,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 76,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          margin: EdgeInsets.only(top: 8),
                                          child: Image.asset(
                                            "assets/images/icon-24.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        margin: EdgeInsets.only(left: 12, right: 12, bottom: 4),
                                        child: Text(
                                          "Accounts",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.secondaryText,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 56,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                right: 0,
                                child: Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    gradient: Gradients.primaryGradient,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(36, 7, 202, 208),
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(Radius.circular(28)),
                                  ),
                                  child: Container(),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                top: 13,
                                right: 10,
                                child: Image.asset(
                                  "assets/images/icon-13.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            "Scan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}