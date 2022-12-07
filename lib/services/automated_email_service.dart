import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  static sendEmail({
   required String email,
   required String message,
   required String subject,
  }) async {
    var url = Uri.parse('https://sygenmw.com/sygen_email_api.php');
    await http.post(url, headers: {
      'accept': 'application/json',
    }, body: {
      "title": "$subject",
      "pass": "2119",
      "destination": "$email",
      "message": "$message"
    }).then((response) {
      print(jsonDecode(response.body)[0]['result']);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
