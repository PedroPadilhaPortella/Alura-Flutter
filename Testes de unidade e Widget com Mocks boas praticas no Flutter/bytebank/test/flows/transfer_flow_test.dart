import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/contact_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/matchers.dart';
import 'transfer_flow_test.mocks.dart';

@GenerateMocks([ContactDAO])
@GenerateMocks([TransactionWebClient])
main() {
  late MockContactDAO contactDaoMock;
  late MockTransactionWebClient transactionWebClientMock;

  setUp(() async {
    contactDaoMock = MockContactDAO();
    transactionWebClientMock = MockTransactionWebClient();
  });

  testWidgets('should tranfer to a contact', (tester) async {
    // Criando Mock da Lista de Contatos e Stubs
    const name = 'Anonimo';
    const account = 9090;
    const password = '1000';

    final contact = Contact(id: 0, name: name, accountNumber: account);
    final transaction = Transaction('1', 200, contact);

    when(contactDaoMock.findAll()).thenAnswer((_) async => [contact]);
    when(transactionWebClientMock.save(transaction, password))
        .thenAnswer((_) async => transaction);

    // Instanciando Widget Inicial
    await tester.pumpWidget(ByteBankApp(
      contactDAO: contactDaoMock,
      webClient: transactionWebClientMock,
    ));

    // Checando se existe o dashboard
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    // Acessando tela de listagem de contato
    final transferDashboardButton = find.byWidgetPredicate((widget) =>
        dashboardButtonMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferDashboardButton, findsOneWidget);

    await tester.tap(transferDashboardButton);
    await tester.pumpAndSettle();

    // Checando se o metodo findAll() foi chamado
    verify(contactDaoMock.findAll()).called(1);

    // Checando se existe a Lista de Contatos
    final contactList = find.byType(ContactList);
    expect(contactList, findsOneWidget);

    // Checando se existe o Contato selecionado
    final contactItem =
        find.byWidgetPredicate((widget) => contactItemMatcher(widget, contact));
    expect(contactItem, findsOneWidget);

    // Acessando a tela de transação para este contato
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    // Checando se existe o Formulario de transação
    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    // Checando o nome, a conta e o textField estão de acordo
    final contactName = find.text(name);
    final contactAccountNumber = find.text(account.toString());
    final textFieldValue =
        find.byWidgetPredicate((widget) => textFieldMatcher(widget, 'Value'));

    expect(contactName, findsOneWidget);
    expect(contactAccountNumber, findsOneWidget);
    expect(textFieldValue, findsOneWidget);

    // Preenchendo o textField e clicando no botão
    await tester.enterText(textFieldValue, '200');

    final transferButton = find.widgetWithText(ElevatedButton, 'Transfer');
    expect(transferButton, findsOneWidget);

    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    // Checando se o transactionAuthDialog foi renderizado
    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);

    // Checando se o textField está de acordo, e preenchendo ele
    final passwordTextField = find.byKey(transactionAuthDialogPassword);
    expect(passwordTextField, findsOneWidget);

    await tester.enterText(passwordTextField, password);

    // Checando se os botoões estão de acordo, e clicando no Confirmar
    final cancelButton = find.widgetWithText(TextButton, 'Cancel');
    expect(cancelButton, findsOneWidget);

    final confirmButton = find.widgetWithText(TextButton, 'Confirmar');
    expect(confirmButton, findsOneWidget);

    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    // Checando se o metodo save() foi chamado
    verify(transactionWebClientMock.save(transaction, password)).called(1);

    final contactsListBack = find.byType(ContactList);
    expect(contactsListBack, findsOneWidget);
  });
}
