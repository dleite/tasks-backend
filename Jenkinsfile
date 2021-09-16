pipeline{
    agent any  // agent que roda o pipeline
	tools {
	  maven 'MAVEN_LOCAL'   // foi necessário adicionar qual MAVEN será usado na compilação, pois não estava achando no path
	}
    stages{   // estagios do pipeline
        stage('Build Backend'){ // estágio de Build da app 
            steps{   //steps do stage
                sh 'mvn clean package -DskipTests=true'   // Limpa build anterior, faz um novo build skipando os testes  
                
            }
        } 
		stage('Unit Tests'){ // estágio de testes unitários
            steps{   //steps do stage
                sh 'mvn test'   // realiza testes 
                
            }
        }   
		stage('Sonar Analysis'){ // estágio de testes de analise sonar
		    environment{
			    // cria uma variavel com o home do sonar scanner definido nas configurações "Global Tool Configuration" do jenkins (SonarQube Scanner)
				scannerHome= tool 'SONAR_SCANNER'   
			}
            steps{   //steps do stage
			    withSonarQubeEnv('SONAR LOCAL'){  // executa os comandos seguintes dentro do ambiente sonar definido em configurações do sistema do jenkins (SonarQube servers)
					// realizada testes do sonnar, usando a binário do scannerHome definido acima
					// "-e" passando as variaveis geradas pelo Sonnar ao criar o token e usadas anteriormente no job free style (porem sem remover o -D)
					sh '${scannerHome}/bin/sonar-scanner -e -Dsonar.projectKey=DeployBack -Dsonar.host.url=http://172.21.134.62:9000 -Dsonar.login=a57b3b94e15c1d3ad50acb56b74e4476e5fe23e2 -Dsonar.java.binaries=target'   
                }
            }
        }
		stage('Quality Gate'){ // estágio valida a analise do sonar com quality gate
            steps{   //steps do stage
			    sleep(10) // aguarda x segundos antes de pedir o relatório do quality gate ( para dar tempo de ele gerar)
                timeout(time: 1, unit: 'MINUTES'){  // executa o trecho abaixo , e caso pendure por que o report não está pronto, estoura por timeout em 1 minuto.
					waitForQualityGate abortPipeline: true // Aguardo pelo quality gate e se falhar no teste, ele aborta o pipeline
				}
            }
        } 
		stage('Deploy Backend'){ // estágio de deploy no tomcat
            steps{   //steps do stage
			    // gerado pelo pipeline-syntax, escolhida opção = "deplou: Deploy war/ear to a container"
			    deploy adapters: [tomcat8(credentialsId: 'tomcatLogin', path: '', url: 'http://localhost:8000/')], contextPath: 'taks-backend', war: 'target/taks-backend.war'
            }
        } 
   		
    }
}





