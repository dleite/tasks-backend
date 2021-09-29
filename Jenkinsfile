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
//		stage('Unit Tests'){ // estágio de testes unitários
//            steps{   //steps do stage
//                sh 'mvn test'   // realiza testes 
//                
//            }
//        }   
//		stage('Sonar Analysis'){ // estágio de testes de analise sonar
//		    environment{
//			    // cria uma variavel com o home do sonar scanner definido nas configurações "Global Tool Configuration" do jenkins (SonarQube Scanner)
//				scannerHome= tool 'SONAR_SCANNER'   
//			}
//            steps{   //steps do stage
//			    withSonarQubeEnv('SONAR LOCAL'){  // executa os comandos seguintes dentro do ambiente sonar definido em configurações do sistema do jenkins (SonarQube servers)
//					// realizada testes do sonnar, usando a binário do scannerHome definido acima
//					// "-e" passando as variaveis geradas pelo Sonnar ao criar o token e usadas anteriormente no job free style (porem sem remover o -D)
//					sh '${scannerHome}/bin/sonar-scanner -e -Dsonar.projectKey=DeployBack -Dsonar.host.url=http://172.21.138.80:9000 -Dsonar.login=a57b3b94e15c1d3ad50acb56b74e4476e5fe23e2 -Dsonar.java.binaries=target'   
//                }
//            }
//        }
//		stage('Quality Gate'){ // estágio valida a analise do sonar com quality gate
//            steps{   //steps do stage
//			    sleep(10) // aguarda x segundos antes de pedir o relatório do quality gate ( para dar tempo de ele gerar)
//                timeout(time: 1, unit: 'MINUTES'){  // executa o trecho abaixo , e caso pendure por que o report não está pronto, estoura por timeout em 1 minuto.
//					waitForQualityGate abortPipeline: true // Aguardo pelo quality gate e se falhar no teste, ele aborta o pipeline
//				}
//            }
//        } 
//		stage('Deploy Backend'){ // estágio de deploy no tomcat ambiente teste
//            steps{   //steps do stage
//			    // gerado pelo pipeline-syntax, escolhida opção = "deplou: Deploy war/ear to a container"
//			    deploy adapters: [tomcat8(credentialsId: 'tomcatLogin', path: '', url: 'http://172.21.138.80:8001/')], contextPath: 'tasks-backend', war: 'target/tasks-backend.war'
//            }
//        } 
//		stage('API Test'){ // estágio testes chamando a API
//            steps{   //steps do stage
//			    // gerado pelo pipeline-syntax, escolhida opção = "git: Giy" para baixar o fonte para uma pasta especifica
//			    dir('api-test'){ // cria um subdir no workspace para não sobrepor os fontes da app
//				  git url: 'https://github.com/wcaquino/tasks-api-test'  // baixa o fonte da app que chama os testes
//				  sh 'mvn test'  // executa os testes.
//				}
//            }
//        } 
//		stage('Deploy frontend'){ // estágio de deploy no tomcat ambiente teste, agora do frontend
//            steps{   //steps do stage
//				dir('frontend'){  // cria um subdir no workspace para não sobrepor os fontes da app
//				    git credentialsId: '1a5f3a7e-44c6-4f84-875e-181fdc4bcec9', url: 'https://github.com/dleite/tasks-frontend'    // baixa os fontes no subdir
//					sh 'mvn clean package'   // Limpa build anterior, faz um novo build
//					// gerado pelo pipeline-syntax, escolhida opção = "deplou: Deploy war/ear to a container"
//					deploy adapters: [tomcat8(credentialsId: 'tomcatLogin', path: '', url: 'http://172.21.138.80:8001/')], contextPath: 'tasks', war: 'target/tasks.war'
//				}
//            }
//        } 
		stage('Deploy docker'){ // estágio de deploy em container tudo que foi criado acima , agora em ambiente de produção.
            steps{   //steps do stage
			    sh 'scp -rp frontend target docker-compose.yaml root@172.26.52.120:/tmp'
				sh 'ssh root@172.26.52.120 "cd /tmp ; docker-compose build"'
				sh 'ssh root@172.26.52.120 "cd /tmp ; docker-compose up -d"'   // -d não prende o prompt , senão o jenkins fica preso
			}            
        }
   		
    }
}
 





