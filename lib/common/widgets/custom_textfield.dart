import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends StatefulWidget {
  final bool noBorder;
  final bool readOnly;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? initialValue;
  final bool autocorrect;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? children;
  final Widget? prefix;
  final TextInputType keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool enableInteractiveSelection;
  final GestureTapCallback? onTap;
  final bool enabled;
  final TextAlign textAlign;
  final String? errorText;
  final String? counterText;
  final String? helperText;
  final bool expanded;
  final int maxLines;
  final int? minLines;
  final EdgeInsets? contentPadding;
  final TextAlignVertical? textAlignVertical;
  final Widget? suffix;
  final double radius;
  final String? Function(String?)? validator;
  final bool hideCounter;
  final String? prefixText;
  final String? suffixText;
  final TextStyle? prefixStyle;
  final bool hasFloatingPlaceholder;
  final TextStyle? style;
  final TextStyle? labelstyle;
  final Color? fillColor;
  final bool isSmsListener;
  final bool trim;
  final bool isRequired;

  CustomTextField({
    Key? key,
    this.readOnly = false,
    this.focusNode,
    this.onChanged,
    this.onSaved,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.controller,
    this.autocorrect = true,
    this.suffixIcon,
    this.prefixIcon,
    this.prefix,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.inputFormatters,
    this.textInputAction,
    this.autofocus = false,
    this.enableInteractiveSelection = true,
    this.onTap,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.errorText,
    this.counterText,
    this.helperText,
    this.expanded = false,
    this.maxLines = 1,
    this.minLines,
    this.contentPadding,
    this.textAlignVertical,
    this.suffix,
    this.radius = 5,
    this.children,
    this.validator,
    this.hideCounter = false,
    this.initialValue,
    this.prefixText,
    this.suffixText,
    this.hasFloatingPlaceholder = false,
    this.prefixStyle,
    this.style,
    this.fillColor,
    this.isSmsListener = false,
    this.hintStyle,
    this.trim = false,
    this.isRequired = false,
    this.noBorder = false, this.labelstyle,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  final TextEditingController _textController = TextEditingController(text: '');

  OutlineInputBorder get _border =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.radius),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 0.5,
        ),
      );

  UnderlineInputBorder get _noBorder =>
      const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 0.5,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.labelText == null
            ? const SizedBox.shrink()
            : RichText(
          text: TextSpan(
              style: widget.labelstyle ?? const TextStyle(
                  color: Colors.white),
              text: widget.labelText,
              children: const [
                TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
              ]),
        ),
        widget.labelText == null
            ? const SizedBox.shrink()
            : const SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: widget.validator,
          focusNode: widget.focusNode,
          expands: widget.expanded,
          controller:
          widget.isSmsListener ? _textController : widget.controller,
          initialValue: widget.initialValue,
          autocorrect: widget.autocorrect,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          textAlign: widget.textAlign,
          textAlignVertical: widget.textAlignVertical,
          obscureText: widget.obscureText,
          inputFormatters: widget.inputFormatters,
          onChanged: widget.onChanged,
          readOnly: widget.readOnly,
          decoration: InputDecoration(
            errorStyle: const TextStyle(
              fontSize: 14.0,
            ),
            fillColor: widget.enabled
                ? widget.fillColor

                : Theme
                .of(context)
                .scaffoldBackgroundColor,
            prefixText: widget.prefixText,
            suffixText: widget.suffixText,
            prefixStyle: widget.prefixStyle,
            prefixIcon: widget.prefixIcon,
            prefix: widget.prefix,
            suffixIcon: widget.suffixIcon,
            suffix: widget.suffix,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 14,
                ),
            errorText: widget.errorText,
            counterText: widget.counterText,
            counterStyle: const TextStyle(fontSize: 14),
            helperText: widget.helperText,
            hintText:
            widget.isRequired ? (widget.hintText! + "*") : widget.hintText,
            hintStyle: widget.hintStyle,
            floatingLabelBehavior: widget.hasFloatingPlaceholder
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.never,
            border: widget.noBorder ? _noBorder : _border,
            focusedBorder: widget.noBorder ? _noBorder : _border,
            enabledBorder: widget.noBorder ? _noBorder : _border,
            disabledBorder: widget.noBorder ? _noBorder : _border,
          ),
          style: widget.style ?? const TextStyle(
              color: Colors.white,
              fontSize: 16),
          onSaved: widget.onSaved,
          textInputAction: widget.textInputAction,
          autofocus: widget.autofocus,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          onTap: widget.onTap,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
