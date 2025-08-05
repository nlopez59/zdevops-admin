// Sample Jenkinsfile using pGH, ssh and a zDT Agent (Nlopez)
// for help: https://www.jenkins.io/doc/book/pipeline/jenkinsfile/
 
// change these values to match your configuration
// sample scripts are @ '/u/ibmuser/waziDBB/dbb-v2/dbb-zappbuild/scripts'

def myAgent  = 'taz-zos-agent'
def repo = 'https://github.com/nlopez59/zdevops-admin.git'
 
 
def appworkspace = 'zdevops-admin'
def appname = 'source'


// no changes required to this section 
pipeline {
    agent  { label myAgent } 
    options { skipDefaultCheckout(true) }
    
    stages {
        stage('Clone') {
            steps {
                println '** Cloning on USS ...'     
                script {
                    sh 'rm -rf *'
                    sh 'git clone ' + repo 
                    sh 'cd ' + appworkspace  + '; git log --graph --oneline --decorate -n 3'
                    sh 'cd ' + appworkspace  + '; git clone  -b main ' + Common 
                    
                }
            }          
        }  

        stage('Build') {
            steps {
                println  '** Building with DBB  ...'                  
                script {
 
                    sh 'cd ' + appworkspace + '; dbb -DBB_DAEMON_PORT 8180 build file --hlq ibmuser.jenkins --encoding UTF-8 source/cobol/asample.cbl' 

                }
            }
        }

        
    }   
    
    post {
            always {
                echo 'Saving Logs ...'
                archiveArtifacts artifacts: '**/*.log', fingerprint: false                
                }
    }        
}
