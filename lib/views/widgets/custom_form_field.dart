import 'package:flutter/material.dart';
import 'package:school_guide/style/app_styles.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.trailingText = '',
    this.needsLength = false,
    required this.labelText,
  }) : super(key: key);
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String trailingText;
  final String labelText;
  final bool needsLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
          autovalidateMode: AutovalidateMode.always,
          controller: controller,
          keyboardType: keyboardType,
          maxLength: trailingText.isNotEmpty
              ? needsLength
                  ? 13
                  : 3
              : 1000,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.grey,
                style: BorderStyle.solid,
              ),
            ),
            labelStyle: TextStyle(color: AppColors.black),
            focusColor: AppColors.grey,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                style: BorderStyle.solid,
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.grey,
                style: BorderStyle.solid,
              ),
            ),
            hintText: hintText,
            suffixText: trailingText,
            labelText: labelText,
            counterText: '',
          ),
        ),
      ),
    );
  }
}

class CustomDescFormField extends StatelessWidget {
  const CustomDescFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.labelText,
  }) : super(key: key);
  final String hintText;
  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.grey, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: 6,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.grey,
              style: BorderStyle.solid,
            ),
          ),
          focusColor: AppColors.grey,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              style: BorderStyle.solid,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.grey,
              style: BorderStyle.solid,
            ),
          ),
          hintText: hintText,
          labelText: labelText,
          alignLabelWithHint: true,
          counterText: '',
        ),
      ),
    );
  }
}
