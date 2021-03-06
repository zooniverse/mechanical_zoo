#!groovy

node {
    checkout scm

    def dockerRepoName = 'zooniverse/mechanical_zoo'
    def dockerImageName = "${dockerRepoName}:${BRANCH_NAME}"
    def newImage = null

    stage('Build Docker image') {
        newImage = docker.build(dockerImageName)
        newImage.push()
    }

    if (BRANCH_NAME == 'master') {
        stage('Update latest tag') {
            newImage.push('latest')
        }

        stage('Deploy to Swarm') {
            sh """
                cd "/var/jenkins_home/jobs/Zooniverse GitHub/jobs/operations/branches/master/workspace" && \
                ./hermes_wrapper.sh exec StandaloneAppsSwarm -- \
                    docker stack deploy --prune \
                    -c /opt/infrastructure/stacks/mechanical-zoo-staging.yml \
                    mechanical-zoo-staging
            """
        }
    }

    if (BRANCH_NAME == 'production') {
        stage('Update production tag') {
            newImage.push('production')
        }

        stage('Deploy to Swarm') {
            sh """
                cd "/var/jenkins_home/jobs/Zooniverse GitHub/jobs/operations/branches/master/workspace" && \
                ./hermes_wrapper.sh exec StandaloneAppsSwarm -- \
                    docker stack deploy --prune \
                    -c /opt/infrastructure/stacks/mechanical-zoo-production.yml \
                    mechanical-zoo-production
            """
        }
    }
}
