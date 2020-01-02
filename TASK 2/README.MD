# RUN Docker File

```bash
$ bash docker-file.sh
```

# RUN Docker Compose

```bash
$ bash docker-compose.sh
```

# Sonarqube

In Security > Users

Configure your user's token to be used in sonar-project.properties

# GitHub

Create Jenkinsfile (Pipeline) e sonar-project.properties in root of project

# Nexus

Create Repository: maven2 (hosted)

Type Artifact: Snapshot

# Jenkins

In Manage Jenkins > Manage Plugins > Available

Search to:

* SonarQube Scanner for Jenkins
* Nexus Artifact Uploader
* Nexus Platform Plugin

In Manage Jenkins > Global Toll Configuration

Configure according to your scenario:

* SonarQube Scanner

In Manage Jenkins > Configure System

Configure according to your scenario:

* SonarQube servers
* Sonatype Nexus

## HUB

https://hub.docker.com/r/romuloslv/jenkins

https://hub.docker.com/r/romuloslv/sonarqube

https://hub.docker.com/r/romuloslv/nexus
