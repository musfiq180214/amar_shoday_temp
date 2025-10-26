import 'package:amar_shoday/features/landing_2/domain/landing_2_model.dart';
import 'package:amar_shoday/features/landing_2/provider/landing_2_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesWidget extends ConsumerWidget {
  const CategoriesWidget({super.key});

  // Static fallback categories
  static final List<Category> staticCategories = [
    Category(name: 'Electronics', logoUrl: null, id: 1),
    Category(name: 'Fashion', logoUrl: null, id: 2),
    Category(name: 'Home', logoUrl: null, id: 3),
    Category(name: 'Books', logoUrl: null, id: 4),
    Category(name: 'Toys', logoUrl: null, id: 5),
    Category(name: 'Sports', logoUrl: null, id: 6),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      data: (categories) {
        final displayCategories =
            categories.isEmpty ? staticCategories : categories;

        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: displayCategories.length,
          itemBuilder: (context, index) {
            final category = displayCategories[index];
            return InkWell(
              onTap: () {
                // Navigate to category page or subcategory screen
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.blue.shade100,
                    child: ClipOval(
                      child: category.logoUrl != null
                          ? Image.network(
                              category.logoUrl!,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text(
                                category.name[0],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black, // forced black
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 20,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        category.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black, // forced black
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) {
        // Show static fallback categories in case of error
        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: staticCategories.length,
          itemBuilder: (context, index) {
            final category = staticCategories[index];
            return InkWell(
              onTap: () {},
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.blue.shade100,
                    child: Center(
                      child: Text(
                        category.name[0],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black, // forced black
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 20,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        category.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black, // forced black
                        ),
                      ),
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
}
