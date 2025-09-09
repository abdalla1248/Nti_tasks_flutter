import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/helper/app_navigator.dart';
import 'package:news_app/core/utils/app_assets.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/core/utils/app_paddings.dart';
import 'package:news_app/features/article_view/cubit/article_cubit.dart';
import 'package:news_app/features/article_view/cubit/article_state.dart';
import 'package:news_app/features/explore_view/data/models/articles_respones_model.dart';

import '../../../feature/bookmark/cubit/bookmark_cubit.dart';

class ArticleView extends StatelessWidget {
  final ArticlesModel articlesModel;

  ArticleView({required this.articlesModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleCubit(),
      child: Scaffold(
        body: BlocBuilder<ArticleCubit, ArticleState>(
          builder: (context, state) {
            return Stack(
              children: [
                Image(
                  width: double.infinity,
                  height: 316.h,
                  fit: BoxFit.fill,
                  image: articlesModel.urlToImage != null &&
                          articlesModel.urlToImage!.isNotEmpty
                      ? NetworkImage(articlesModel.urlToImage!)
                      : AssetImage(AppAssets.articleImage) as ImageProvider,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32.r),
                      ),
                    ),
                    child: Padding(
                      padding: AppPaddings.defaultHomePadding,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    AppNavigator.goBack(context);
                                  },
                                  icon: SvgPicture.asset(
                                    AppAssets.wrapperIcon_2,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        final bookmarkCubit =
                                            BookmarkCubit(); // singleton instance
                                        if (ArticleCubit.get(context).bookMark) {
                                          bookmarkCubit
                                              .removeBookmark(articlesModel);
                                        } else {
                                          bookmarkCubit
                                              .addBookmark(articlesModel);
                                        }
                                        ArticleCubit.get(context)
                                            .changeBookmark();
                                      },
                                      icon: SvgPicture.asset(
                                        ArticleCubit.get(context).bookMark
                                            ? AppAssets.bookmarkIcon
                                            : AppAssets.bookmarkIconUnColor,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: null,
                                      icon: SvgPicture.asset(
                                        AppAssets.wrapperIcon,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              articlesModel.title ?? "",
                              style: TextStyle(
                                fontSize: 32.sp,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.r,
                                  backgroundImage: NetworkImage(
                                    articlesModel.urlToImage ??
                                        AppAssets.personalImage,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(articlesModel.author ?? "Unknown"),
                                Text(" · "),
                                Text(
                                  ArticleCubit.get(context).formatDate(
                                      articlesModel.publishedAt ?? ""),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              articlesModel.content ?? "",
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
