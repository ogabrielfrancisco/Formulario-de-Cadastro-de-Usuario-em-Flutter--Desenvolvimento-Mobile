# Formulário de Cadastro de Usuário em Flutter

Atividade prática de Desenvolvimento Mobile: tela de cadastro de usuário com
`Form` + `TextFormField`, filtros de entrada, validação campo a campo e
feedback visual com `SnackBar`.

> **Aviso de autoria:** o código deste projeto (`lib/`, `test/`, configuração e
> este README) foi escrito pelo **Claude** (assistente de IA da Anthropic), a
> pedido do aluno, por meio do Claude Code.

## Funcionalidades

| Campo            | Teclado (`keyboardType`) | Filtro (`inputFormatters`)          | Validação                                   |
| ---------------- | ------------------------ | ----------------------------------- | ------------------------------------------- |
| Nome completo    | `name`                   | —                                   | Obrigatório                                 |
| E-mail           | `emailAddress`           | Bloqueia espaços                    | Obrigatório, contém `@`, formato via RegExp |
| CPF              | `number`                 | `digitsOnly`, máx. 11 dígitos       | Obrigatório, só números, 11 dígitos         |
| Telefone         | `phone`                  | `digitsOnly`, máx. 11 dígitos       | Obrigatório, só números, 10–11 dígitos      |
| Senha            | `visiblePassword`        | —                                   | Obrigatória, mínimo de 6 caracteres         |
| Confirmar senha  | `visiblePassword`        | —                                   | Obrigatória, igual à senha                  |

- O botão **CADASTRAR** chama `_formKey.currentState!.validate()`.
- Os erros aparecem logo abaixo de cada campo inválido.
- Com tudo válido, aparece um **SnackBar verde** de sucesso e o formulário é limpo.

### Desafio extra (implementado)

- [x] Campo de confirmação de senha
- [x] Botão para mostrar/ocultar a senha
- [x] Validação de e-mail com `RegExp`
- [x] SnackBar de erro em vermelho quando há campos inválidos

## Estrutura da tela

```
Scaffold
└── Form(key: _formKey)
    └── SingleChildScrollView (padding: 16)
        └── Column
            ├── TextFormField (nome)
            ├── TextFormField (e-mail)
            ├── TextFormField (CPF)
            ├── TextFormField (telefone)
            ├── TextFormField (senha)
            ├── TextFormField (confirmar senha)
            └── ElevatedButton (CADASTRAR)
```

Os campos são separados por `SizedBox(height: 16)`.

## Como executar

O repositório contém apenas o código Dart (`lib/`, `test/`, `pubspec.yaml`).
Gere as pastas de plataforma (android, ios, web…) uma única vez e rode:

```bash
flutter create .
flutter pub get
flutter run
```

Para rodar os testes de widget:

```bash
flutter test
```

## Arquivos principais

- `lib/main.dart` — app e tela de cadastro (`CadastroPage`)
- `test/widget_test.dart` — testes da validação, dos filtros e do SnackBar
