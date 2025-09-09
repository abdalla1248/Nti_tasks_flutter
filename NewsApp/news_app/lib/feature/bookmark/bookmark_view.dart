import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/helper/app_navigator.dart';
import 'package:news_app/core/utils/app_assets.dart';
import 'package:news_app/feature/bookmark/cubit/bookmark_cubit.dart';
import 'package:news_app/features/article_view/views/article_view.dart';
import 'package:news_app/features/explore_view/data/models/articles_respones_model.dart';

class BookmarkView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: Builder(
        builder: (context) {
          return BlocBuilder<BookmarkCubit, List<ArticlesModel>>(
            builder: (context, bookmarks) {
              if (bookmarks.isEmpty) {
                return const Center(
                  child: Text('No bookmarks yet!'),
                );
              }
          
              return Builder(
                builder: (context) {
                  return ListView.builder(
                    itemCount: bookmarks.length,
                    itemBuilder: (context, index) {
                      final article = bookmarks[index];
                  
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          onTap: () {
                            AppNavigator.goTo(
                              context,
                              ArticleView(articlesModel: article),
                            );
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: article.urlToImage != null &&
                                    article.urlToImage!.isNotEmpty
                                ? Image.network(
                                    article.urlToImage!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    AppAssets.articleImage,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          title: Text(
                            article.title ?? 'No Title',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            article.description ?? 'No Description',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              context.read<BookmarkCubit>().removeBookmark(article);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              );
            },
          );
        }
      ),
    );
  }
}
