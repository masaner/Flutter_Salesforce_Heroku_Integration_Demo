import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    }
    return '.env.development';
  }

  static String get herokuURL {
    return dotenv.env['heroku_url'] ?? 'heroku_url Not Found';
  }

  static String get instance_url {
    return dotenv.env['instance_url'] ?? 'instance_url Not Found';
  }

  static String get security_token {
    return dotenv.env['security_token'] ?? 'security_token Not Found';
  }

  static String get password {
    return dotenv.env['password'] ?? 'password Not Found';
  }

  static String get username {
    return dotenv.env['username'] ?? 'username Not Found';
  }

  static String get client_secret {
    return dotenv.env['client_secret'] ?? 'client_secret Not Found';
  }

  static String get client_id {
    return dotenv.env['client_id'] ?? 'client_id Not Found';
  }
}
