import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should display the main image when the dashboard is opened',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets(
      'should display the transfer feature when the dashboard is opened',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
//    final iconTransferFeatureItem =
//        find.widgetWithIcon(FeatureItem, Icons.monetization_on);
//    expect(iconTransferFeatureItem, findsOneWidget);
//    final nameTransferFeatureItem =
//        find.widgetWithText(FeatureItem, 'Transfer');
//    expect(nameTransferFeatureItem, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));

    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets(
      'should display the transaction feed feature when the dashboard is opened',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
//    final iconTransactionFeedFeatureItem =
//        find.widgetWithIcon(FeatureItem, Icons.description);
//    expect(iconTransactionFeedFeatureItem, findsOneWidget);
//    final nameTransactionFeedFeatureItem =
//        find.widgetWithText(FeatureItem, 'Transfer');

    final transactionFeedFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transaction Feed', Icons.description));

    expect(transactionFeedFeatureItem, findsOneWidget);
  });
}

bool featureItemMatcher(widget, String name, IconData icon) {
  if (widget is FeatureItem) {
    return widget.name == name && widget.icon == icon;
  }
  return false;
}
