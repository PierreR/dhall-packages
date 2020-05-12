pipeline {
  agent {
    label 'middleware'
  }
  options {
    disableConcurrentBuilds()
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }
  stages {
    stage('Check (precommit)') {
      steps {
        script {
          make = new brussels.bric.Make()
          make.make(target: 'precommit', useNixShell: true)
        }
      }
    }
    stage('Make examples') {
      steps {
        script {
          make = new brussels.bric.Make()
          make.make(target: 'examples', useNixShell: true, nixPure: false)
        }
      }
    }
  }
  post {
    success {
      build job: 'cicd/docs.cicd.cirb.lan/master', wait: true
    }
    cleanup{
      deleteDir()
    }
  }
}
