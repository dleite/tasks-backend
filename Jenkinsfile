pipeline{
    agent any  // agent que roda o pipeline
	tools {
	  maven 'MAVEN_LOCAL'   // foi necessário adicionar qual MAVEN será usado na compilação, pois não estava achando no path
	}
    stages{   // estagios do pipeline
        stage('Build Backend'){ //faz o Build da app sem realizar testes
            steps{   //steps do stage
                sh 'mvn clean package -DskipTests=true'   // Limpa build anterior, faz um novo build skipando os testes  
                
            }
        } 
		stage('Unit Tests'){ // realiza testes unitários
            steps{   //steps do stage
                sh 'mvn test'   // realiza testes 
                
            }
        }   
    }
}