# Aula 02.1 - Lambda


1. No terminal do IDE criado no cloud9 execute o comando `cd ~/environment/fiap-cloud-computing-tutorials/04\ -\ Lambda/01\ -\ intro/` para entrar na pasta que fara este exercicio.
2. Garanta que o [serverless framework](https://www.serverless.com/) esta instalado na versão correta com o comando `sudo npm i serverless@3.39.0 -g`.

<blockquote>

# O que é o Serverless Framework?

O **Serverless Framework** é uma poderosa ferramenta open-source que facilita o desenvolvimento e a implementação de aplicações **serverless**. Ele permite que desenvolvedores construam e gerenciem funções em plataformas como AWS Lambda, Azure Functions e Google Cloud Functions, abstraindo a complexidade da infraestrutura. O Serverless Framework automatiza o provisionamento de recursos de nuvem necessários para executar suas funções, como APIs, bancos de dados, filas, e muito mais, simplificando o processo de deploy e escalabilidade de aplicações. O uso de arquivos de configuração YAML possibilita a definição de serviços, funções e recursos de forma declarativa, tornando o processo de desenvolvimento ágil e eficiente.

Uma das principais vantagens do Serverless Framework é sua integração com múltiplos provedores de nuvem, permitindo que equipes trabalhem de forma consistente em diferentes plataformas. Além disso, ele oferece uma série de plugins e funcionalidades para monitoramento, logs e gestão de permissões, facilitando o gerenciamento do ciclo de vida das aplicações serverless. O Serverless Framework é amplamente adotado devido à sua facilidade de uso e sua capacidade de gerenciar arquiteturas complexas sem a necessidade de provisionar ou gerenciar servidores diretamente. Para mais informações, consulte a [documentação oficial](https://www.serverless.com/framework/docs/).

</blockquote>

3. Iniciar o repositório de trabalho `sls create --template "aws-python3"`
 
  ![img/slscreate.png](img/slscreate.png)

<blockquote>

O comando **`sls create --template "aws-python3"`** é utilizado no **Serverless Framework** para criar um novo projeto **serverless** com uma configuração inicial voltada para a **AWS** usando o runtime **Python 3**. Aqui está uma explicação detalhada sobre o que ele faz:

- **`sls create`**: Esse comando inicializa um novo projeto utilizando o **Serverless Framework**. Ele cria uma estrutura básica de diretórios e arquivos necessários para começar o desenvolvimento de uma aplicação serverless.
  
- **`--template "aws-python3"`**: A flag **`--template`** define o modelo de projeto que será usado. No caso, o template **`aws-python3`** cria um projeto que utiliza **AWS Lambda** como o provedor de funções serverless, com o runtime configurado para **Python 3**.

Ao executar esse comando, o Serverless Framework cria a estrutura do projeto no diretório atual, incluindo arquivos como:
- **`serverless.yml`**: Arquivo de configuração principal onde você define as funções, recursos e configurações da sua aplicação.
- **Arquivo Python**: Um arquivo de exemplo em Python (geralmente `handler.py`), que serve como o ponto de entrada da função Lambda.
- **Diretório e Arquivos Básicos**: Estrutura de diretório padrão para organizar o código e dependências.

Esse comando é ideal para iniciar rapidamente um projeto serverless na AWS utilizando Python 3. Para mais informações, consulte a [documentação oficial do Serverless Framework](https://www.serverless.com/framework/docs/providers/aws/cli-reference/create).

</blockquote>

1. Abra o arquivo serverless.yml no IDE com o comando `c9 open serverless.yml`
2. Altere o arquivo para que fique como na imagem abaixo. Para salvar utilize CTRL+S.
   
   ![](img/yml1.png)

<blockquote>

Aqui está a explicação detalhada de cada linha do arquivo **`serverless.yml`** fornecido, com ênfase na necessidade da **LabRole** e no uso do **`!Sub`** para interpolação de variáveis:

```yaml
service: teste
```
- **`service: teste`**: Define o nome do serviço (ou projeto). Esse nome será usado para identificar o conjunto de funções e recursos criados no AWS. No exemplo, o serviço é chamado de **`teste`**.


- **`frameworkVersion: '3'`**: Especifica a versão do Serverless Framework a ser utilizada. Neste caso, a versão 3 está sendo usada, garantindo que o projeto use a sintaxe e funcionalidades dessa versão.

- **`provider:`**: Esta seção define o provedor de nuvem que será utilizado. O Serverless Framework suporta múltiplos provedores, e aqui está sendo especificado o **AWS** como provedor.
  
  - **`name: aws`**: Define a **AWS** como o provedor de nuvem em que as funções serão implantadas.

  - **`runtime: python3.11`**: Especifica o **runtime** que será utilizado pelas funções Lambda. No caso, o **Python 3.11** é o ambiente de execução das funções.

  - **`memorySize: 128`**: Define a quantidade de memória atribuída a cada função Lambda. Aqui, foi configurado o mínimo de 128 MB, o que afeta diretamente o desempenho e o custo das funções.

  - **`region: 'us-east-1'`**: Define a **região** da AWS onde o serviço será implantado. Nesse caso, a região **`us-east-1`** (Virgínia do Norte) está sendo utilizada.

  - **`timeout: 300`**: Define o tempo máximo de execução de cada função Lambda, em segundos. Aqui, foi configurado um **timeout** de **300 segundos** (ou 5 minutos).

  - **`iam: role:`**: Define a **IAM Role** que a função Lambda usará. Nesse caso, foi fornecido um ARN de função de uma **IAM Role** existente chamada **`LabRole`**. Como você está utilizando contas do **AWS Academy**, onde a criação de novas roles (funções IAM) é restringida, você deve obrigatoriamente utilizar uma role já pré-existente, como a **LabRole**.

  - **`!Sub arn:aws:iam::${AWS::AccountId}:role/LabRole`**: 
    - O **`!Sub`** é uma função do **AWS CloudFormation** usada para substituir variáveis dentro de strings. Aqui, ele substitui **`${AWS::AccountId}`** pela ID da conta AWS em que o serviço está sendo implantado.
    - O resultado final será algo como:
      ```
      arn:aws:iam::123456789012:role/LabRole
      ```
    - Isso garante que a **LabRole** associada à conta da AWS seja utilizada para conceder as permissões necessárias para a execução das funções Lambda.

- **`functions:`**: Define as funções Lambda que serão implantadas como parte do serviço.
  
  - **`hello:`**: O nome da função Lambda. No exemplo, a função se chama **`hello`**.

  - **`handler: handler.hello`**: Especifica o caminho do arquivo e a função que será invocada. Aqui, o arquivo é **`handler.py`**, e a função dentro dele é **`hello`**. Isso significa que a função **`hello`** será chamada quando a função Lambda for acionada.

---

### Explicação Adicional

- **Necessidade da LabRole**: Como as contas do **AWS Academy** têm restrições que impedem a criação de novas **IAM Roles**, você precisa usar uma role existente, como a **LabRole**. Essa role já vem configurada com permissões específicas, permitindo que suas funções Lambda acessem os recursos necessários. O arquivo **`serverless.yml`** está configurado para reutilizar essa role existente com a interpolação da variável **`${AWS::AccountId}`** para garantir que a role certa seja usada para a conta AWS específica.


</blockquote>

1. No terminal do IDE faça deploy da função criada com o comando `sls deploy --verbose`. Esse comando vai mostrar cada etapa sendo feita em detalhes, bem como o status do cloudformation criado.
 
  ![img/slsdeploy.png](img/slsdeploy.png)

<blockquote>

O comando **`sls deploy --verbose`** faz parte do **Serverless Framework** e é utilizado para implantar (deploy) a infraestrutura e as funções de um projeto serverless na nuvem (como na **AWS**). Esse comando realiza o processo de configuração e provisionamento dos recursos necessários, como funções Lambda, APIs, bancos de dados, entre outros.

### Explicação Detalhada

- **`sls deploy`**: 
  - O comando principal **`sls deploy`** inicia o processo de implantação do serviço definido no arquivo **`serverless.yml`**. Ele provisiona os recursos da nuvem e envia o código para o provedor especificado (geralmente AWS). 
  - O **Serverless Framework** empacota o código, gera templates de CloudFormation (no caso da AWS) e cria ou atualiza todos os recursos especificados no **`serverless.yml`**.
  - Além das funções Lambda, isso pode incluir a criação de API Gateway, IAM Roles, tabelas DynamoDB, e outros recursos de infraestrutura necessários.

- **`--verbose`**: 
  - A flag **`--verbose`** ativa o modo de **detalhamento completo** durante o processo de implantação. Isso significa que o console exibirá todas as informações detalhadas sobre o que está acontecendo durante o deploy, como:
    - Upload de pacotes de funções.
    - Criação ou atualização de recursos da infraestrutura.
    - Logs detalhados de execução e etapas do CloudFormation.
    - Erros e advertências que possam surgir no processo.
  
  Esse nível de detalhamento é útil para depuração e compreensão das etapas que ocorrem durante a implantação, especialmente em ambientes complexos ou quando ocorrem problemas.

### Exemplos de Saída com `--verbose`

Quando você executa **`sls deploy --verbose`**, o console exibirá informações detalhadas como:

- Criação de pacotes de funções Lambda.
- Upload dos pacotes para o **S3** (no caso da AWS).
- Status de criação de recursos do **CloudFormation**.
- Links para a API Gateway e funções Lambda criadas.
- Logs e detalhes de cada etapa do processo.

### Quando Usar?

- O **`--verbose`** é particularmente útil quando você deseja ter visibilidade completa sobre o processo de implantação, seja para depurar problemas, entender melhor o que está sendo provisionado ou monitorar cada etapa do deploy.
  
Para mais informações, consulte a [documentação oficial do Serverless Framework](https://www.serverless.com/framework/docs/providers/aws/cli-reference/deploy/).

</blockquote>

7. Testar invocar a função que foi implantanda na AWS utilize o comando `sls invoke -f hello`

  ![img/slsinvoke.png](img/slsinvoke.png)

<bloquote>

O comando **`sls invoke -f hello`** faz parte do **Serverless Framework** e é utilizado para **invocar (executar)** uma função Lambda específica que já foi implantada no provedor de nuvem (geralmente na AWS). Vamos detalhar cada parte do comando:

### Explicação Detalhada

- **`sls invoke`**:
  - O **`invoke`** é o comando que aciona (ou executa) uma função Lambda. Ele permite que você teste manualmente uma função diretamente da linha de comando, sem precisar fazer deploy novamente ou acionar o evento pelo qual a função normalmente seria disparada (por exemplo, através de uma API ou evento do S3).
  
- **`-f hello`**:
  - A flag **`-f`** (abreviação de **`--function`**) indica que você está especificando o nome da função Lambda que deseja invocar.
  - **`hello`** é o nome da função Lambda que você está chamando. Este nome deve corresponder ao nome da função conforme definido no arquivo **`serverless.yml`**. No seu caso, o arquivo **`serverless.yml`** teria algo como:
    ```yaml
    functions:
      hello:
        handler: handler.hello
    ```

### O que acontece ao executar o comando?

Quando você executa **`sls invoke -f hello`**, o Serverless Framework faz o seguinte:
1. Envia uma solicitação para o provedor de nuvem (AWS, no caso de AWS Lambda) para executar a função chamada **`hello`**.
2. A função Lambda é executada na nuvem com qualquer lógica definida no código.
3. A resposta da função Lambda é retornada no terminal, exibindo a saída gerada pela função.

### Exemplos de Uso

Por exemplo, se a função **`hello`** está definida da seguinte maneira:
```python
def hello(event, context):
    return {
        'statusCode': 200,
        'body': 'Hello from Lambda!'
    }
```

Ao executar o comando **`sls invoke -f hello`**, você verá algo assim no terminal:
```json
{
  "statusCode": 200,
  "body": "Hello from Lambda!"
}
```

### Quando Usar?

- **Testar Funções Localmente**: Use este comando para testar funções Lambda que já foram implantadas, sem precisar criar eventos específicos para acioná-las.
- **Depuração Rápida**: Se você está fazendo alterações em uma função, pode usar o **`sls invoke`** para verificar o comportamento da função após o deploy, vendo diretamente o resultado da execução.

### Parâmetros Adicionais

Você também pode passar eventos personalizados para a função utilizando a flag **`--data`**, o que permite simular entradas específicas:
```bash
sls invoke -f hello --data '{"key": "value"}'
```

Para mais detalhes, consulte a [documentação oficial do Serverless Framework](https://www.serverless.com/framework/docs/providers/aws/cli-reference/invoke).

</blockquote>

8. Execute o comando `c9 open handler.py` e altere a versão do retorno da função para 1.1 no arquivo "handler.py" como na imagem e salve com as teclas "CTRL + S"

  ![img/altereversao.png](img/altereversao.png)

<blockquote>

Este código em Python é um exemplo de uma **função AWS Lambda**, projetada para ser invocada na nuvem pela Amazon Web Services (AWS). Vamos detalhar o que o código faz e suas particularidades relacionadas à execução no ambiente **AWS Lambda**.

### Estrutura do Código

1. **Imports**:
   ```python
   import json
   ```
   - O código importa a biblioteca **`json`**, que é usada para converter (serializar) o dicionário Python em uma string JSON. Isso é necessário porque a resposta de uma função Lambda geralmente deve estar em formato JSON quando é retornada.

2. **Definição da Função `hello(event, context)`**:
   ```python
   def hello(event, context):
   ```
   - **`event`**: Este parâmetro contém os **dados de entrada** da função Lambda. Ele representa o evento que disparou a execução da função. Dependendo do gatilho da função (como uma requisição do API Gateway, um arquivo no S3, etc.), o objeto **`event`** pode ter diferentes formatos e estruturas. Ele contém todas as informações relevantes sobre o evento, como parâmetros, cabeçalhos HTTP, e corpo de uma requisição (em caso de API Gateway).
   
   - **`context`**: Este parâmetro contém informações sobre o **contexto de execução** da função Lambda, como o tempo de execução restante, a função Lambda em si (nome, versão), e o ID da requisição. Embora não seja utilizado diretamente no código, ele é útil para monitoramento, controle de tempo, e logs em ambientes Lambda.

3. **Corpo da Função**:
   ```python
   body = {
       "message": "Go Serverless v1.1! Your function executed successfully!",
       "input": event
   }
   ```
   - Este bloco cria um dicionário **`body`** que contém uma **mensagem de sucesso** e inclui os dados recebidos no parâmetro **`event`**. O campo `"input": event` devolve o evento de entrada na resposta, o que é útil para debug e verificação de dados.

4. **Criação da Resposta HTTP**:
   ```python
   response = {
       "statusCode": 200,
       "body": json.dumps(body)
   }
   ```
   - A função Lambda deve retornar uma **resposta em formato específico** quando está integrada com o **API Gateway**, ou em outros casos, precisa de um formato semelhante.
     - **`statusCode: 200`**: Este é o código de status HTTP, indicando sucesso. Em APIs, o código 200 significa que a solicitação foi tratada com sucesso.
     - **`body: json.dumps(body)`**: O conteúdo do corpo da resposta é o dicionário `body` criado anteriormente, convertido para uma string JSON usando **`json.dumps()`**. O uso de **`json.dumps()`** é necessário porque a resposta da Lambda precisa estar em formato JSON.

5. **Retorno da Função**:
   ```python
   return response
   ```
   - A função retorna um dicionário **`response`**, que será enviado como a resposta final da função Lambda. Isso contém o status HTTP e o corpo da resposta em formato JSON, que será entregue ao chamador (como o **API Gateway**, por exemplo).

### Particularidades da Função Lambda

1. **Formato de Entrada e Saída**:
   - A função Lambda espera que os dados de **entrada** sejam passados no parâmetro **`event`**, e o **resultado** deve ser retornado como um dicionário contendo o código de status HTTP (`statusCode`) e o corpo da resposta (`body`), geralmente em formato JSON.
   - Se a função estiver integrada ao **API Gateway**, o **`event`** conterá informações sobre a requisição HTTP (como cabeçalhos, parâmetros de consulta e o corpo da requisição).

2. **Execução Sem Servidores (Serverless)**:
   - Esta função é executada em um ambiente **serverless**, o que significa que você não precisa se preocupar com a infraestrutura subjacente (como servidores ou máquinas virtuais). A AWS gerencia automaticamente o escalonamento e a infraestrutura necessária para executar a função conforme o volume de chamadas.
   
3. **Escalabilidade Automática**:
   - Funções AWS Lambda podem escalar automaticamente de acordo com a demanda. Ou seja, independentemente do número de requisições simultâneas, a AWS irá disparar múltiplas instâncias da função conforme necessário.

4. **Eventos de Entrada**:
   - As funções Lambda podem ser acionadas por diferentes **gatilhos (triggers)**, como o **API Gateway**, eventos do **S3**, ou mensagens do **SQS**. Dependendo do gatilho, o formato do parâmetro **`event`** pode variar bastante. No caso de uma integração com o **API Gateway**, o evento pode conter informações de uma requisição HTTP (como cabeçalhos e o corpo da requisição).


### Conclusão

Este código de função **AWS Lambda** está estruturado para ser facilmente invocado por eventos da AWS e retorna uma resposta em formato adequado para ser utilizada em APIs, como o **API Gateway**. Ele demonstra como utilizar os parâmetros de entrada e saída típicos de funções Lambda e apresenta as características principais do ambiente **serverless**.

</blockquote>

1.  Faça um teste local da sua função no terminal com o comando `sls invoke local -f hello` 

  ![img/slsinvokelocal.png](img/slsinvokelocal.png)

<blockquote>

O comando **`sls invoke local -f hello`** é utilizado para **invocar uma função Lambda localmente**, ou seja, a função será executada no ambiente de desenvolvimento, diretamente na sua máquina, sem necessidade de implantá-la (deploy) na nuvem. Este comando permite que você teste sua função Lambda **antes de fazer o deploy** para o AWS, garantindo que o comportamento e o código estejam corretos localmente.

### Diferença Principal: Execução Local

Ao contrário de **`sls invoke -f hello`**, que invoca a função Lambda já implantada na AWS, o comando **`sls invoke local -f hello`** executa a função **diretamente no seu ambiente local**. Isso permite testar a função rapidamente sem depender de uma conexão com a AWS, além de facilitar a depuração do código e testes antes de subir as alterações para o ambiente de produção.

### Última Atualização do `handler.py`

Como a função é executada localmente, o comportamento e o resultado da invocação dependerão da **última versão do arquivo `handler.py`** presente no seu projeto local. Ou seja, quaisquer mudanças feitas no código da função (por exemplo, na função `hello`) no arquivo **`handler.py`** serão refletidas imediatamente ao usar o comando **`sls invoke local`**, sem a necessidade de fazer deploy.

Por exemplo, se você alterar o código da função **`hello`** no arquivo **`handler.py`** e depois executar **`sls invoke local -f hello`**, a execução usará essa versão atualizada do código localmente. Isso é muito útil para ciclos rápidos de desenvolvimento, onde você quer testar uma modificação no código sem esperar pelo processo completo de deploy para o AWS.

### Uso em Desenvolvimento

Esse comando é particularmente útil no desenvolvimento local, pois permite:
- Testar o comportamento da função com diferentes entradas de dados.
- Verificar o resultado da função sem custos ou tempo de execução na AWS.
- Depurar a função, já que você pode rodar o código em modo local e usar ferramentas de depuração do Python disponíveis em sua máquina.

Em resumo, o comando **`sls invoke local -f hello`** executa a função Lambda no ambiente local, garantindo que a versão mais recente do código seja utilizada, sem depender de uma implantação no AWS.

</blockquote>

1. Para deletar a função que esta no lambda utilize o comando `sls remove`

  ![img/slsremove.png](img/slsremove.png)

<blockquote>

O comando **`sls remove`** é utilizado no **Serverless Framework** para **remover (destruir)** completamente os recursos que foram previamente implantados na nuvem com o Serverless Framework. Isso inclui a exclusão de todas as funções Lambda, os recursos associados (como API Gateway, S3, DynamoDB, etc.), além de remover qualquer configuração ou infraestrutura provisionada pelo arquivo **`serverless.yml`**.

### O que o `sls remove` faz?

1. **Remove Funções Lambda**: Apaga todas as funções Lambda que foram implantadas como parte do serviço.
2. **Remove Recursos Associados**: Exclui recursos de infraestrutura relacionados, como APIs no API Gateway, buckets no S3, tabelas no DynamoDB, entre outros que foram definidos no **`serverless.yml`**.
3. **Remove Stacks do CloudFormation**: O comando também exclui o **stack do CloudFormation** que foi criado durante a implantação. Isso implica que todos os recursos provisionados por esse stack também serão excluídos.
4. **Limpa o Ambiente**: É uma forma prática de **limpar** o ambiente na nuvem, liberando recursos e evitando cobranças desnecessárias, especialmente em ambientes de desenvolvimento ou testes.

### Quando Usar?

- **Limpeza de Ambientes**: Ideal quando você deseja **remover** um serviço ou um conjunto de recursos que não será mais necessário, liberando recursos na nuvem.
- **Ambientes de Teste**: Em cenários de desenvolvimento ou testes, você pode usar **`sls remove`** para garantir que todos os recursos criados temporariamente sejam excluídos, evitando custos.
- **Mudanças de Infraestrutura**: Quando você precisa redefinir a infraestrutura ou recriar do zero um ambiente, o comando **`sls remove`** ajuda a remover os recursos antigos antes de uma nova implantação.

### Exemplo de Uso

Para remover todos os recursos associados ao seu serviço, basta executar:
```bash
sls remove
```

Isso removerá todos os recursos criados pelo Serverless Framework, conforme definidos no arquivo **`serverless.yml`**.

### Considerações

- O **`sls remove`** é um comando poderoso, então é importante usá-lo com cautela, pois ele **remove permanentemente** todos os recursos associados ao serviço. Se for um ambiente de produção, o uso deve ser feito com cuidado para não comprometer funcionalidades críticas.

Para mais detalhes sobre o comando, você pode consultar a [documentação oficial do Serverless Framework](https://www.serverless.com/framework/docs/providers/aws/cli-reference/remove).

</blockquote>