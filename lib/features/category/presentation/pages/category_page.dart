import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/category_tile.dart';
import '../widgets/category_form_sheet.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/category_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Kategori')),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const CategoryFormSheet(),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: ListView.separated(
        padding: const EdgeInsets.all(24),

        itemCount: categories.length,

        separatorBuilder: (_, _) => const SizedBox(height: 12),

        itemBuilder: (context, index) {
          final category = categories[index];

          return CategoryTile(
            category: category,

            onEdit: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => CategoryFormSheet(category: category),
              );
            },

            onDelete: () async {
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
                  .deleteCategory(userId: user.id, categoryId: category.id);
            },
          );
        },
      ),
    );
  }
}
