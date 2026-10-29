import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Usuário',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  bool _ocultarSenha = true;
  bool _ocultarConfirmacao = true;

  // E-mail no formato usuario@dominio.ext
  static final _emailRegExp = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  // ---------- Validadores ----------

  String? _validarNome(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe o nome completo';
    }
    return null;
  }

  String? _validarEmail(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe o e-mail';
    }
    if (!valor.contains('@')) {
      return 'O e-mail deve conter @';
    }
    if (!_emailRegExp.hasMatch(valor.trim())) {
      return 'Informe um e-mail válido (ex: nome@dominio.com)';
    }
    return null;
  }

  String? _validarCpf(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'Informe o CPF';
    }
    if (!RegExp(r'^\d+$').hasMatch(valor)) {
      return 'O CPF deve conter apenas números';
    }
    if (valor.length != 11) {
      return 'O CPF deve ter 11 dígitos';
    }
    return null;
  }

  String? _validarTelefone(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'Informe o telefone';
    }
    if (!RegExp(r'^\d+$').hasMatch(valor)) {
      return 'O telefone deve conter apenas números';
    }
    if (valor.length < 10) {
      return 'O telefone deve ter 10 ou 11 dígitos (com DDD)';
    }
    return null;
  }

  String? _validarSenha(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'Informe a senha';
    }
    if (valor.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }
    return null;
  }

  String? _validarConfirmacaoSenha(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'Confirme a senha';
    }
    if (valor != _senhaController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  // ---------- Ações ----------

  void _cadastrar() {
    FocusScope.of(context).unfocus();
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    if (_formKey.currentState!.validate()) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Usuário ${_nomeController.text.trim()} cadastrado com sucesso!',
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      _formKey.currentState!.reset();
      _nomeController.clear();
      _emailController.clear();
      _cpfController.clear();
      _telefoneController.clear();
      _senhaController.clear();
      _confirmarSenhaController.clear();
    } else {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Corrija os campos destacados antes de continuar.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                key: const Key('campoNome'),
                controller: _nomeController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: _validarNome,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('campoEmail'),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'nome@dominio.com',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: _validarEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('campoCpf'),
                controller: _cpfController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  hintText: 'Apenas números',
                  prefixIcon: Icon(Icons.badge),
                ),
                validator: _validarCpf,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('campoTelefone'),
                controller: _telefoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  hintText: 'DDD + número, apenas números',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: _validarTelefone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('campoSenha'),
                controller: _senhaController,
                obscureText: _ocultarSenha,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  helperText: 'Mínimo de 6 caracteres',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    tooltip: _ocultarSenha ? 'Mostrar senha' : 'Ocultar senha',
                    icon: Icon(
                      _ocultarSenha ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () =>
                        setState(() => _ocultarSenha = !_ocultarSenha),
                  ),
                ),
                validator: _validarSenha,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('campoConfirmarSenha'),
                controller: _confirmarSenhaController,
                obscureText: _ocultarConfirmacao,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _cadastrar(),
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    tooltip: _ocultarConfirmacao
                        ? 'Mostrar senha'
                        : 'Ocultar senha',
                    icon: Icon(
                      _ocultarConfirmacao
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => setState(
                      () => _ocultarConfirmacao = !_ocultarConfirmacao,
                    ),
                  ),
                ),
                validator: _validarConfirmacaoSenha,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                key: const Key('botaoCadastrar'),
                onPressed: _cadastrar,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'CADASTRAR',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
