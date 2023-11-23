import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../shared/local/shared_pref.dart';
import '../../data/models/TransactionModel.dart';

class WalletBloc extends Cubit<WalletState> {
  WalletBloc() : super(WalletState());

  void sendFunds(String recipient, String sender, double amount) {
    final transaction = Transaction(
      id: UniqueKey().toString(),
      date: DateTime.now(),
      sender: sender,
      receiver: recipient,
      amount: amount,
    );

    final updatedTransactions = List<Transaction>.from(state.transactions)
      ..insert(0, transaction);

    emit(state.copyWith(
      transactions: updatedTransactions,
      balance: state.balance - amount,
    ));
  }

  void resetListTitle() {
    emit(state.copyWith(transactions: []));
  }

  void resetBalance() {
    emit(state.copyWith(balance: 100));
  }
}

Future<double> getBalance() async {
  String? balanceString = await CacheData.getData("balance");
  if (balanceString != null) {
    double balance = double.parse(balanceString);
    return balance;
  } else {
    return 0.0;
  }
}

class WalletState {
  final List<Transaction> transactions;
  final double balance;

  WalletState({this.transactions = const [], this.balance = 100});

  WalletState copyWith({
    List<Transaction>? transactions,
    double? balance,
  }) {
    return WalletState(
      transactions: transactions ?? this.transactions,
      balance: balance ?? this.balance,
    );
  }
}
