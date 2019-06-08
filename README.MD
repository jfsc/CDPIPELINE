# TASK JENKINS CI/CD COM DOCKER
Construir um ambiente de entrega contínua para uma aplicação. A aplicação utilizada é a 
Spring PetClinic (petclinic) e a infraestrutura deve ser sua máquina local ou qualquer 
Cloud à sua escolha.

Muitas equipes buscam construir um ambiente que suporte um modelo de entrega ágil. Parte da resposta
do movimento DevOps para essa necessidade é a construção de pipelines de entrega contínua. Assim:

## TASK 1 (Containerizar petcilnic)
Crie um fork do projeto petclinic (https://github.com/spring-projects/spring-petclinic) 
para sua conta no GitHub. Configure a aplicação para usar o banco MYSQL ao invés do HSQLDB (banco in-memory 
configurado por padrão na aplicaçãp).

Conteinerize o Spring PetClinic com Docker. Com a aplicação ja dockerizada, execute uma instância do MYSQL (agora ele é o banco padrão)
e em seguida rode o petclinic dockerizado. Armazene sua imagem do petclinic em sua conta no Docker Hub.

Por último, use o Docker compose para facilitar a execução da aplicação.

### EVIDÊNCIAS:
- Em seu repositório no GitHub armazene o Dockerfile e docker-compose.yml;
- Compartilhe o link do Docker Hub com imagem da aplicação;

## TASK 2 (CI)
Execute uma instância dockerizada do Jenkins, SonarQube e Nexus v3 e construa um Job com as seguintes características: 
- Commits no branch master do GitHub devem acionar o Job.
- O Job deve rodar a compilação, testes unitários automatizados e cobertura de código para validar o build.
- Builds com sucesso devem armazenar a imagem docker no Nexus
- Usar Jenkinsfile para Jenkins;

Crie imagens do Jenkins (contendo o job criado), SonarQube e Nexus e armazene no Docker Hub. Também, crie um 
docker-compose-ci.yml para facilitar a execução.

### EVIDÊNCIAS:
- Adicione ao seu repositório no GitHub o docker-compose-ci.yml do ambiente de CI (Jenkins,SonarQube e Nexus)
- Simule um build "quebrado" - altere um teste unitário- e compartilhe (em uma pasta chamada screenshots no GitHub) uma screenshot do log do jenkins identificando a falha no build.
- Dentro da pasta screenshots, compartilhe uma screenshot do dashboard do Sonarque e Nexus (contendo ao menos 2 gerações de artefatos)

## TASK 3 (CI/CD)
No ambiente de CI construído na TASK 2, adicione um Job para deploy das images armazenadas no Nexus. Entretanto, 
permita que o usuário escreva a versão da imagem docker que deseja realizar o deploy - ex.: algo/petclinic:1.0

Atualize a imagem do Jenkins, em sua conta do Docker Hub, contendo a versão onde vc adicionou o Job.

### EVIDÊNCIAS:
- link e versão da nova imagem no Docker Hub.
