# 03.3 - Local Secondary Key


1. Clique um 'Create table' e preencha o formulário como na imagem, após clique em '+ Add Index'
![img/localsecondaryindex01.png](img/localsecondaryindex01.png)
2. Preencha o Index com as seguintes informações e clique em 'Add Index'
![img/localsecondaryindex02.png](img/localsecondaryindex02.png)
3. Desmarque as opções de Auto Scalling e deixe o 'Provisioned capacity' como na imagem, e clique em 'Create'
![alt](img/localsecondaryindex03.png)
4. Altere o arquivo 'dynamo.py' para inserir registros na tabela criada como na imagem
![img/localsecondaryindex04.png](img/localsecondaryindex04.png) 
5. Execute o arquivo com `python3 dynamo.py`
![alt](img/localsecondaryindex05.png)
6. Escolha um usuario e um range de um segundo para executar o arquivo 'dynamo.py' como no exemplo
![img/localsecondaryindex06.png](img/localsecondaryindex06.png)
7. execute o comando `python3 dynamo.db`
8. Escolha uma store e altere o arquivo 'dynamo.py'
![img/localsecondaryindex07.png](img/localsecondaryindex07.png)
9. Execute o comando `python3 dynamo.py`