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

- first run the below commands to redirect the phone's desired port to the PC's desired port
== you need to install ADB tools from android studio for this to work

```bash
adb reverse tcp:8000 tcp:8000
adb reverse tcp:8001 tcp:8001
```

### 8000 to access the API. 8001 to access the PDF files stored in the web application folder
- then navigate to your api folder location

```bash
cd path/folder-name
```

- now run the below command to serve the api

```php
php -S 0.0.0.0:8000
```

- in the app go to *NetwrokHelper.dart* and check if the below line exists. if not add it

```dart
final String url = "http://0.0.0.0:8000/api";
```

- now run the below command to access the pdf reports. this should be run inside the hms folder (web app)

```php
php -S 0.0.0.0:8001
```

## the above url is for real devices only.
### use the following if you want to test on emulators

```dart
final String url = "http://10.0.2.2:8000/api";
```

### this url should also be changed in the LabReports.dart page

## if you are running this on emlators, disable the proxy from emulator settings and apply No Proxy setting. 
## the app will work but it will display 'connection closed' error randomly. 

# Now run the application. It should work 


