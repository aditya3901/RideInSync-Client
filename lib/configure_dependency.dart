import 'package:get_it/get_it.dart';
import 'package:rideinsync_client/services/booking_service.dart';
import 'package:rideinsync_client/services/cloudinary_service.dart';
import 'package:rideinsync_client/services/common_auth_service.dart';
import 'package:rideinsync_client/services/firebase_service.dart';
import 'package:rideinsync_client/services/google_location_service.dart';

final locator = GetIt.instance;

void configureDependency() {
  locator.registerLazySingleton<CommonAuthService>(
    () => CommonAuthService(),
  );
  locator.registerLazySingleton<FirebaseService>(
    () => FirebaseService(),
  );
  locator.registerLazySingleton<CloudinaryService>(
    () => CloudinaryService(),
  );
  locator.registerLazySingleton<GoogleLocationService>(
    () => GoogleLocationService(),
  );
  locator.registerLazySingleton<BookingService>(
    () => BookingService(),
  );
}
