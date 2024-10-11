import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthHelper {
  static Future<bool> isDeviceSupported(LocalAuthentication auth) {
    return auth.isDeviceSupported().then(
          (value) => value,
        );
  }

  static Future<bool> checkBiometrics(LocalAuthentication auth) async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }

    return canCheckBiometrics;
  }

  static Future<List<BiometricType>> getAvailableBiometrics(
      LocalAuthentication auth) async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }

    return availableBiometrics;
  }

  static Future<bool> authenticateWithBiometrics(
      LocalAuthentication auth) async {
    bool authenticated = false;
    try {
      // setState(() {
      //   _isAuthenticating = true;
      //   _authorized = 'Authenticating';
      // });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      // setState(() {
      //   _isAuthenticating = false;
      //   _authorized = 'Authenticating';
      // });
    } on PlatformException catch (e) {
      print(e);
      // setState(() {
      //   _isAuthenticating = false;
      //   _authorized = 'Error - ${e.message}';
      // });
      return false;
    }
    // if (!mounted) {
    //   return;
    // }
    return authenticated;
    // final String message = authenticated ? 'Authorized' : 'Not Authorized';
    // setState(() {
    //   _authorized = message;
    // });
  }

  static Future<bool> cancelAuthentication(LocalAuthentication auth) async {
    return await auth.stopAuthentication().then(
          (value) => value,
        );
    //  setState(() => _isAuthenticating = false);
  }
}
