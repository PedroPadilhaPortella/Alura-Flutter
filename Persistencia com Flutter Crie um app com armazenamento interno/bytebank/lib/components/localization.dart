import 'package:bytebank/components/container.dart';
import 'package:bytebank/components/error.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/webclients/i18n_web_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

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
  const InitI18NMessagesState();
}

@immutable
class LoadingI18NMessagesState extends I18NMessagesState {
  const LoadingI18NMessagesState();
}

@immutable
class LoadedI18NMessagesState extends I18NMessagesState {
  final I18NMessages _messages;
  const LoadedI18NMessagesState(this._messages);
}

@immutable
class FatalErrorI18NMessagesState extends I18NMessagesState {
  const FatalErrorI18NMessagesState();
}

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  final LocalStorage storage = LocalStorage('bytebank_v3');
  final String viewKey;
  I18NMessagesCubit({required this.viewKey})
      : super(const InitI18NMessagesState());

  reload(I18NWebClient client) async {
    emit(const LoadingI18NMessagesState());
    await storage.ready;

    if (storage.getItem(viewKey) != null) {
      print('nao chamou api');
      final items = storage.getItem(viewKey);
      emit(
          LoadedI18NMessagesState(I18NMessages(items as Map<String, dynamic>)));
    } else {
      client.findAll().then((messages) {
        storage.setItem(viewKey, messages);
        emit(LoadedI18NMessagesState(I18NMessages(messages)));
      }).catchError((e) {
        emit(const FatalErrorI18NMessagesState());
      });
    }
  }
}

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
          final messages = state._messages;
          return creator.call(messages);
        }
        return const ErrorView('Something went wrong.');
      },
    );
  }
}
