// matching various patterns for kinds of data

class Validator {
  Validator();

  String email(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    var regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Enter a valid email address";
    } else {
      return null;
    }
  }

  String password(String value) {
    Pattern pattern = r'^.{6,}$';
    var regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "enter valid password";
    } else {
      return null;
    }
  }

  String name(String value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    var regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "enter valid name";
    } else {
      return null;
    }
  }

  String number(String value) {
    Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    var regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "enter valid number";
    } else {
      return null;
    }
  }

  String validateMobile(String value) {
    var pattern = r'^(?:[+0]9)?[0-9]{10,12}$'; //^(?:[+0]9)?[0-9]{10,12}$
    var regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String amount(String value) {
    Pattern pattern = r'^\d+$';
    var regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "enter valid amount";
    } else {
      return null;
    }
  }
}
