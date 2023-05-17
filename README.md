# Welcome to Maintenance To-do list app
Hi! We are a team with the heart to make some little app but be useful. A **Maintenance To-do list** app is one of that. 
It help you to reminder your maintenance task for all your device which you maybe forget that.
If you like our app or idea, you can take a start on this repo. It's as the best encourage for us.

## Process

## Contribute
(phamvmnhut)[github.com/phamvmnhut]

## Thanks for researching for some bug and task
- Change android minSdk
https://stackoverflow.com/questions/52060516/flutter-how-to-change-android-minsdkversion-in-flutter-project
- Multidex bug
https://stackoverflow.com/questions/49886597/multidex-issue-with-flutter

- Search in firebase
https://stackoverflow.com/questions/52627194/search-by-pattern-on-cloud-firestore-collection/52627798#52627798

- Change icon local push notification [size image = 96x96]
https://stackoverflow.com/questions/72541908/how-to-change-local-notification-icon
- Change icon firebase push notification
https://stackoverflow.com/questions/46676014/how-to-change-the-android-notification-icon-status-bar-icon-for-push-notificatio

- flutter_launcher_icons v0.11.0
```
flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icon/app_icon.png"
  adaptive_icon_background: "assets/icon/app_icon.png"
  adaptive_icon_foreground: "assets/icon/app_icon.png"
  min_sdk_android: 21 # android min sdk min:16, default 21
```
```
flutter pub run flutter_launcher_icons
```

- Change package name
https://pub.dev/packages/change_app_package_name
```bash
flutter pub run change_app_package_name:main com.phamvmnhut.maintenance
```