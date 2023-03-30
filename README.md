
# Password manager mini project


## How to run




You can check the running project on the following link: lazyhome.dk.
Or you can run the project on Android or IOS with Android studio after you downloded the flutter sdk and framework.

## How to use

You can store password locally on the phone and you can sync the password with another device and you can get a strong password suggestion.

- To store a password just type in the password and the website where the password belongs in the 'password' and 'website' textfield.

- To sync the passwords with another device you need to upload the local passwords to the cloud by clicking on the 'upload local passwords to cloud' button. After that you need to type in on the new device the 'location' and the 'encryption key' from the old device. Finally just press the 'sync with the cloud' button.

- To get a strong password suggestion just press the 'suggest a strong password' button.

- To check the local password just press the 'show local passwords' button.


## Screenshots


<img width="1428" alt="Screenshot 2023-03-30 at 17 28 34" src="https://user-images.githubusercontent.com/44951484/228887101-09d7dbde-c29c-4555-8c79-a488ab020dbd.png">



<img width="1434" alt="Screenshot 2023-03-30 at 17 30 34" src="https://user-images.githubusercontent.com/44951484/228887525-c9938ba8-6fb5-40bc-9911-f3ba5e13f0f9.png">


<img width="1434" alt="Screenshot 2023-03-30 at 17 38 18" src="https://user-images.githubusercontent.com/44951484/228889806-c7ba1ae4-4ca0-4106-bad9-eb964723a3ee.png">



![Screenshot_20230330_173229](https://user-images.githubusercontent.com/44951484/228890291-d6c7440c-7cfc-4ed0-a871-d9ef2ca50a82.jpg)



![Screenshot_20230330_173239](https://user-images.githubusercontent.com/44951484/228890828-e6f29e75-d2fc-45fe-9861-c4dedd73cdc3.jpg)


## Security

password_manager uses the flutter_secure_storage. This will use different security measures on each platform.

### Android

On Android the package utilizes a native library called EncryptedSharedPreferences. EncryptedSharedPreferences uses AES encryption to ensure maximum security. This library will store every value in an encrypted key-value store.

### Web
flutter_secure_storage uses an experimatal project called WebCrypto. The intent is that the browser is creating the private key, and as a result, the encrypted strings in local_storage are not portable to other browsers or other machines and will only work on the same domain. As it is an experimental project is is advised by the creators to use it at your own risk, as there could be unknown vulnerabilities.

### Our approach
The biggest security threat is when a user wants to syncronize their passwords accross multiple devices. Our approach to solve this problem is to upload the encrypted passwords to a secure cloud hosted database (Cloud Firestore by Google). When the user uploads the passwrods to the database the application will create a one-time location string and an encryption key and displays it on the device's screen. These credentials are only available during the application's runtime, this way nobody can get their hands on them in rest. 
When we are downloading the passwords from another device, we give the app the one-time location string and an encryption key. This way the data will be encrypted in the cloud, encrypted in transit and will only be decrypted once arrived to the user's application. 

This approach guarantees that only people who see the original device's screen can syncronize the passwords.






