import 'package:bytebank/components/localization/i18n_messages.dart';
import 'package:bytebank/components/localization/i18n_messages_state.dart';
import 'package:bytebank/http/webclients/i18n_web_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  final LocalStorage storage = LocalStorage('bytebank_v3');
  final String viewKey;
  I18NMessagesCubit({required this.viewKey})
      : super(const InitI18NMessagesState());

  reload(I18NWebClient client) async {
    emit(const LoadingI18NMessagesState());
    await storage.ready;

    if (storage.getItem(viewKey) != null) {
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
