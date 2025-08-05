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
                    
                }
            }          
        }  

        stage('Build') {
            steps {
                println  '** Building with DBB  ...'                  
                script {
 
                    sh 'cd ' + appworkspace + '; set; dbb build file --hlq ibmuser.jenkins source/cobol/asample.cbl' 

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
