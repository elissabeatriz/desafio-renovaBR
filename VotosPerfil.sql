ALTER TABLE [dbo].[eleitorado_sp]
ALTER COLUMN [CD_MUNICIPIO] INT;

ALTER TABLE [dbo].[eleitorado_sp]
ALTER COLUMN [NR_ZONA] INT;

ALTER TABLE [dbo].[eleitorado_sp]
ALTER COLUMN [CD_GENERO] INT;

ALTER TABLE [dbo].[eleitorado_sp]
ALTER COLUMN [CD_ESTADO_CIVIL] INT;

ALTER TABLE [dbo].[eleitorado_sp]
ALTER COLUMN [CD_FAIXA_ETARIA] INT;

ALTER TABLE [dbo].[eleitorado_sp]
ALTER COLUMN [QT_ELEITORES_PERFIL] INT;

ALTER TABLE [dbo].[votos]
ALTER COLUMN [CD_MUNICIPIO] INT;

ALTER TABLE [dbo].[votos]
ALTER COLUMN [NR_ZONA] INT;

ALTER TABLE [dbo].[votos]
ALTER COLUMN [NR_SECAO] INT;

ALTER TABLE [dbo].[votos]
ALTER COLUMN [QT_VOTOS] INT;

ALTER TABLE [dbo].[votos]
ALTER COLUMN [NR_URNA_EFETIVADA] INT;


WITH Zona AS (
	SELECT
        [NR_ZONA],
        [NM_MUNICIPIO],
        [NM_VOTAVEL] AS Candidato_mais_votado,
        [DS_CARGO_PERGUNTA],
        [SG_PARTIDO],
        SUM([QT_VOTOS]) AS Zona_total_votos,
        ROW_NUMBER() OVER (PARTITION BY [NR_ZONA] ORDER BY SUM([QT_VOTOS]) DESC) AS rank
    FROM [dbo].[votos]
    GROUP BY [NR_ZONA], [NM_MUNICIPIO], [NM_VOTAVEL], [DS_CARGO_PERGUNTA], [SG_PARTIDO]
),

PerfilEleitorado AS (
    SELECT
        [NR_ZONA],
        [DS_GENERO],
        [DS_FAIXA_ETARIA],
        [DS_GRAU_ESCOLARIDADE],
        [DS_ESTADO_CIVIL],
        SUM([QT_ELEITORES_PERFIL]) AS Total_por_perfil,
        ROW_NUMBER() OVER (PARTITION BY [NR_ZONA] ORDER BY SUM([QT_ELEITORES_PERFIL]) DESC) AS profile_rank
    FROM [dbo].[eleitorado_sp]
    GROUP BY [NR_ZONA], [DS_GENERO], [DS_FAIXA_ETARIA], [DS_GRAU_ESCOLARIDADE], [DS_ESTADO_CIVIL]
),

PrefeitoEleito AS (
    SELECT
        [NM_MUNICIPIO],
        [NM_VOTAVEL] AS Prefeito_eleito,
        SUM([QT_VOTOS]) AS Total_votos,
        ROW_NUMBER() OVER (PARTITION BY [NM_MUNICIPIO] ORDER BY SUM([QT_VOTOS]) DESC) AS rank
    FROM [dbo].[votos]
    WHERE [DS_CARGO_PERGUNTA] = 'PREFEITO'
    GROUP BY [NM_MUNICIPIO], [NM_VOTAVEL]
)

SELECT
    z.[NR_ZONA] AS Zona_eleitoral,
    z.[NM_MUNICIPIO] AS Municipio,	
    z.[Candidato_mais_votado] AS Mais_votado_CandidatoZona,
	z.[Zona_total_votos] AS Total_de_votos_CandidatoZona,
	z.[DS_CARGO_PERGUNTA] AS Cargo,
    z.[SG_PARTIDO] AS Partido,
    e.[DS_GENERO] AS Genero_PerfilZona,
    e.[DS_FAIXA_ETARIA] AS Faixa_etaria_PerfilZona,
    e.[DS_GRAU_ESCOLARIDADE] AS Grau_escolaridade_PerfilZona,
    e.[DS_ESTADO_CIVIL] AS Estado_civil_PerfilZona,
    p.[Prefeito_eleito] AS Candidato_eleito_PrefeitoMunicipio,
    p.[Total_votos] AS Total_de_votos_PrefeitoMunicipio

FROM Zona z
INNER JOIN PerfilEleitorado e ON z.[NR_ZONA] = e.[NR_ZONA]
LEFT JOIN PrefeitoEleito p ON z.[NM_MUNICIPIO] = p.[NM_MUNICIPIO] AND p.rank = 1
WHERE z.rank = 1 AND e.profile_rank = 1;
