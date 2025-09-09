import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/explore_view/cubit/news_cubit.dart';
import 'package:news_app/features/explore_view/cubit/news_state.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: NewsCubit.get(context),
      child: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          final cubit = NewsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: cubit.searchController,
                decoration: const InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
                onSubmitted: (value) => cubit.getNewsBySearch(value),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                )
              ],
            ),
            body: Column(
              children: [
                // Filters
               

                const SizedBox(height: 12),

                Expanded(
                  child: () {
                    if (state is NewsLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is NewsSuccess) {
                      final articles = state.articlesResponseModels.articles;
                      if (articles == null || articles.isEmpty) {
                        return const Center(child: Text("No results"));
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
