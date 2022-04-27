import 'package:bytebank/components/localization/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewI18N {
  late String _language;

  ViewI18N(BuildContext context) {
    _language = BlocProvider.of<CurrentLocateCubit>(context).state;
  }

  localize(Map<String, String> values) {
    assert(values.containsKey(_language));
    return values[_language];
  }
}
