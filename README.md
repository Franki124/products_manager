# products_manager

A new Flutter project for university subject.
Advanced programming technics lab 2.

## Application Summary

Features:

Product management: The app allows users to manage a list of products. This includes adding, updating and deleting products. Firebase integration: The app integrates with Firebase to store and retrieve data. Products are stored in the Firestore database. Sliding list items: The app uses the ListView.builder to display products. Each list item is a Slidable widget, allowing users to perform actions, such as editing or deleting, by swiping on the product items. Form support: Adding and editing products requires filling out a form with details such as product name and price. History tracking: Each product has a history field that tracks creation and update actions with timestamps and details.

Technology and language:

Flutter: The app is built using Flutter, a popular UI toolkit for creating natively compiled mobile, web and desktop applications from a single code base. Dart: Flutter apps are written in Dart, a language optimized for user interface development and developed by Google. Firebase: Firebase is used for backend operations, such as storing and retrieving data. In particular, Firestore, a cloud-based NoSQL database, is used to store product data. Bloc Pattern: The application uses the Bloc pattern for state management, providing a clean separation of business logic and user interface.

Test Summary

Integration tests:

The tests were written using Flutter's integration_test package. The tests simulate user interactions such as pressing buttons, entering text and moving lists
