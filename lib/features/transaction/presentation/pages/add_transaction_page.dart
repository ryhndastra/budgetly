import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/enums/transaction_type.dart';

class AddTransactionPage extends StatefulWidget {
  final TransactionType type;
  const AddTransactionPage({super.key, required this.type});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedCategory = 'Makanan';

  final _currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  void _formatAmount() {
    final text = _amountController.text;

    if (text.isEmpty) return;

    final numbersOnly = text.replaceAll(RegExp(r'[^0-9]'), '');

    if (numbersOnly.isEmpty) {
      _amountController.clear();
      return;
    }

    final value = int.parse(numbersOnly);

    final formatted = _currencyFormatter.format(value);

    _amountController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_formatAmount);
  }

  @override
  void dispose() {
    _amountController.removeListener(_formatAmount);

    _amountController.dispose();
    _titleController.dispose();
    _noteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = widget.type == TransactionType.income;

    final categories = isIncome
        ? const ['Gaji', 'Freelance', 'Bonus', 'Investasi']
        : const ['Makanan', 'Transport', 'Belanja', 'Tagihan'];

    return Scaffold(
      appBar: AppBar(
        title: Text(isIncome ? 'Tambah Pemasukan' : 'Tambah Pengeluaran'),
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: AppButton(
          label: isIncome ? 'Simpan Pemasukan' : 'Simpan Pengeluaran',
          icon: Icons.check,
          onPressed: () {},
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nominal',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

            Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme: const InputDecorationTheme(
                  filled: false,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(hintText: 'Rp 0'),
              ),
            ),

            const SizedBox(height: 8),

            Center(
              child: Container(
                width: 160,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            
            const SizedBox(height: 36),

            AppTextField(
              label: 'Nama Transaksi',
              hintText: isIncome
                  ? 'Contoh: Gaji Bulanan'
                  : 'Contoh: Makan Siang',
              controller: _titleController,
            ),

            const SizedBox(height: 28),

            const Text(
              'Kategori',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((category) {
                final selected = _selectedCategory == category;

                return ChoiceChip(
                  label: Text(category),

                  selected: selected,

                  onSelected: (_) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },

                  selectedColor: AppColors.primary,

                  backgroundColor: AppColors.surface,
                );
              }).toList(),
            ),

            const SizedBox(height: 28),

            AppTextField(
              label: 'Catatan',
              hintText: 'Tambahkan catatan...',
              controller: _noteController,
              maxLines: 4,
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
