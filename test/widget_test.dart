import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:formulario_cadastro/main.dart';

Future<void> _tocarCadastrar(WidgetTester tester) async {
  final botao = find.byKey(const Key('botaoCadastrar'));
  await tester.ensureVisible(botao);
  await tester.tap(botao);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('exibe erros quando os campos estão vazios', (tester) async {
    await tester.pumpWidget(const MeuApp());

    await _tocarCadastrar(tester);

    expect(find.text('Informe o nome completo'), findsOneWidget);
    expect(find.text('Informe o e-mail'), findsOneWidget);
    expect(find.text('Informe o CPF'), findsOneWidget);
    expect(find.text('Informe o telefone'), findsOneWidget);
    expect(find.text('Informe a senha'), findsOneWidget);
    expect(
      find.text('Corrija os campos destacados antes de continuar.'),
      findsOneWidget,
    );
  });

  testWidgets('CPF e telefone aceitam somente números', (tester) async {
    await tester.pumpWidget(const MeuApp());

    await tester.enterText(find.byKey(const Key('campoCpf')), '12a.345-67b');
    await tester.enterText(find.byKey(const Key('campoTelefone')), '(11) 9x99');

    expect(find.text('1234567'), findsOneWidget);
    expect(find.text('11999'), findsOneWidget);
  });

  testWidgets('valida e-mail sem @ e senha curta', (tester) async {
    await tester.pumpWidget(const MeuApp());

    await tester.enterText(find.byKey(const Key('campoEmail')), 'gabriel.com');
    await tester.enterText(find.byKey(const Key('campoSenha')), '123');
    await tester.enterText(
      find.byKey(const Key('campoConfirmarSenha')),
      '456',
    );
    await _tocarCadastrar(tester);

    expect(find.text('O e-mail deve conter @'), findsOneWidget);
    expect(find.text('A senha deve ter no mínimo 6 caracteres'), findsOneWidget);
    expect(find.text('As senhas não coincidem'), findsOneWidget);
  });

  testWidgets('mostra SnackBar de sucesso com dados válidos', (tester) async {
    await tester.pumpWidget(const MeuApp());

    await tester.enterText(find.byKey(const Key('campoNome')), 'Gabriel Vaz');
    await tester.enterText(
      find.byKey(const Key('campoEmail')),
      'gabriel@email.com',
    );
    await tester.enterText(find.byKey(const Key('campoCpf')), '12345678901');
    await tester.enterText(
      find.byKey(const Key('campoTelefone')),
      '11999998888',
    );
    await tester.enterText(find.byKey(const Key('campoSenha')), 'senha123');
    await tester.enterText(
      find.byKey(const Key('campoConfirmarSenha')),
      'senha123',
    );
    await _tocarCadastrar(tester);

    expect(
      find.text('Usuário Gabriel Vaz cadastrado com sucesso!'),
      findsOneWidget,
    );
  });
}
