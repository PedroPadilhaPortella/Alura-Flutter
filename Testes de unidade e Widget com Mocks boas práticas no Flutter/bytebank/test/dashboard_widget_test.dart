import 'package:bytebank/components/dashboard_button.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils/matchers.dart';
import 'utils/mocks.dart';

void main() {
  group('When Dashboard is opened', () {
    testWidgets('Should display the Bytebank Image',
        (WidgetTester tester) async {
      final contactDaoMock = ContactDAOMock();
      await tester
          .pumpWidget(MaterialApp(home: Dashboard(contactDAO: contactDaoMock)));
      final mainImage = find.byType(Image);
      expect(mainImage, findsOneWidget);
    });

    testWidgets('Should display the Transfer button', (tester) async {
      final contactDaoMock = ContactDAOMock();
      await tester
          .pumpWidget(MaterialApp(home: Dashboard(contactDAO: contactDaoMock)));
      final transferText = find.widgetWithText(DashboardButton, 'Transfer');
      final transferIcon =
          find.widgetWithIcon(DashboardButton, Icons.monetization_on);
      expect(transferText, findsOneWidget);
      expect(transferIcon, findsOneWidget);
    });

    testWidgets('Should display the Transaction Feed button', (tester) async {
      final contactDaoMock = ContactDAOMock();
      await tester
          .pumpWidget(MaterialApp(home: Dashboard(contactDAO: contactDaoMock)));
      final transactionFeedText =
          find.widgetWithText(DashboardButton, 'Transaction Feed');
      final transactionFeedIcon =
          find.widgetWithIcon(DashboardButton, Icons.description);
      expect(transactionFeedText, findsOneWidget);
      expect(transactionFeedIcon, findsOneWidget);
    });

    testWidgets("Should display the Dashboard's Buttons", (tester) async {
      final contactDaoMock = ContactDAOMock();
      await tester
          .pumpWidget(MaterialApp(home: Dashboard(contactDAO: contactDaoMock)));
      final transferDashboardButton = find.byWidgetPredicate((widget) =>
          dashboardButtonMatcher(widget, 'Transfer', Icons.monetization_on));

      final transactionFeedDashboardButton = find.byWidgetPredicate((widget) =>
          dashboardButtonMatcher(
              widget, 'Transaction Feed', Icons.description));

      expect(transferDashboardButton, findsOneWidget);
      expect(transactionFeedDashboardButton, findsOneWidget);
    });
  });
}
