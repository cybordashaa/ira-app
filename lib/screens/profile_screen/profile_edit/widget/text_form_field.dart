import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';

class BuildFormField extends StatelessWidget {
  final String initialValue;
  final String labelText;
  final String errorText;
  String savedValue;
  final TextInputType keyBoardType;
  final int maxLines;
  final bool isError;
  BuildFormField(
      {this.initialValue,
      this.labelText,
      this.errorText,
      this.keyBoardType,
      this.savedValue,
      this.isError = true,
      this.maxLines = 1})
      : super();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20.0,
        right: 30,
        left: 30,
      ),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        style: TextStyle(fontSize: 13),
        keyboardType: keyBoardType,
        onSaved: (newValue) => savedValue = newValue,
        onChanged: (value) {
          if (isError) {
            if (value.isNotEmpty) {
              return null;
            }
          }
          return null;
        },
        validator: (value) {
          if (isError) {
            if (value.isEmpty) {
              return errorText;
            }
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            gapPadding: 5.0,
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: kTextColor),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 5.0,
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: kTextColor),
          ),
          border: OutlineInputBorder(
            gapPadding: 5.0,
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: kTextColor),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 16),
          hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
