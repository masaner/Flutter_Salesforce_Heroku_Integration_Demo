---
layout: default
title: Apex Code
nav_order: 8
has_children: true
permalink: /docs/apex-code
---

# Apex Code

{: .fs-6 .fw-300 }

## Important Info to Fill in Flutter App
See .env.example as an example. Make sure to change the name of your .env file after updating it.
Or you can just return 

```dart
static String get fileName {
    return '.env.example'
}
```

## environment.dart
```dart
static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    }
    return '.env.development';
  }
```
## .env.example
```
client_id ='********************'
client_secret ='*******************'
username = '******@email.com'
password = '***************'
security_token = '***************'
instance_url = 'https://*******.my.salesforce.com'
```

