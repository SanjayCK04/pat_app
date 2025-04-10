part of 'common_widgets.dart';

Widget makeInputBox(
  String label,
  TextEditingController controller,
  BuildContext context, {
  String? hint,
  TextInputType? inputType,
  bool isPassword = false,
  String? passwordReplacement,
  Widget? visibilityButton,
  bool? shouldObscureText = false,
  bool isError = false,
  String? errorText,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: getWidth(10)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          style: TextStyle(
            color: Colors.white,
            fontSize: getHeight(20),
            fontFamily: freedoka,
          ),
          expands: false,
          maxLines: 1,
          cursorColor: Colors.white.withAlpha(200),
          cursorWidth: getWidth(0.5),
          controller: controller,
          textAlignVertical: TextAlignVertical.top,
          keyboardType: inputType ?? TextInputType.text,
          obscureText: shouldObscureText ?? isPassword,
          obscuringCharacter: passwordReplacement ?? '*',
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: getWidth(20),
              vertical: getHeight(15),
            ),
            filled: true,
            fillColor: inputBoxColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(getWidth(10)),
              borderSide: BorderSide(
                color: isError ? Colors.red : inputBoxColor, 
                width: getWidth(isError ? 1 : 0)
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(getWidth(10)),
              borderSide: BorderSide(
                color: isError ? Colors.red : inputBoxColor, 
                width: getWidth(isError ? 1 : 0)
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: makeText(
              label,
              context,
              color: Colors.white.withAlpha((0.8 * 255).floor()),
              size: 20,
              weight: FontWeight.w300,
            ),
            border: InputBorder.none,
            hintText: hint ?? label,
            hintStyle: TextStyle(
              color: Colors.white.withAlpha((0.8 * 255).floor()),
              fontSize: getHeight(20),
              fontWeight: FontWeight.w300,
              fontFamily: freedoka,
            ),
            suffixIcon: visibilityButton,
          ),
        ),
        if (isError && errorText != null)
          Padding(
            padding: EdgeInsets.only(left: getWidth(20), top: getHeight(5)),
            child: Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
                fontSize: getHeight(12),
                fontFamily: freedoka,
              ),
            ),
          ),
      ],
    ),
  );
}
