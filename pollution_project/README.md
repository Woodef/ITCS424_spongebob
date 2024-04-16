# Measuring air pollution project (Air pollution system)

This project is a part of ITCS424: Wireless and Mobile Computing.

Members (Section 3):  
- Jiraruch Tantiyavarong 6488100  
- Warittha Tarntong 6488130  
- Warintorn Jirathipwanglad 6488152  
- Tayapa Santipap 6488187  

## Setting up

Assumed: Flutter is installed in your system.

To set up API key:
1. Create `.env` in the root directory of your local project
2. Use the API key provided in the report. 
3. If the provided key doesn't work, get your AirVisual API from (https://dashboard.iqair.com/auth/sign-in?redirectURL=%2Fpersonal%2Fapi-keys)
    - If you don't have an account, you have to sign up for free to get the API.
4. Inside `.env`, add your API key as follows `apiKey=<YOUR_API_KEY>`

## Running the application
1. Navigate to your local project's root directory and run `flutter run`.

## Using the application

Users can try to log in without registering using the following credentials:  
Account 1  
- email: test2@gmail.com  
- password: 123456  

Account 2  
- email: john.doe@gmail.com  
- password: 123456  

## Important notes

This project is unstable due to API limitations. 

If the user encounters errors, the user could refresh the Flutter application on your IDE or text editor (on VS code, press 'R' on the terminal).

If the error persists, the user may wait for a while and retry the application again.