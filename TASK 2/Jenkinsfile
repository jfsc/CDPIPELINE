pipeline {
    agent any
    environment {
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "10.81.168.67:8081"
        NEXUS_REPOSITORY = "spring-petclinic"
        NEXUS_CREDENTIAL_ID = "nexus"
    }
    stages {
        stage ('Checkout') {
          steps {
            git 'https://github.com/romuloslv/spring-petclinic.git'
          }
        }
        stage('Build') {
            agent { docker 'maven:3.6-jdk-8' }
            steps {
                sh 'mvn package -DskipTests=true'
            }
        }
        stage('Test') {
            steps {
                sh '/var/jenkins_home/sonar-scanner/bin/sonar-scanner'   
            }
	}
        stage("Publish to nexus") {
            //when {
            //    branch 'master' 
            //}
            steps {
                script {
                    pom = readMavenPom file: "pom.xml";
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path;
                    artifactExists = fileExists artifactPath;
                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: pom.version,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging],
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );
                    } else {
                        error "*** File: ${artifactPath}, could not be found";
                    }
                }
            }
        }
    }
}
