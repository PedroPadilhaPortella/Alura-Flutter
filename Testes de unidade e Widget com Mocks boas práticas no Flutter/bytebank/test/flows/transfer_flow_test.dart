import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../utils/matchers.dart';
import 'save_contact_flow_test.mocks.dart';

@GenerateMocks([ContactDAO])
main() {
  late MockContactDAO contactDaoMock;

  setUp(() async {
    contactDaoMock = MockContactDAO();
  });

  testWidgets('should tranfer to a contact', (tester) async {
    // Criando Mock da Lista de Contatos e Stubs
    const name = 'Anonimo';
    const account = 9090;
    final contact = Contact(id: 0, name: name, accountNumber: account);
    when(contactDaoMock.findAll()).thenAnswer((_) async => [contact]);

    // Instanciando Widget Inicial
    await tester.pumpWidget(ByteBankApp(contactDAO: contactDaoMock));

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
  });
}
