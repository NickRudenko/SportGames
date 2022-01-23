# SportGames

This project is app for sport games review. Currectly it include only one screen with List of sport categories. It was prepared good foundation for colaborationg with API. Also code can be easy covered with unit tests because of all models cover protocols and could be replaced with mock objects. API request and model context also can be easy replaced with mock object and covered with tests.

Used achitecture is MVVM. It was selected because it require not a lot of time to implement, but it make all code more testable.
Unit tests can be written later, but it is easy to cover ViewController and ViewModel by test if MVVM architecture was selected, and all functionality does not depends on each other.

Dependencies:
Dependencies were added with SPM(Swift Package Manager). It helps easier to manage added dependencies and it is easier to understand what happens when you debugging your code.

Fetch - Hides the boilerplate code. Fetch allows you to make protocol-based HTTP requests, whilst providing a custom class or struct capable of parsing the response in to model objects your app can understand. 
Source: https://github.com/dhardiman/Fetch

Bond - is a Swift binding framework that takes binding concepts to a whole new level. It’s simple, powerful, type-safe and multi-paradigm - just like Swift.
Source: https://github.com/DeclarativeHub/Bond

How to launch:
1) Install and launch latest Xcode (version 13.2.1)
2) Clone an existing project using repository url (https://github.com/NickRudenko/SportGames/tree/main)
3) Build and run app.
