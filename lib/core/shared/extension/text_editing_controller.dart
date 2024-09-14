import '../shared.dart';

extension TextEditingControllerExtension on TextEditingController {
  bool get validPassword {
    return text.length >= 6;
  }

  bool get validName {
    return text.length > 1;
  }

  bool get validEmail {
    return text.length > 1;
  }

  bool get validPhone {
    return text.length > 1;
  }
}

extension PasswordTextEditingControllerExtension on ({
  TextEditingController password,
  TextEditingController confirmPassword
}) {
  bool get valid {
    if (password.validPassword &&
        confirmPassword.validPassword &&
        password.text.like(text: confirmPassword.text)) {
      return true;
    }
    return false;
  }
}
