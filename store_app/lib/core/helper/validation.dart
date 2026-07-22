class Validations {
  static bool isEmailValid(String email) {
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );
    return emailRegExp.hasMatch(email);
  }

  static bool isPhoneValid(String phone) {
    final RegExp phoneRegExp = RegExp(r'^01(?:1|2|0|5)\d{8}$');
    return phoneRegExp.hasMatch(phone);
  }

  static String? phoneNumberVaildtor(String? phoneNumber, context) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return "Phone Number Must Be Greater than 11";
    }
    if (phoneNumber.length < 10) {
      return "Phone Number Must Be Greater than 11";
    }
    return null;
  }

  static String? passwordVaildtor(
    String? vlaue,
    context, {
    bool lengthValidation = true,
  }) {
    if (vlaue!.isEmpty) {
      "Please Enter Your Password ";
    }
    if (lengthValidation && vlaue.length < 8) {
      return "Password Must be Greater Than 8 Chrachter";
    }
    return null;
  }

  static String? confirmPasswordVaildtor(
      {String? password, String? value, context}) {
    if (value != password) {
      return "Password Must Be Similar ";
    }
    return null;
  }

  static String? displayNameValidator(String? displayName, context) {
    if (displayName == null || displayName.isEmpty) {
      return "Enter Your Name ";
    }
    return null;
  }
}
