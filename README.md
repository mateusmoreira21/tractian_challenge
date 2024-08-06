# tractian_challenge

Artigo de detalhamento do desafio: [Tractian Challenge](https://tractian.notion.site/Mobile-Software-Engineer-ff31e345bdd348869d6a8b8ea352a96c)

Para criar um servidor de dados foi utilizado o [Dartion](https://pub.dev/packages/dartion)

- Para iniciar o servidor de dados, siga os passos:

### **Commands**

     2. Activate Dartion using pub:

     ```
     dart pub global activate dartion
     ```


     3. Updates Dartion's version:

     ```
     dartion upgrade
     ```

     4. Start server

     ```
     dartion serve
     ```

- Para realizar as injeções de dependencia e navegação, foi utilizado o [Modular](https://pub.dev/packages/flutter_modular)

- Para controlar os estados, foi utilizado o [Triple](https://pub.dev/packages/flutter_triple)

- Para o cliente HTTP foi utilizado o [Dio](https://pub.dev/packages/dio)

- Para melhor controle e tratativa de erros retornados, foi utilizado o package [Result Dart](https://pub.dev/packages/result_dart)
