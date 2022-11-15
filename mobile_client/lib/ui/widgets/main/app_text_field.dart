import 'package:flutter/material.dart';
import 'package:telegram_clone/ui/widgets/main/shake_widget.dart';

class AppTextField extends StatefulWidget {
  final GlobalKey? globalKey;
  final String? labelText;
  final String? errorText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const AppTextField({
    Key? key,
    this.obscureText = false,
    this.controller,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.labelText,
    this.globalKey,
  }) : super(key: key);

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  final _focusNode = FocusNode();

  bool _textVisible = true;

  void _changeTextVisibility() {
    setState(() => _textVisible = !_textVisible);
  }

  @override
  void initState() {
    if (widget.obscureText) {
      _textVisible = false;
    }
    _focusNode.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShakeWidget(
      key: widget.globalKey,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        focusNode: _focusNode,
        style: const TextStyle(decoration: TextDecoration.none),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: widget.errorText != null ? BorderSide(color: theme.errorColor) : const BorderSide()),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: widget.errorText != null ? theme.errorColor : theme.primaryColor)),
          labelText: widget.labelText,
          labelStyle: widget.errorText != null
              ? theme.textTheme.titleMedium?.copyWith(color: theme.errorColor)
              : _focusNode.hasFocus
                  ? theme.textTheme.titleMedium?.copyWith(color: theme.primaryColor)
                  : null,
          errorText: widget.errorText,
          errorMaxLines: 2,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _textVisible ? Icons.visibility_off : Icons.visibility,
                    color: widget.errorText != null
                        ? theme.errorColor
                        : _focusNode.hasFocus
                            ? theme.primaryColor
                            : null,
                  ),
                  splashColor: Colors.transparent,
                  onPressed: _changeTextVisibility)
              : null,
        ),
        obscureText: widget.obscureText ? !_textVisible : false,
      ),
    );
  }
}
