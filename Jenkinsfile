// Refer to the non master branches. This is an interim build before we start
// work on Java 11
imageName = 'area51/geoserver'

properties( [
  buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '7', numToKeepStr: '10')),
  disableConcurrentBuilds(),
  disableResume(),
  pipelineTriggers([
    upstream('/peter-mount/java/master'),
    cron('H H * * 1')
  ])
])

// Latest (Stable) is first, LTS is second then any versions we want to keep
// supporting with updates.
//
// Note: 2.12.0 is here as that's what is running on map.lu
//
versions = [ '2.14.0' ]

def build = {
  version, tag -> stage( version ) {
    sh 'docker build -t ' + imageName + ':' + tag + ' --build-arg GEOSERVER_VERSION=' + version + ' .'
    sh 'docker push ' + imageName + ':' + tag
  }
}

def publish = {
  version, tag -> stage( tag ) {
    sh 'docker tag ' + imageName + ':' + version + ' ' + imageName + ':' + tag
    sh 'docker push ' + imageName + ':' + tag
  }
}

node( 'AMD64' ) {
  stage( 'Prepare' ) {
    checkout scm
    sh 'docker pull area51/java:serverjre-8'
  }

  versions.each { version -> build( version, 'master' ) }
  //publish( versions[0], 'latest' )
  //publish( versions[1], 'lts' )

}
