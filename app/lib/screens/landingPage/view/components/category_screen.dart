import 'package:app/screens/landingPage/model.dart/category_model.dart';
import 'package:app/screens/landingPage/viewModel/landing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideCategorySection extends StatelessWidget {
  const RideCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LandingProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.grey,));
    }

    if (provider.categories.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Choose Ride",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: provider.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final category = provider.categories[index];

                return _CategoryItem(category: category);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final CategoryModel category;

  const _CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
     
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 55,
          
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(category.file, fit: BoxFit.cover),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            category.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
