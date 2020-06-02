pipeline {
  agent {
    label 'middleware'
  }
  options {
    disableConcurrentBuilds()
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }
  stages {
    stage('Validate') {
      steps {
        script {
          make = new brussels.bric.Make()
          make.make(target: 'precommit', useNixShell: true)
        }
      }
    }
  }
  post {
    cleanup{
      deleteDir()
    }
  }
}
