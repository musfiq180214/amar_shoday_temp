import 'package:amar_shoday/features/landing_2/provider/landing_2_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:amar_shoday/core/routes/route_names.dart';
import 'package:amar_shoday/core/routes/app_router.dart';

class CategoriesWidget extends ConsumerWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      data: (categories) {
        if (categories.isEmpty) {
          return const Center(child: Text('No categories to display'));
        }

        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];

            return InkWell(
              // onTap: () {
              //   if (category.slug != null && category.slug!.isNotEmpty) {
              //     // ✅ Use AppRouter to navigate
              //     Navigator.push(
              //       context,
              //       AppRouter.generateRoute(
              //         RouteSettings(
              //           name: RouteNames.productPage,
              //           arguments: {
              //             'slug': category.slug!,
              //             'name': category.name,
              //           },
              //         ),
              //       ),
              //     );
              //   } else {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(content: Text('Category slug is missing')),
              //     );
              //   }
              // },
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
                                  color: Colors.black,
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
                          color: Colors.black,
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
      error: (err, _) => Center(
        child: Text(
          'Error loading categories: $err',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
