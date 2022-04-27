import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/localization/i18n_messages_cubit.dart';
import 'package:bytebank/components/localization/i18n_messages.dart';
import 'package:bytebank/components/localization/i18n_loading_view.dart';
import 'package:bytebank/http/webclients/i18n_web_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef I18NWidgetCreator = Widget Function(I18NMessages messages);

class I18NLoadingContainer extends BlocContainer {
  final I18NWidgetCreator creator;
  final String viewKey;

  const I18NLoadingContainer(
      {Key? key, required this.viewKey, required this.creator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<I18NMessagesCubit>(
      create: (BuildContext context) {
        final cubit = I18NMessagesCubit(viewKey: viewKey);
        cubit.reload(I18NWebClient(viewKey));
        return cubit;
      },
      child: I18NLoadingView(creator),
    );
  }
}
