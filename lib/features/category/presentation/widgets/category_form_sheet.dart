import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/category.dart';
import '../providers/category_provider.dart';

class CategoryFormSheet extends ConsumerStatefulWidget {
  final Category? category;

  const CategoryFormSheet({super.key, this.category});

  @override
  ConsumerState<CategoryFormSheet> createState() => _CategoryFormSheetState();
}

class _CategoryFormSheetState extends ConsumerState<CategoryFormSheet> {
  final _nameController = TextEditingController();

  late String type;

  bool get isEdit => widget.category != null;

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.category?.name ?? '';

    type = widget.category?.type ?? 'expense';
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final user = ref.read(authProvider);

    if (user == null) return;

    final notifier = ref.read(categoryProvider.notifier);

    if (isEdit) {
      await notifier.updateCategory(
        userId: user.id,
        categoryId: widget.category!.id,
        name: _nameController.text.trim(),
        icon: widget.category!.icon,
        color: widget.category!.color,
        type: type,
      );
    } else {
      await notifier.createCategory(
        userId: user.id,
        name: _nameController.text.trim(),
        icon: '',
        color: '',
        type: type,
      );
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            isEdit ? 'Edit Kategori' : 'Tambah Kategori',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 24),

          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nama Kategori',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          const Text('Jenis', style: TextStyle(fontWeight: FontWeight.w600)),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Pengeluaran'),
                selected: type == 'expense',
                onSelected: (_) {
                  setState(() {
                    type = 'expense';
                  });
                },
              ),

              ChoiceChip(
                label: const Text('Pemasukan'),
                selected: type == 'income',
                onSelected: (_) {
                  setState(() {
                    type = 'income';
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,

            child: FilledButton.icon(
              icon: const Icon(Icons.check),

              label: Text(isEdit ? 'Simpan Perubahan' : 'Simpan Kategori'),

              onPressed: _save,
            ),
          ),
        ],
      ),
    );
  }
}
