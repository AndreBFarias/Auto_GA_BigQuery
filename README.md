## Auto_GA_BigQuery


Projeto em que se consegue extrair valores do Google Analytics e depois upa-los no BigQuery para conectar no DataStudio.

Você necessariamente vai preciar de um arquivo "googlesheets4_service.json" e de um "token.txt", basta colocar eles na mesma pasta.



## Construção da Query  
Ao escolher as dimensões e as métricas deve-se observar exatamente o que você quer

Funciona tal qual o Data Studio

Para saber se elas podem ser utilizadas juntas devo olhar o seguinte site:

https://ga-dev-tools.appspot.com/dimensions-metrics-explorer/?csw=1#validCombinations


## Pacote base  

Pacote usado: 

https://cran.r-project.org/web/packages/googleAnalyticsR/googleAnalyticsR.pdf

