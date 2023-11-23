import 'package:block_chain/login/presentation/pages/login.dart';
import 'package:block_chain/shared/local/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/wallet_bloc.dart';

class WalletScreen extends StatefulWidget {
  static const String routeName = "blockScreen";

  WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with TickerProviderStateMixin {
  final TextEditingController amountController = TextEditingController();

  final TextEditingController recipientController = TextEditingController();

  final TextEditingController senderController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        animationBehavior: AnimationBehavior.preserve);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletBloc(),
      child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                InkWell(
                    onTap: () {
                      CacheData.removeData("token");
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.routeName, (route) => false);
                    },
                    child: Row(
                      children: [
                        Text('Balance: \$${state.balance}',
                            style: const TextStyle(fontSize: 17)),
                        const SizedBox(width: 10),
                        const Icon(Icons.logout),
                        const SizedBox(width: 10),
                      ],
                    ))
              ],
              title: const Text('Blockchain Wallet'),
            ),
            body: BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 1.0),
                        end: const Offset(0.0, 0.0),
                      ).animate(_animationController),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Display list of transactions
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(20)),
                            height: 300,
                            child: ListView.builder(
                              itemCount: state.transactions.length,
                              itemBuilder: (context, index) {
                                final transaction = state.transactions[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("transition ${index + 1} :"),
                                      ListTile(
                                        title: Text('ID: ${transaction.id}'),
                                        subtitle: Text(
                                          'Date: ${transaction.date.toString()}\n'
                                          'Sender: ${transaction.sender}\n'
                                          'Receiver: ${transaction.receiver}\n'
                                          'Amount: \$${transaction.amount}',
                                        ),
                                      ),
                                      const Divider(thickness: 3),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          // Form for sending funds
                          TextFormField(
                            controller: senderController,
                            validator: (value) {
                              if (value == null || value == "") {
                                return "can not be empty";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Sender Address'),
                          ),
                          TextFormField(
                            controller: recipientController,
                            validator: (value) {
                              if (value == null || value == "") {
                                return "can not be empty";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Recipient Address'),
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value == "") {
                                return "can not be empty";
                              }
                              bool validateStructure(String value) {
                                String pattern = r"^[0-9]*$";
                                RegExp regExp = RegExp(pattern);
                                return regExp.hasMatch(value);
                              }

                              if (!validateStructure(value)) {
                                return "accept only numbers";
                              }

                              return null;
                            },
                            controller: amountController,
                            decoration:
                                const InputDecoration(labelText: 'Amount'),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<WalletBloc>().sendFunds(
                                    recipientController.text,
                                    senderController.text,
                                    double.parse(amountController.text));
                              }
                              recipientController.text = "";
                              amountController.text = "";
                              senderController.text = "";
                            },
                            child: const Text('Send Funds'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<WalletBloc>().resetListTitle();
                            },
                            child: const Text('reset'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<WalletBloc>().resetBalance();
                            },
                            child: const Text('reset balance'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
