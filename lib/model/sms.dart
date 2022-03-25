// TO Send SMS

import 'package:flutter_sms/flutter_sms.dart';
class SMS {
  static void sendMessage() async {
    String message = "OTP is 565594";
    List<String> recipients = ["+918688896210"];
    String _result = await sendSMS(message: message, recipients: recipients).
    catchError((onError) {
      print("Error"+onError);
    });
    print(_result);
  }
}