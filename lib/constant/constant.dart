import 'package:chat_pot/constant/app_color.dart';
import 'package:flutter/material.dart';

const String imageUrl = "http://192.168.1.71:8080/";
InputDecoration textFormFieldDecoration(String text, String icon) {
  return InputDecoration(
      prefixIconConstraints: const BoxConstraints(minHeight: 40, minWidth: 40),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(icon), fit: BoxFit.cover)),
        ),
      ),
      hintStyle: const TextStyle(fontSize: 12),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      hintText: text,
      filled: true,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      fillColor: AppColor.backgroundColor);
}
