import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/error.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/webclients/i18n_web_client.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationContainer extends BlocContainer {
  final Widget child;

  const LocalizationContainer({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CurrentLocateCubit(),
      child: child,
    );
  }
}

class CurrentLocateCubit extends Cubit<String> {
  CurrentLocateCubit() : super('en');
}

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

class I18NMessages {
  final Map<String, dynamic> _messages;

  I18NMessages(this._messages);

  String get(String key) {
    assert(_messages.containsKey(key));
    return _messages[key]!;
  }
}

@immutable
abstract class I18NMessagesState {
  const I18NMessagesState();
}

@immutable
class InitI18NMessagesState extends I18NMessagesState {
  InitI18NMessagesState();
}

@immutable
class LoadingI18NMessagesState extends I18NMessagesState {
  LoadingI18NMessagesState();
}

@immutable
class LoadedI18NMessagesState extends I18NMessagesState {
  final I18NMessages _messages;
  LoadedI18NMessagesState(this._messages);
}

@immutable
class FatalErrorI18NMessagesState extends I18NMessagesState {
  FatalErrorI18NMessagesState();
}

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  I18NMessagesCubit() : super(InitI18NMessagesState());

  reload(I18NWebClient client) {
    emit(LoadingI18NMessagesState());
    client.findAll().then((messages) {
      emit(LoadedI18NMessagesState(I18NMessages(messages)));
    });
  }
}

typedef I18NWidgetCreator = Widget Function(I18NMessages messages);

class I18NLoadingContainer extends BlocContainer {
  final I18NWidgetCreator creator;

  I18NLoadingContainer({required this.creator}) : super();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<I18NMessagesCubit>(
      create: (BuildContext context) {
        final cubit = I18NMessagesCubit();
        cubit.reload(I18NWebClient());
        return cubit;
      },
      child: I18NLoadingView(creator),
    );
  }
}

class I18NLoadingView extends StatelessWidget {
  final I18NWidgetCreator creator;
  I18NLoadingView(this.creator);

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
          final messages = state._messages;
          return creator.call(messages);
        }
        return const ErrorView('Something went wrong.');
      },
    );
  }
}
