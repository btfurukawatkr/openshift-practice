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
#        stash includes: "./target/openshift-practice-${version}.jar", name: "jar"
      }
    }
    stage("run unit tests") {
      steps {
        sh "echo no tests to run yet..."
      }
    }
    stage("build image") {
      steps {
#        unstash "jar"
        script {
          openshift.withCluster() {
            openshift.withProject("spring") {
              def nb = openshift.selector("bc", "openshift-practice-with-jenkins")
              nb.startBuild("--from-file=./target/openshift-practice-${version}.jar").logs("-f")
              def buildSelector = nb.narrow("bc").related("builds")
              timeout(5) {
                buildSelector.untilEach(1) {
                  return (it.object().status.phase == "Complete")
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
