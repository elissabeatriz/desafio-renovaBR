# Desafio RenovaBR: Análise das eleições municipais do estado de São Paulo no ano de 2020

Este repositório contém o processo de desenvolvimento de uma análise eleitoral utilizando Python para o tratamento dos dados e SQL Server para realizar consultas analíticas. O objetivo é obter informações sobre os resultados das eleições e os perfis demográficos dos eleitores.

## Etapa 1: Tratamento dos Dados em Python

### Passo 1: Tratamento da Base de Dados do perfil_eleitorado_2020

1. Execute o script 'eleitorado_sp.py' para tratar os dados do eleitorado.
2. O script carrega o arquivo CSV 'perfil_eleitorado_2020.csv', seleciona as colunas relevantes e remove valores nulos.
3. Os dados são filtrados para incluir apenas o estado de São Paulo.
4. Os dados tratados são salvos em um novo arquivo CSV chamado 'eleitorado_sp.csv'.

Para esta análise do perfil do eleitorado de SP, as colunas de data e hora de geração e situação da biometria de município não são relevantes.
Interessante deixar os códigos de linha correspondentes a cada município e a cada perfil (gênero, estado civil, faixa etária e grau de escolaridade) para o caso de haver problemas
com valores repetidos.

### Passo 2: Tratamento da base de dados dados SP_turno_1

1. Execute o script 'votos_resultados.py' para tratar os dados dos resultados das eleições.
2. O script carrega o arquivo CSV 'SP_turno_1.csv', seleciona as colunas relevantes e remove valores nulos.
3. Linhas com votos nulos e brancos (#NULOS#) são filtradas e correções em nomes de candidatos são feitas .
4. Os dados tratados são salvos em um novo arquivo CSV chamado 'votos.csv'.

Para esta análise, são relevantes as informações: município, candidato, partido, cargo, zona eleitoral, urna e quantidade de votos registrada.

## Etapa 2: Consultas Analíticas no SQL Server

1. Importe os arquivos CSV 'eleitorado_sp.csv' e 'votos.csv' para o SQL Server;
2. Altere o tipo das colunas numéricas para int (na exportação, todas as colunas se alteram para Varchar);
3. Execute as consultas SQL contidas nos códigos 'consulta_sql.sql' para obter informações analíticas sobre os resultados das eleições e o perfil demográfico dos eleitores.

## Considerações Finais

Este projeto demonstra como realizar análises eleitorais utilizando Python e SQL Server. Sinta-se à vontade para adaptar os códigos e consultas de acordo com suas necessidades.

## Autora

Elissa Beatriz Martins


