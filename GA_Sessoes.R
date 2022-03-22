#Definindo a pasta de trabalho
setwd("")
retry <- function(a, max = 10, init = 0){suppressWarnings( tryCatch({
  if(init<max) a
}, error = function(e){retry(a, max, init = init+1)}))}



########################### Parte 0 - Rodando a biblioteca ########################
#devtools::install_github("r-dbi/bigrquery")
#devtools::install_github("tidyverse/googlesheets4", force = T)
#if(!require(googleAnalyticsR)) install.packages("googleAnalyticsR")

library(googleAnalyticsR)
library(DBI)
library(bigrquery)
library(RGoogleAnalytics)
library(googlesheets4)

########################### Parte 1 - Autorizando a coleta e extração de dados ########################

#Autorizar a conta do google Analytics 
#Nao precisa ser executado em toda sessao  uma vez que foi criado e salvo
#client.id  <- ""
#client.secret <- ""
#token <- Auth(client.id,client.secret)
#Aqui serao salvo o token para futuras sessoes
#save(token,file="./token_file")
#Em sessoes futuras ele pode ser carregado pelo ("./token_file")
load("./token_file")
#Validando o token
ValidateToken(token)

#autenticando o usuário
#ga_auth()

#olhar a tabela e coletar os dados do id
#minhas_contas <- ga_account_list()
minha_id <- 


########################### Parte 2.0 - Construção da Query  ######################################

#Ao escolher as dimensões e as métricas devo observar exatamente o que eu quero
#Funciona tal qual o Data Studio
#Para saber se elas podem ser utilizadas juntas devo olhar o seguinte site:
#https://ga-dev-tools.appspot.com/dimensions-metrics-explorer/?csw=1#validCombinations


###################### 2.1 - Extração de TABELA GA_Sessões  ########################################

#Pacote usado: 
#https://cran.r-project.org/web/packages/googleAnalyticsR/googleAnalyticsR.pdf


web_data <- google_analytics(minha_id, 
                             date_range = c("yesterday", "today"),
                             dimensions = c("date","campaign","adContent"), #Opcional. Até 7 dimensões #Lembre-se de que se for uma série temporal deve ter a ga:date
                             metrics = c("goal1Completions", "goal2Completions", "goal3Completions", "goal4Completions", "goal5Completions"),#Até 10 métricas
                             anti_sample = TRUE)


############################# Parte 3 - Upando dados no bigquery ########################3
#Acessando o Google Big Query

httr::set_config(httr::config(ssl_verifypeer = 0L))
httr::set_config(httr::config(http_version = 0))
options(httr_oob_default = TRUE)
bq_auth(email = '', path = 'googlesheets4_service.json')
billing <- "meu-primeiro-projeto-"

#Conectando no bigquery
con <- dbConnect(
  bigrquery::bigquery(),
  project = "meu-primeiro-projeto-",
  dataset = "",
  billing = billing
)
con

#Setando os dados
project <- 'meu-primeiro-projeto-197214'
dataset <- 'sabin_monitoramento'

#Criando uma nova table
GA_table = bq_table(project = project, dataset = dataset, table = '')
#bq_table_create(x = GA_table, fields = as_bq_fields(web_data))

#upando os dados
bq_table_upload(x = GA_table, values = web_data, create_disposition='CREATE_IF_NEEDED', write_disposition='WRITE_APPEND')

print(Sys.time())


print("GA_Sessoes")


