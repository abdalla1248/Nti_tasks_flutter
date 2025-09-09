import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/explore_view/cubit/news_cubit.dart';
import 'package:news_app/features/explore_view/cubit/news_state.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  final List<String> categories = const ["travel", "technology", "business"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getNews(category: "travel"),
      child: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          final cubit = NewsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text("Explore"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.pushNamed(context, "/search");
                  },
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Tabs
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = cubit.currentCategory == category;

                      return GestureDetector(
                        onTap: () => cubit.getNews(category: category),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Colors.black : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            category[0].toUpperCase() + category.substring(1),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // Articles List
                Expanded(
                  child: () {
                    if (state is NewsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is NewsSuccess) {
                      final articles = state.articlesResponseModels.articles;
                      if (articles == null || articles.isEmpty) {
                        return const Center(child: Text("No articles found"));
                      }
                      return ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return ListTile(
                            leading: article.urlToImage != null
                                ? Image.network(article.urlToImage!,
                                    width: 60, fit: BoxFit.cover)
                                : const Icon(Icons.image),
                            title: Text(article.title ?? ""),
                            subtitle: Text(article.author ?? ""),
                          );
                        },
                      );
                    } else if (state is NewsError) {
                      return Center(child: Text(state.error));
                    } else {
                      return const SizedBox();
                    }
                  }(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
