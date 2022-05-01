import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contact_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_contact_flow_test.mocks.dart';
import 'utils/matchers.dart';

@GenerateMocks([ContactDAO])
void main() {
  testWidgets('should save a contact', (tester) async {
    // Criando Mock da Lista de Contatos
    final contactDaoMock = MockContactDAO();

    when(contactDaoMock.findAll()).thenAnswer((_) async => []);
    when(contactDaoMock.save(any)).thenAnswer((_) async => 1);

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

    // Checando se existe a Lista de Contatos
    final contactList = find.byType(ContactList);
    expect(contactList, findsOneWidget);

    // Acessando tela de cadastro de contato
    final newContactFAButton =
        find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(newContactFAButton, findsOneWidget);

    await tester.tap(newContactFAButton);
    await tester.pumpAndSettle();

    // Checando se existe a tela de cadastro de contato
    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    // Checando se existem os textField de FullName e AccountNumber e o botão de Create
    final nameTextField = find
        .byWidgetPredicate((widget) => textFieldMatcher(widget, 'Full Name'));
    expect(nameTextField, findsOneWidget);

    final accountNumberTextField = find.byWidgetPredicate(
        (widget) => textFieldMatcher(widget, 'Account Number'));
    expect(accountNumberTextField, findsOneWidget);

    final createRaisedButton = find.widgetWithText(ElevatedButton, 'Create');
    expect(createRaisedButton, findsOneWidget);

    // Preenchendo os textFields e clicando no botão de Create
    await tester.enterText(nameTextField, 'Anonimo');
    await tester.enterText(accountNumberTextField, '9090');
    await tester.tap(createRaisedButton);
    await tester.pumpAndSettle();

    // Checando se voltou para a tela de Lista de Contatos
    final contactListBack = find.byType(ContactList);
    expect(contactListBack, findsOneWidget);
  });
}
