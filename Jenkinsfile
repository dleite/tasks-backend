pipeline{
    agent any  // agent que roda o pipeline
    stages{   // estagios do pipeline
        stage('Inicio'){ // cria um stage com nome inicio
            steps{   //steps do stage
                sh 'echo Inicio'
                
            }
        }
        stage('Meio'){ // cria outro stage
            steps {  // steps do stage
                sh 'echo meio'
                sh 'echo meio 2'
            }
        }
        stage('Fim'){ // cria outro stage
            steps{ // steps do stage
                sleep(5)
                sh 'echo fim'
            }
        }
    }
}