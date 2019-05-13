import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kitchen_assist/Pages/ListPage.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements FirebaseAuth {}

void main() {

  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(home: child,);
  }

  testWidgets('', (WidgetTester tester) async{
    ListPage page = ListPage();
    await tester.pumpWidget(makeTestableWidget(child: page));
    ListPageState pageState = page.createState();
    pageState.addFoodTest('item');
    expect(pageState.foods.length, 1);
  });
}
