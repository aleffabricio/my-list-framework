## Descrição do App
- Aplicação em Flutter que irá sincronizar as listagens da API Rest para o banco local ao iniciar a aplicação.
- API para sincronizar os dados para o App: https://jsonplaceholder.typicode.com/.

## Splash
![Screenshot_1596052251](https://user-images.githubusercontent.com/14118647/88846258-c3114580-d1bb-11ea-883b-7007c95aa6a5.png)

## Tela inicial - Albums

![Screenshot_1596052268](https://user-images.githubusercontent.com/14118647/88846400-f8b62e80-d1bb-11ea-963b-0e540b1a3851.png)

## Tela inicial - Posts

![Screenshot_1596052271](https://user-images.githubusercontent.com/14118647/88846548-2602dc80-d1bc-11ea-9f26-2c001a991b02.png)


## Tela inicial - Todos

![Screenshot_1596052274](https://user-images.githubusercontent.com/14118647/88846764-7417e000-d1bc-11ea-903c-9c3f43aa3620.png)

## Tela inicial - Quando o usuário não possui rede

![Screenshot_1596054179](https://user-images.githubusercontent.com/14118647/88849387-2b622600-d1c0-11ea-9dd3-0b44b4b51ae2.png)


## Como funciona o App ?

- Passo 1 - Na primeira tela ele verifica se o usuário possui rede no momento, caso ela esteja desativada o app irá mostrar uma mensagem solicitando a rede. 
- Passo 2 - Assim que for ativado o app automaticamente irá fazer a consulta no site https://jsonplaceholder.typicode.com/ trazendo as 3 categorias: `Posts, Albums e Todos`. 
- Passo 3 - Caso o usuário já esteja com a rede irá executar já o passo 2.
- Passo 4 - Após a consulta o App irá criar um Json local que se chama `jsonList` e salvará todos os dados trazidos pela consulta na storage do dispositivo, se o app for fechado e aberto novamente ele irá pegar como default o arquivo Json que está salvo local e setará os dados em seguida. 

## Tecnologias usadas

1. Flutter/Dart.
2. Bloc (bloc_pattern) / RxDart - Foi utilizado para gerenciar estado do App.
3. Path provider - Foi utilizado para criar um banco local e guardar o Json das consultas.
4. Connectivity - Usado para testar se o usuário está com rede ou não.
5. Dio - Foi utilizado para fazer todas as requisições do App.

## Versão

- Desenvolvido no  `Android Studio v4.0.1`
- `Versão Flutter v1.17.5`
