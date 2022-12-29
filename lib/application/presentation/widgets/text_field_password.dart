import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  const TextFieldPassword(
      {Key? key,
      this.controller,
      this.hintText,
      this.textInputType,
      this.validator})
      : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final FormFieldValidator<String>? validator;

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  bool _hideText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enableSuggestions: false,
      autocorrect: false,
      obscureText: _hideText,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _hideText = !_hideText;
              });
            },
            icon: _hideText
                ? const Icon(Icons.remove_red_eye_outlined)
                : const Icon(Icons.visibility_off_sharp)),
      ),
      // The validator receives the text that the user has entered.
      validator: widget.validator,
    );
  }
}
