pipeline{
    agent any  // agent que roda o pipeline
    stages{   // estagios do pipeline
        stage('Build Backend'){ // cria um stage com nome inicio
            steps{   //steps do stage
                sh 'mvn clean package -DskipTests=true'   // Limpa build anterior, faz um novo build skipando os testes  
                
            }
        }        
    }
}