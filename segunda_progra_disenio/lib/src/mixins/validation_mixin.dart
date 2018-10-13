class ValidationMixin {
  
  String validateEmail(String value) {
        if (!value.contains('@') || !value.contains('.com')){
          return 'Please enter a valid email!';
        }

        return null;
      }

  String validatePass(String value) {
        if (value.length < 8 || !value.contains(new RegExp(r'[0-9]'))){
          return 'Password must be at least 8 characters and 1 number!';
        }

        return null;
      }

  String validateNull(String value){
    if (!(value.length > 0)){
      return 'Fill all the fields with data.';
    }

    return null;
  }
}