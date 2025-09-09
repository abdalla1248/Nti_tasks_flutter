import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:news_app/core/utils/app_assets.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/core/utils/app_paddings.dart';
import 'package:news_app/core/widget/navigator_bar.dart';
import 'package:news_app/features/splash_view/views/widgets/default_form_field.dart';
import '../../../core/helper/app_navigator.dart';
import '../cubit/search_cubt/location_cubit.dart';
import '../cubit/search_cubt/location_state.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit()..getLocation(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          children: [
            SizedBox(height: 80.h),
            Padding(
              padding: AppPaddings.defaultThirdHomePadding,
              child: DefaultFormField(
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppAssets.profileIcon),
                ),
                controller: TextEditingController(),
                hintText: "Name",
              ),
            ),
            SizedBox(height: 34.h),
            BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state is LocationLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is LocationSuccess) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: 758.h,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              state.position.latitude,
                              state.position.longitude,
                            ),
                            zoom: 5,
                          ),
                          markers: LocationCubit.get(context).markers,
                        ),
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              AppNavigator.goTo(
                                context,
                                NavigatorBar(),
                                type: NavigatorType.pushReplacement,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonPrimary,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Get Started",
                                  style: TextStyle(color: AppColors.primary),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 34.h),
                        ],
                      ),
                    ],
                  );
                } else if (state is LocationError) {
                  return Text(state.error);
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
