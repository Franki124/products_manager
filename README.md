# products_manager

A new Flutter project for university subject.
Advanced programming technics lab 2.

## Sprawozdanie
Podsumowanie aplikacji

Cechy:

Zarządzanie produktami: Aplikacja umożliwia użytkownikom zarządzanie listą produktów. Obejmuje to dodawanie, aktualizowanie i usuwanie produktów.
Integracja z Firebase: Aplikacja integruje się z Firebase w celu przechowywania i pobierania danych. Produkty są przechowywane w bazie danych Firestore.
Przesuwane elementy listy: Aplikacja wykorzystuje konstruktor ListView.builder do wyświetlania produktów. Każdy element listy jest widżetem Slidable, umożliwiającym użytkownikom wykonywanie czynności, takich jak edycja lub usuwanie, przesuwając palcem po elementach produktu.
Obsługa formularzy: Dodawanie i edytowanie produktów wymaga wypełnienia formularza ze szczegółami takimi jak nazwa i cena produktu.
Śledzenie historii: Każdy produkt ma pole historii, które śledzi akcje tworzenia i aktualizacji ze znacznikami czasu i szczegółami.

Technologia i język:

Flutter: Aplikacja została zbudowana przy użyciu Flutter, popularnego zestawu narzędzi UI do tworzenia natywnie kompilowanych aplikacji mobilnych, internetowych i desktopowych z jednej bazy kodu.
Dart: Aplikacje Flutter są napisane w Dart, języku zoptymalizowanym do tworzenia interfejsów użytkownika i opracowanym przez Google.
Firebase: Do operacji backendowych, takich jak przechowywanie i pobieranie danych, używana jest baza Firebase. W szczególności Firestore, baza danych NoSQL w chmurze, służy do przechowywania danych produktów.
Bloc Pattern: Aplikacja wykorzystuje wzorzec Bloc do zarządzania stanem, zapewniając czyste oddzielenie logiki biznesowej od interfejsu użytkownika.

Podsumowanie testów

Testy integracyjne:

Testy zostały napisane przy użyciu pakietu integration_test Fluttera.
Testy symulują interakcje użytkownika, takie jak naciskanie przycisków, wprowadzanie tekstu i przesuwanie list
