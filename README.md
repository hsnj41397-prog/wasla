# وصلة WASLA — Flutter starter

This is an interactive UI prototype, not a production ride-hailing service.

## Included
- Rider/captain role selection
- Ride request screen
- Motorcycle/car pricing rules:
  - Motorcycle: 5 EGP/km, minimum 20 EGP
  - Car: 10 EGP/km, minimum 40 EGP
- Optional fare increase in 5 EGP increments (never below fair fare)
- Captain mock request screen

## Build an Android APK
1. Install Flutter SDK and Android Studio (Android SDK).
2. Unzip this project.
3. In the project folder run:
   `flutter pub get`
   `flutter run`
4. To build a release APK:
   `flutter build apk --release`
5. APK output:
   `build/app/outputs/flutter-apk/app-release.apk`

## Not yet connected
Real maps/geocoding, GPS, authentication/OTP, backend/database, push notifications,
payments, trip dispatch, driver verification, admin dashboard, and production security.
