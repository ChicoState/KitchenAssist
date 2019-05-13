import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kitchen_assist/Pages/loginPage.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements FirebaseAuth {}

void main() {

  Widget makeTestableWidget({Widget child, FirebaseAuth auth}) {
    return MaterialApp(home: child,);
  }

  testWidgets('Empty Field Log In', (WidgetTester tester) async{
    bool singedIn = false;

    MockAuth mockAuth = MockAuth();
    LoginPage page = LoginPage(onSignedIn: () => singedIn = true);

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
    await tester.tap(find.byKey(Key('signIn')));

    verifyNever(mockAuth.signInWithEmailAndPassword(email:'', password:''));
    expect(singedIn, false);
  });

  testWidgets('Valid Log In', (WidgetTester tester) async{
    bool singedIn = false;
    MockAuth mockAuth = MockAuth();
    LoginPage page = LoginPage(onSignedIn: () => singedIn=true);

    when(mockAuth.signInWithEmailAndPassword(email:'email', password:'password')).thenAnswer((_) => Future.value());

    await tester.pumpWidget(makeTestableWidget(child: page, auth: mockAuth));
    Finder emailField = find.byKey(Key('email'));
    await tester.enterText(emailField, 'email');

    Finder passwordField = find.byKey(Key('password'));
    await tester.enterText(passwordField, 'password');

    await tester.tap(find.byKey(Key('signIn')));

    verify(mockAuth.signInWithEmailAndPassword(email:'email', password:'password')).called(1);
    expect(singedIn, true);
  });

}