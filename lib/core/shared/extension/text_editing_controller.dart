import '../shared.dart';

extension TextEditingControllerExtension on TextEditingController {
  bool get validPassword {
    return text.length >= 6;
  }

  bool get validName {
    return text.length > 1;
  }

  bool get validEmail {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(text);
  }

  bool get validPhone {
    final phoneRegex = RegExp(r"(^([+]{1}[8]{2}|0088)?(01){1}[3-9]{1}\d{8})$");
    return phoneRegex.hasMatch(text);
  }
}

extension PasswordTextEditingControllerExtension on ({TextEditingController password, TextEditingController confirmPassword}) {
  bool get valid {
    if (password.validPassword && confirmPassword.validPassword && password.text.same(as: confirmPassword.text)) {
      return true;
    }
    return false;
  }
}
