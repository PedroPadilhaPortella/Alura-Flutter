import 'package:bytebank/components/error/error_view.dart';
import 'package:bytebank/components/localization/i18n_loading_container.dart';
import 'package:bytebank/components/localization/i18n_messages_cubit.dart';
import 'package:bytebank/components/localization/i18n_messages_state.dart';
import 'package:bytebank/components/progress/progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class I18NLoadingView extends StatelessWidget {
  final I18NWidgetCreator creator;

  const I18NLoadingView(this.creator, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
      builder: (context, state) {
        if (state is InitI18NMessagesState ||
            state is LoadingI18NMessagesState) {
          return const ProgressView(
              message: 'Starting...', title: 'Initializing your App');
        }
        if (state is LoadedI18NMessagesState) {
          final messages = state.messages;
          return creator.call(messages);
        }
        return const ErrorView('Something went wrong.');
      },
    );
  }
}
