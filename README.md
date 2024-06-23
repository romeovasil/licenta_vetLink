VetLink - Soluție software pentru conectarea veterinarilor cu iubitorii de animale

Pentru a rula aplicatia web sunt necesare urmatoarele: 
  - Node.js și npm (Node Package Manager)
  - Angular CLI
  - JDK 11 sau o versiune ulterioară
  - Apache Maven
  - PostgreSQL
  - IntelliJ


Partea de frontend se poate rula folosind urmatoarele comenzii in ordine intr-un IDE (ex IntelliJ
  npm install
  ng serve



Partea de backend are nevoie de configurarea bazei de date local folosind urmatoarele date :
    url: jdbc:postgresql://localhost:5432/lic_vetlink
    password: vetlink
    username: vetlink

Serverul de backend poate fi pornit ruland urmatoarele comenzi:
    mvn clean install
    mvn spring-boot:run



Pentru aplicatia mobila sunt necesare:
  - o versiune de flutter
  - Xcode (pentru simulator de iPhone)
  - Android Studio

Pentru a putea rula aplicatia mobila trebuie pornit un simulator (de ios/android) si rulata comanda urmatoare:
  flutter run 

