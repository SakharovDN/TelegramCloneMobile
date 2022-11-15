import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:telegram_clone/domain/dto/sign_in_request_dto.dart';
import 'package:telegram_clone/domain/exceptions/api_exception.dart';

class AuthService {
  Future<String?> signIn(String email, String password) async {
    try {
      final url = Uri.parse('${dotenv.get('API_HOST')}/auth/signIn');
      final response = await post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(SignInRequest(email: email, password: password)),
      );

      switch (response.statusCode) {
        case 403:
          throw ApiException(ApiExceptionType.notVerified);
        case 404:
          throw ApiException(ApiExceptionType.notFound);
        case 405:
          throw ApiException(ApiExceptionType.wrongPassword);
        case 422:
        case 500:
          throw ApiException(ApiExceptionType.other);
      }

      final json = jsonDecode(response.body);
      return json['token'];
    } on SocketException {
      throw ApiException(ApiExceptionType.network);
    } on ApiException {
      rethrow;
    } catch (_) {
      throw ApiException(ApiExceptionType.other);
    }
  }
}
