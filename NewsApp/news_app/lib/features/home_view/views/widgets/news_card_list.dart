import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/features/explore_view/cubit/news_cubit.dart';
import 'package:news_app/features/explore_view/cubit/news_state.dart';
import 'news_card.dart';

class NewsCardList extends StatelessWidget {
  const NewsCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 324.h,
      child: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsSuccess) {
            final articles = state.articlesResponseModels.articles ?? [];
            if (articles.isEmpty) {
              return const Center(child: Text("No popular news found"));
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  articles.length > 5 ? 5 : articles.length, 
              itemBuilder: (context, index) {
                final article = articles[index];
                return NewsCard(
                  imageUrl: article.urlToImage,
                  title: article.title ?? "No Title",
                  subTitle: article.source?.name ?? "Unknown",
                );
              },
            );
          } else if (state is NewsError) {
            return Center(child: Text(state.error));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
