import 'package:flutter/material.dart';
import '../services/account_service.dart';
import '../models/account.dart';

class AccountForm extends StatefulWidget {
  final Account? account;

  AccountForm({this.account});

  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _balance;

  @override
  void initState() {
    super.initState();
    if (widget.account != null) {
      _name = widget.account!.name;
      _balance = widget.account!.balance;
    } else {
      _name = '';
      _balance = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.account == null ? 'Adicionar Conta' : 'Editar Conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da conta';
                  }
                  return null;
                },
                onChanged: (value) {
                  _name = value;
                },
              ),
              TextFormField(
                initialValue: _balance.toString(),
                decoration: InputDecoration(labelText: 'Saldo'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o saldo da conta';
                  }
                  return null;
                },
                onChanged: (value) {
                  _balance = double.tryParse(value) ?? 0.0;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.account == null ? 'Adicionar' : 'Salvar'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final account = Account(name: _name, balance: _balance);
                    if (widget.account == null) {
                      await AccountService().createAccount(account);
                    } else {
                      await AccountService().updateAccount(
                        account.copyWith(id: widget.account!.id),
                      );
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
