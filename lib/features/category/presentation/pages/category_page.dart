import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/category_provider.dart';
import '../../domain/entities/category.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({super.key});

  @override
  ConsumerState<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  final _nameController = TextEditingController();
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final user = ref.read(authProvider);

      if (user == null) return;

      await ref.read(categoryProvider.notifier).loadCategories(user.id);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _showCreateCategoryDialog() async {
    final user = ref.read(authProvider);

    if (user == null) return;

    _nameController.clear();

    String type = 'expense';

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                  const Text(
                    'Tambah Kategori',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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

                  const Text(
                    'Jenis',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('Pengeluaran'),

                        selected: type == 'expense',

                        onSelected: (_) {
                          setModalState(() {
                            type = 'expense';
                          });
                        },
                      ),

                      ChoiceChip(
                        label: const Text('Pemasukan'),

                        selected: type == 'income',

                        onSelected: (_) {
                          setModalState(() {
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

                      label: const Text('Simpan Kategori'),

                      onPressed: () async {
                        if (_nameController.text.trim().isEmpty) {
                          return;
                        }

                        await ref
                            .read(categoryProvider.notifier)
                            .createCategory(
                              userId: user.id,
                              name: _nameController.text.trim(),
                              icon: '',
                              color: '',
                              type: type,
                            );

                        if (!context.mounted) {
                          return;
                        }

                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showEditCategoryDialog(Category category) async {
    final user = ref.read(authProvider);

    if (user == null) return;

    _nameController.text = category.name;

    String type = category.type;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                  const Text(
                    'Edit Kategori',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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

                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('Pengeluaran'),
                        selected: type == 'expense',
                        onSelected: (_) {
                          setModalState(() {
                            type = 'expense';
                          });
                        },
                      ),

                      ChoiceChip(
                        label: const Text('Pemasukan'),
                        selected: type == 'income',
                        onSelected: (_) {
                          setModalState(() {
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
                      label: const Text('Simpan Perubahan'),
                      onPressed: () async {
                        await ref
                            .read(categoryProvider.notifier)
                            .updateCategory(
                              userId: user.id,
                              categoryId: category.id,
                              name: _nameController.text.trim(),
                              icon: category.icon,
                              color: category.color,
                              type: type,
                            );

                        if (!context.mounted) {
                          return;
                        }

                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Kategori')),

      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateCategoryDialog,
        child: const Icon(Icons.add),
      ),

      body: ListView.separated(
        padding: const EdgeInsets.all(24),

        itemCount: categories.length,

        separatorBuilder: (_, _) => const SizedBox(height: 12),

        itemBuilder: (context, index) {
          final category = categories[index];

          return Card(
            child: ListTile(
              title: Text(category.name),

              subtitle: Text(category.type),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      _showEditCategoryDialog(category);
                    },
                    icon: const Icon(Icons.edit),
                  ),

                  IconButton(
                    onPressed: () async {
                      final user = ref.read(authProvider);

                      if (user == null) return;

                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Hapus Kategori'),

                            content: Text(
                              'Yakin ingin menghapus kategori "${category.name}"?',
                            ),

                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text('Batal'),
                              ),

                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text('Hapus'),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirm != true) return;

                      await ref
                          .read(categoryProvider.notifier)
                          .deleteCategory(
                            userId: user.id,
                            categoryId: category.id,
                          );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
