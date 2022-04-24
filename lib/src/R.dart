import 'package:flutter/material.dart';
import 'package:flutter_app/generated/l10n.dart';

class R {
  static late BuildContext _context;
  static S current = S.of(_context);

  static set(BuildContext setContext) {
    _context = setContext;
  }

  static load(Locale locale) {
    S.delegate.load(locale);
  }
}
