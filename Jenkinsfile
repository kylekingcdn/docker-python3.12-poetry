pipeline {
    agent any
    environment {
        image_name = 'kylekingcdn/python3.12-poetry'
        architectures = 'linux/arm64,linux/amd64'
        registry_endpoint = ''
        registry_credentials = 'dockerhub-credentials'
    }
    stages {
        stage('Build image') {
            steps {
                script {
                    docker.withRegistry('', registry_credentials ) {
                        builder_name = env.architectures.replaceAll(',', '-').replaceAll('/', '_')
                        sh label: "Create a new builder if one does not already exist", script: """
                            docker buildx inspect ${builder_name} || docker buildx create --name ${builder_name} --platform ${architectures}
                        """
                        sh label: "Build image", script: """
                            docker buildx build \
                                --tag ${image_name}:latest \
                                --tag ${image_name}:${env.BRANCH_NAME} \
                                --platform ${architectures} \
                                --builder ${builder_name} \
                                --force-rm \
                                --no-cache \
                                --pull \
                                --push \
                                .
                        """
                    }
                }
            }
        }
    }
    post {
        cleanup {
            cleanWs()
        }
    }
}
