<h1 align="center">Welcome to Flutter Vehicle Management System 👋</h1>

<p align="center">
  <img src="https://img.shields.io/badge/version-1.0.0.-blue.svg?cacheSeconds=2592000" />
  <a>
    <img alt="Documentation" src="https://img.shields.io/badge/documentation-yes-brightgreen.svg" target="_blank" />
  </a>
  <a>
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" target="_blank" />
  </a>
  <a href="http://makeapullrequest.com">
    <img alt="PRs welcome: alianilkocak" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" target="_blank" />
  </a>
  <a href="https://linkedin.com/in/harshana-rathnayaka">
  <img alt="LinkedIn" src="https://img.shields.io/badge/-LinkedIn-black.svg?&logo=linkedin&colorB=555" />
  </a>
</p>

***Star ⭐ the repo if you like what you see. 😎***

> ***A Hospital Management System made with Flutter to help you make doctor's appointments and lab appointments during this Covid-19 Era.***

## 👷‍♂️ Built With

* [Flutter](https://flutter.dev)
* [PHP](https://www.php.net/)
* [Stripe API](https://stripe.com/en-gb-us)

## ✨ Requirements
* Any Operating System (ie. MacOS X, Linux, Windows)
* Any IDE with Flutter SDK installed (ie. IntelliJ, Android Studio, VSCode etc.)
* A little knowledge of Dart and Flutter

## 🔨 Installation
- Follow the below steps to get up and running
- Run the following `commands` inside Visual Studio Code or any other IDE which has a terminal or you can just use `cmd`

> 👯 Clone the repository

- Clone this repo to your local machine using `https://github.com/Harshana-Rathnayaka/Hospital-Management-System-Mobile-App`

```shell

$ git clone https://github.com/Harshana-Rathnayaka/Covid19-Tracker

```

> 🏃‍♂️ Run and test the application
- Run the following commands to run and test the application in an emulator or a real device

```dart

$ flutter pub get
$ flutter run

```

- This application's backend is written in pure `PHP` and it does not include a `REST Api`. Therefore, the application should be able to access the PC's localhost.
- Connect your device to the PC and run the below commands to redirect the device's desired port to the PC's desired port. This will grant the device access to the PC's localhost. This works on both real devices as well as emulators.
- `ADB` tools must be installed in your PC for this to work.

```bash
adb reverse tcp:8000 tcp:8000
adb reverse tcp:8001 tcp:8001
```
> *Port 8000 is used to access the general backend. Port 8001 is used to access the PDF files which are stored in the PC. These are uploaded from the web application.*

- Two seperate server instances will have to be running in order to access the general backend as well as the PDF files.
- Therefore, you need to navigate to the folder where you have stored the backend script. 

```bash
cd path/folder-name
```

- Open up `cmd` or `PowerShell` and run the below command to server the `API`.
- This will serve the `PHP API` on port 8000 of your PC.

```php
php -S 0.0.0.0:8000
```

- Now go to the folder where you have stored the web application files. 
- Note that there is a folder called `lab-reports`. This is where all the lab reports are stored in.
- Open up `cmd` or `PowerShell` and run the below command to serve the `API` for 

```php
php -S 0.0.0.0:8001
```

> ℹ Additional information
- The above steps will work fine if you are using a real device. However, if you want to use an emulator, follow these additional steps to setup the environment properly.
- Open up the cloned repository in your desired IDE and locate the `NetworkHelper.dart` file.
- Find the following lines,

```dart
  // for real device
  final String url = "http://0.0.0.0:8000/api";

  // for emulator
  final String url = "http://10.0.2.2:8000/api";
```

> *Real devices reffer to the `localhost` as `0.0.0.0`. Emulators reffer to the `localhost` as `10.0.2.2`.*

- By default, the application is set to be run on a real device. Therefore, the URL for the emulator localhost has been commented out. 
- Uncomment it and comment the URL for the local device and run the application on an emulator.
- Also, remember to run the previously mentioned `ADB` commands before running the application on an emulator.
- Change this URL setting whenever you want to run on a real device or an emulator.

- The above URL change should be done in the `LabReports.dart` file as well.
- Locate the following code within the file.

```dart
  // for real device
  final String pdfBaseUrl = 'http://0.0.0.0:8001/lab-reports';

  // for emulator
  final String pdfBaseUrl = 'http://10.0.2.2:8001/lab-reports';
```

- Again the URL for emulators will be commented out by default. Uncomment it to access the `PDF` files from the emulator.
- Sometimes the emulator might not be able to access the PDF files.
- Disable the `proxy` from the emulator if that happens and apply `No Proxy` setting.
- Then the application will work without any error but sometimes it might display a `connection closed` error randomly.



