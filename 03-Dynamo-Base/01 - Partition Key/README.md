# 03.1 - Partition key


1. Acesse o [console do dynamoDB](https://us-east-1.console.aws.amazon.com/dynamodbv2/home?region=us-east-1#dashboard)
2. Clique em 'Criar Tabela' no lado direito da tela
![img/partitionkey01.png](img/partitionkey01.png)
3. Preencha os dados de `Detalhes da tabela` como na imagem abaixo:
       1. Nome da tabela: 'book'
       2. Chave de partição: 'book_id' (String)
   
    ![img/partitionkey02.png](img/partitionkey02.png)

4. Mantenha todos os demais parametros como padrão e clique em 'Criar Tabela'
   
   ![img/pk3.png](img/pk3.png)

<blockquote>
A imagem exibida mostra um formulário para a criação de uma tabela no Amazon DynamoDB com diversas opções de configuração. Aqui estão os detalhes de cada campo:

#### 1. **Configurações Padrão da Tabela**
   - **Configuração Padrão**: Esta é a opção recomendada para criar uma tabela de maneira rápida. Permite ajustar configurações posteriormente, se necessário.
   - **Personalizar Configurações**: Caso precise de configurações avançadas, esta opção permite ajustes detalhados conforme suas necessidades específicas.

#### 2. **Configurações Padrão da Tabela**
   Esta seção fornece as configurações padrão da nova tabela que será criada:

   - **Classe da tabela**: Define a classe de armazenamento da tabela. No exemplo, está definida como **DynamoDB Standard**, que é a classe padrão de armazenamento do DynamoDB.
     - *Editável após a criação*: Sim

   - **Modo de Capacidade**: Define o modo de capacidade da tabela, que pode ser **Provisionada** ou **Sob demanda**. No exemplo, está como *Provisionada*.
     - *Editável após a criação*: Sim

   - **Capacidade de Leitura Provisionada**: Determina a quantidade de unidades de capacidade de leitura provisionada para a tabela, medida em **RCU** (Read Capacity Units). No exemplo, está configurado como **5 RCU**.
     - *Editável após a criação*: Sim

   - **Capacidade de Gravação Provisionada**: Define a quantidade de unidades de capacidade de gravação provisionada, medida em **WCU** (Write Capacity Units). No exemplo, está configurado como **5 WCU**.
     - *Editável após a criação*: Sim

   - **Auto Scaling**: Indica se o recurso de auto scaling (escalabilidade automática) está ativado para ajustar automaticamente a capacidade provisionada da tabela com base no uso.
     - *Editável após a criação*: Sim

   - **Índices Secundários Locais**: Permite definir índices secundários locais na tabela, que utilizam a chave de particionamento da tabela.
     - *Editável após a criação*: Não

   - **Índices Secundários Globais**: Permite definir índices secundários globais para a tabela, que podem utilizar chaves de particionamento e de classificação diferentes.
     - *Editável após a criação*: Sim

   - **Gerenciamento de Chaves de Criptografia**: Determina a propriedade e o gerenciamento das chaves de criptografia. No exemplo, está configurado como **Propriedade do Amazon DynamoDB**.
     - *Editável após a criação*: Sim

   - **Proteção Contra Exclusão**: Quando ativada, impede a exclusão acidental da tabela. No exemplo, está configurada como **Desativada**.
     - *Editável após a criação*: Sim

   - **Política Baseada em Recursos**: Permite definir políticas baseadas em recursos para controlar o acesso à tabela. No exemplo, está definido como **Não ativo**.
     - *Editável após a criação*: Sim

#### 3. **Tags**
   - As tags são pares de chave/valor opcionais que podem ser atribuídos à tabela para fins de categorização, gerenciamento de custos e controle de acesso. Permite adicionar até **50 tags** para a tabela.

#### 4. **Ações Disponíveis**
   - **Adicionar nova tag**: Botão que permite adicionar novas tags ao recurso.
   - **Criar tabela**: Botão para confirmar a criação da tabela com as configurações especificadas.

</blockquote>


1. A tabela pode levar alguns minutos para ser criada. Aguarde.
2. De volta ao cloud9 acesse a pasta com os scripts a serem utilizados: `cd ~/environment/fiap-cloud-computing-tutorials/03-Dynamo-Base`
3. Abra o arquivo dynamo-PK-1.py utilizando o comando `c9 open dynamo-PK-1.py`

![img/pk1.png](img/pk1.png)

8. Antes de executar o script garanta que o boto3 está instalado. Execute o comando `pip3 install boto3`

9.  Utilizando esse script você vai inserir 3 Items com o mesma PK na tabela. Execute o comando `python3 dynamo-PK-1.py`

<blockquote>
O código apresentado é uma implementação de operações básicas no Amazon DynamoDB usando a biblioteca **Boto3**, que é a biblioteca oficial da AWS para interagir com seus serviços em Python. Abaixo, está a explicação detalhada do código, sua funcionalidade e o que ele resulta.

### Explicação do Código

1. **Importação de Módulos**:
   ```python
   import boto3
   from boto3.dynamodb.conditions import Key
   from baseDAO import BaseDAO
   import random
   from datetime import datetime
   ```
   - **boto3**: Biblioteca oficial da AWS para Python que permite interagir com vários serviços AWS, incluindo DynamoDB.
   - **boto3.dynamodb.conditions.Key**: Importa uma classe que facilita a criação de condições para consultas de chaves no DynamoDB.
   - **baseDAO**: Importa a classe `BaseDAO` do módulo `baseDAO`. O código dessa classe lida com operações básicas do DynamoDB, como `put_item`, `get_item`, etc.
   - **random** e **datetime**: Bibliotecas padrão do Python para geração de números aleatórios e manipulação de datas e horários, respectivamente.

2. **Instância do `BaseDAO`**:
   ```python
   dao = BaseDAO('book')
   ```
   Aqui, é criada uma instância de `BaseDAO`, associada a uma tabela DynamoDB chamada `'book'`. Isso sugere que a classe `BaseDAO` foi projetada para interagir com uma tabela específica, cujo nome é passado como argumento ao instanciar a classe.

3. **Inserção de Itens (put_item)**:
   ```python
   dao.put_item({'book_id':'111', 'name': 'teste1'})
   dao.put_item({'book_id':'111', 'name': 'teste1'})
   dao.put_item({'book_id':'111', 'name': 'teste1', 'year': 1999})
   ```
   As três linhas de código utilizam um método chamado `put_item` da instância `dao` para inserir ou atualizar itens na tabela `'book'` do DynamoDB.

   - Cada chamada ao método `put_item` passa um dicionário Python representando os atributos do item a ser salvo na tabela. Esses dicionários possuem chaves e valores que correspondem às colunas e valores da tabela no DynamoDB.
   - **`put_item`** é uma função comum no DynamoDB usada para criar ou atualizar um item. Se um item com a mesma chave primária (neste caso, `book_id`) já existir, ele será substituído.

### Funcionamento Detalhado de Cada Chamada ao `put_item`

1. **Primeira chamada**:
   ```python
   dao.put_item({'book_id':'111', 'name': 'teste1'})
   ```
   - Cria um item com `book_id` igual a `'111'` e `name` igual a `'teste1'`.
   - Como não é especificado outro atributo, apenas esses dois campos estarão presentes no item.

2. **Segunda chamada**:
   ```python
   dao.put_item({'book_id':'111', 'name': 'teste1'})
   ```
   - Tenta criar um item com os mesmos valores da primeira chamada.
   - Como o `book_id` é uma chave primária, e ela já existe na tabela, o DynamoDB irá substituir o item existente por este novo, o que resultará na mesma situação que a primeira chamada.

3. **Terceira chamada**:
   ```python
   dao.put_item({'book_id':'111', 'name': 'teste1', 'year': 1999})
   ```
   - Novamente, tenta criar um item com `book_id` igual a `'111'`, `name` igual a `'teste1'`, mas desta vez com um atributo adicional chamado `year` definido como `1999`.
   - Como o `book_id` é uma chave primária, esta chamada irá substituir o item existente na tabela (aquele criado anteriormente) e adicionará o novo campo `year`.

### Resultado Final

No final do código, o item na tabela `'book'` terá os seguintes atributos:
- **`book_id`: `'111'`**
- **`name`: `'teste1'`**
- **`year`: `1999`**

Isso ocorre porque o DynamoDB usa a chave primária (neste caso, `book_id`) para identificar exclusivamente os itens. Quando uma nova chamada a `put_item` é feita com a mesma chave primária, ele substitui o item existente.

### Resumo

- O código cria um item na tabela `'book'` usando o método `put_item`.
- Como todas as três chamadas usam o mesmo `book_id` como chave primária, o item é substituído a cada chamada.
- O resultado final é um item com `book_id = '111'`, `name = 'teste1'`, e `year = 1999`.

Isso demonstra uma maneira básica de usar o Boto3 e classes personalizadas para interagir com o DynamoDB. Caso precise de detalhes adicionais sobre a implementação da classe `BaseDAO`, isso exigiria a visualização do código dessa classe.
</blockquote>

10. Abra uma nova aba no navegador para visualizar os [itens na tabela book](https://us-east-1.console.aws.amazon.com/dynamodbv2/home?region=us-east-1#item-explorer?maximize=true&operation=SCAN&table=book)

![img/partitionkey04.png](img/partitionkey04.png)

11.  Abra o arquivo dynamo-PK-2.py utilizando o comando `c9 open dynamo-PK-2.py`

![img/pk2.png](img/pk2.png)

12.  Esse script também vai inserir 3 itens na tabela, porém com PKs diferentes. `python3 dynamo-PK-2.py`

<blockquote>
O código apresentado é uma implementação que insere itens em uma tabela chamada **`book`** no Amazon DynamoDB usando a biblioteca **Boto3**. Vamos detalhar como ele funciona, suas etapas e os resultados esperados.

### Explicação do Código

1. **Inserção de Itens (put_item)**:
   ```python
   dao.put_item({'book_id': '111', 'name': 'teste1'})
   dao.put_item({'book_id': '112', 'name': 'teste1'})
   dao.put_item({'book_id': '113', 'name': 'teste1', 'year': 1999})
   ```
   As três linhas de código utilizam um método chamado `put_item` da instância `dao` para inserir itens na tabela `'book'` do DynamoDB.

   - Cada chamada ao método `put_item` passa um dicionário Python representando os atributos do item a ser salvo na tabela. Esses dicionários possuem chaves e valores que correspondem aos atributos da tabela no DynamoDB.
   - **`put_item`** é uma função comum no DynamoDB usada para criar ou atualizar um item. Se um item com a mesma chave primária (neste caso, `book_id`) já existir, ele será substituído.

### Funcionamento Detalhado de Cada Chamada ao `put_item`

1. **Primeira chamada**:
   ```python
   dao.put_item({'book_id': '111', 'name': 'teste1'})
   ```
   - Cria um item com `book_id` igual a `'111'` e `name` igual a `'teste1'`.
   - Como não há outro atributo especificado, apenas esses dois campos estarão presentes no item.

2. **Segunda chamada**:
   ```python
   dao.put_item({'book_id': '112', 'name': 'teste1'})
   ```
   - Cria um novo item com `book_id` igual a `'112'` e `name` igual a `'teste1'`.
   - Como o `book_id` é uma chave primária, esta chamada criará um novo item na tabela sem afetar o item anterior, pois possui um `book_id` diferente.

3. **Terceira chamada**:
   ```python
   dao.put_item({'book_id': '113', 'name': 'teste1', 'year': 1999})
   ```
   - Cria um novo item com `book_id` igual a `'113'`, `name` igual a `'teste1'`, e um atributo adicional chamado `year` definido como `1999`.
   - Como o `book_id` é uma chave primária e é único, um novo item será adicionado à tabela sem afetar os anteriores.

### Resultado Final

Após a execução do código, a tabela **`book`** terá três itens distintos, com os seguintes atributos:

1. **Item 1**:
   - `book_id`: `'111'`
   - `name`: `'teste1'`

2. **Item 2**:
   - `book_id`: `'112'`
   - `name`: `'teste1'`

3. **Item 3**:
   - `book_id`: `'113'`
   - `name`: `'teste1'`
   - `year`: `1999`

### Resumo

- O código insere três itens diferentes na tabela `'book'` usando chaves primárias distintas (`book_id`).
- Como cada chamada usa um valor único de `book_id`, três itens são criados, cada um com os atributos especificados.
- A chave primária usada é `book_id`, o que garante a unicidade de cada item na tabela.

</blockquote>

13.   Agora a tabela book tem 3 registros, cada um com seu atributo

![img/partitionkey06.png](img/partitionkey06.png)

### Documentação
[https://aws.amazon.com/pt/blogs/database/choosing-the-right-dynamodb-partition-key/](https://aws.amazon.com/pt/blogs/database/choosing-the-right-dynamodb-partition-key/)