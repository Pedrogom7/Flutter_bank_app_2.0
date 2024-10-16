import 'package:flutter/material.dart';
import 'account_form.dart';
import '../services/account_service.dart';
import '../models/account.dart';

class AccountList extends StatefulWidget {
  @override
  _AccountListState createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  List<Account> _accounts = [];

  @override
  void initState() {
    super.initState();
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    final accounts = await AccountService().getAccounts();
    setState(() {
      _accounts = accounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contas'),
      ),
      body: ListView.builder(
        itemCount: _accounts.length,
        itemBuilder: (context, index) {
          final account = _accounts[index];
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Color(0xFF2C2C2C),
            elevation: 5,
            child: ListTile(
              title: Text(account.name, style: TextStyle(fontSize: 18)),
              subtitle:
                  Text('Saldo: R\$ ${account.balance.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountForm(account: account),
                    ),
                  );
                  _loadAccounts();
                },
              ),
              onTap: () {
                // Ação para visualizar detalhes
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountForm()),
          );
          _loadAccounts();
        },
      ),
    );
  }
}
