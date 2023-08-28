import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:driver_app/constants/color.dart';
import 'package:driver_app/constants/radius.dart';
import 'package:driver_app/constants/spaces.dart';
import 'package:driver_app/controller/hudController.dart';
import 'package:driver_app/controller/isOtpInvalidController.dart';
import 'package:driver_app/functions/authFunctions.dart';
import 'package:driver_app/providerClass/providerData.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:visibility_aware_state/visibility_aware_state.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPInputField extends StatefulWidget {
  String _verificationCode = '';
  // String autoVerificationCode = '';

  OTPInputField(this._verificationCode);
  @override
  _OTPInputFieldState createState() => _OTPInputFieldState();
}

class _OTPInputFieldState extends State<OTPInputField> {
  HudController hudController = Get.put(HudController());
  AuthService authService = AuthService();
  IsOtpInvalidController isOtpInvalidController =
      Get.put(IsOtpInvalidController());
  TextEditingController textEditingController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: PinCodeTextField(
        cursorColor: Colors.black,
        appContext: context,
        controller: textEditingController,
        pastedTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          activeFillColor: Colors.white,
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          selectedFillColor: Colors.white,
          selectedColor: Colors.black,
          inactiveFillColor: Colors.white,
          fieldHeight: 48,
          fieldWidth: 48,
        ),
        length: 6,
        enableActiveFill: true,
        keyboardType: TextInputType.phone,
        onCompleted: (pin) {
          hudController.updateHud(true);
          providerData.updateSmsCode(pin);
          // isOtpInvalidController.updateIsOtpInvalid(false);
          authService.manualVerification(
              smsCode: providerData.smsCode,
              verificationId: widget._verificationCode);

          providerData.updateInputControllerLengthCheck(true);
          providerData.clearAll();
        },
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }
}
