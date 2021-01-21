# vehicle_management_system

- first run the below commands to redirect the phone's desired port to the PC's desired port

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
final String url = "http://0.0.0.0:8000";
```

- now run the below command to access the pdf reports. this should be run inside the hms folder (web app)

```php
php -S 0.0.0.0:8001
```

## the above url is for real devices only. for emultors its different.

### Now run the application. It should work 

* and when adding the path, just add the php file name without /s *

