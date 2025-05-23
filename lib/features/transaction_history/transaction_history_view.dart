// lib/features/transaction_history/transaction_history_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transaction_history_controller.dart';
import 'transaction_history_detail/transaction_history_detail_view.dart';

class TransactionHistoryView extends StatelessWidget {
  const TransactionHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TransactionHistoryController()..fetchTransactions(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat Transaksi'),
          centerTitle: true,
        ),
        body: Consumer<TransactionHistoryController>(
          builder: (context, controller, _) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.errorMessage != null) {
              return Center(child: Text('Error: ${controller.errorMessage}'));
            }
            if (controller.transactions.isEmpty) {
              return const Center(child: Text('Tidak ada data transaksi.'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.transactions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final tx = controller.transactions[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TransactionHistoryDetailView(transaction: tx),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Row(
                        children: [
                          // Icon/Avatar/ID
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.blue.shade50,
                            child: const Icon(Icons.receipt_long, color: Colors.blue, size: 22),
                          ),
                          const SizedBox(width: 14),
                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ID: ${tx['id'] ?? '-'}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Customer: ${tx['customer']?['nama'] ?? '-'}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          // Total
                          Text(
                            'Rp${tx['totalAmount'] ?? 0}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
