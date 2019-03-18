pipeline {
  agent { label "maven" }
  environment {
    version = getVersionFromPom("./pom.xml")
  }
  stages {
    stage("build application") {
      steps {
        sh "echo building for version:${version}"
        sh "mvn clean install -DskipTests"
//        stash includes: "./target/openshift-practice-${version}.jar", name: "jar"
      }
    }
    stage("run unit tests") {
      steps {
        sh "echo no tests to run yet..."
      }
    }
    stage("build image") {
      steps {
//        unstash "jar"
        script {
          openshift.withCluster() {
            openshift.withProject("spring") {
              def nb = openshift.selector("bc", "practice")
              nb.startBuild("--from-dir=.").logs("-f")
timeout(time: 20, unit: 'MINUTES') {
              def buildSelector = nb.related("builds")
              buildSelector.untilEach {
                return (it.object().status.phase == "Completed")
              }
}
            echo "Builds have been completed: ${buildSelector.names()}"
            }
          }
        }
      }
    }
    stage("tag image") {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject("spring") {
              openshift.tag("openshift-practice:latest", "openshift-practice:${version}")
            }
          }
        }
      }
    }
  }
}

def getVersionFromPom(pom) {
  def matcher = readFile(pom) =~ '<version>(.+)</version>'
  matcher ? matcher[0][1] : null
}
