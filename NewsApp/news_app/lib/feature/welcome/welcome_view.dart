import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:news_app/feature/welcome/cubit/location/loc_cubit.dart';
import 'package:news_app/feature/welcome/cubit/location/locstate.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit()..getLocation(),
      child: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          final cubit = LocationCubit.get(context);

          return Scaffold(
            body: Stack(
              children: [
                // ✅ Show GoogleMap when location is ready
                if (state is LocationSuccess)
                  Positioned.fill(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          state.position.latitude,
                          state.position.longitude,
                        ),
                        zoom: 15,
                      ),
                      markers: cubit.markers,
                      onMapCreated: (controller) {
                        cubit.controller.complete(controller);
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
                  ),

                // ✅ White Card
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state is LocationSuccess) ...[
                          Text(
                            '${state.position.latitude}\n${state.position.longitude}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ] else if (state is LocationLoading) ...[
                          const CircularProgressIndicator(),
                        ] else if (state is LocationError) ...[
                          Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],

                        const SizedBox(height: 12),

                        const Text(
                          "From Politics to Entertainment: Your One-Stop Source for Comprehensive Coverage of the Latest News and Developments Across the Globe will be right on your hand.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 20),

                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          onPressed: () {
                            // Navigate or do something
                          },
                          icon: const Icon(Icons.arrow_forward, color: Colors.white),
                          label: const Text(
                            "Explore",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
