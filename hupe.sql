SELECT
     COUNT(*) AS qtd_atendimento,
     pac.cd_paciente   AS prontuario,
     pac.nm_paciente,
     CONCAT(TRUNC( ( (SYSDATE) - NVL(pac.dt_nascimento,SYSDATE) ) / 365.25),' ano(s)') AS idade_paciente,
     gi.ds_grau_ins,
     raccor.nm_raca_cor,
     DECODE(pac.tp_sexo,'M','MASCULINO','F','FEMININO','I','INDETERMINADO') AS sexo,
     DECODE(pac.tp_estado_civil,'S','SOLTEIRO','C','CASADO','V','VIUVO','D','DESQUITADO','I','DIVORCIADO','U','UNIÃO CONSENSUAL',
     NULL,'NAO INFORMADO') AS estado_civil,
     pac.nm_bairro,
     rel.ds_religiao,
     pro.nm_profissao,
     pac.nr_identidade,
     pac.nr_cpf,
     pac.nr_cns,
     cid.ds_cidadania,
     lei.ds_leito,
     UI.ds_unid_int,
     se.nm_setor,
     gc.ds_grupo_de_custo,
     est.ds_estoque,
     ac.hr_inicio,
     ac.hr_fim,
     ac.cd_agenda_central,
     ac.cd_prestador,
     ac.cd_recurso_central,
     ac.cd_unidade_atendimento
 FROM
     paciente pac
     INNER JOIN raca_cor raccor ON raccor.tp_cor = pac.tp_cor
     INNER JOIN cidadanias cid ON cid.cd_cidadania = pac.cd_cidadania
     INNER JOIN grau_ins gi ON gi.cd_grau_ins = pac.cd_grau_ins
     INNER JOIN religiao rel ON rel.cd_religiao = pac.cd_religiao
     INNER JOIN profissao pro ON pro.cd_profissao = pac.cd_profissao
     INNER JOIN atendime ate ON ate.cd_paciente = pac.cd_paciente
     INNER JOIN leito lei ON lei.cd_leito = ate.cd_leito
     INNER JOIN unid_int UI ON UI.cd_unid_int = lei.cd_unid_int
     INNER JOIN setor se ON se.cd_setor = UI.cd_setor
     INNER JOIN grupo_de_custo gc ON gc.cd_grupo_de_custo = se.cd_grupo_de_custo
     LEFT JOIN estoque est ON est.cd_estoque = UI.cd_setor
     LEFT JOIN solsai_pro sp ON sp.cd_atendimento = ate.cd_atendimento
     LEFT JOIN prestador pres ON pres.cd_prestador = sp.cd_prestador
     LEFT JOIN agenda_central ac ON ac.cd_setor = se.cd_setor
 WHERE
     pac.nm_paciente LIKE '%'
     AND UI.sn_ativo = 'S'
     AND pac.cd_multi_empresa = 2
     AND se.sn_centro_de_custo = 'S'
     AND gc.sn_ativo = 'S'
 GROUP BY
     pac.cd_paciente,
     pac.nm_paciente,
     CONCAT(TRUNC( ( (SYSDATE) - NVL(pac.dt_nascimento,SYSDATE) ) / 365.25),' ano(s)'),
     gi.ds_grau_ins,
     raccor.nm_raca_cor,
     DECODE(pac.tp_sexo,'M','MASCULINO','F','FEMININO','I','INDETERMINADO'),
     DECODE(pac.tp_estado_civil,'S','SOLTEIRO','C','CASADO','V','VIUVO','D','DESQUITADO','I','DIVORCIADO','U','UNIÃO CONSENSUAL',
     NULL,'NAO INFORMADO'),
     pac.nm_bairro,
     rel.ds_religiao,
     pro.nm_profissao,
     pac.nr_identidade,
     pac.nr_cpf,
     pac.nr_cns,
     cid.ds_cidadania,
     lei.ds_leito,
     UI.ds_unid_int,
     se.nm_setor,
     gc.ds_grupo_de_custo,
     est.ds_estoque,
     ac.hr_inicio,
     ac.hr_fim,
     ac.cd_agenda_central,
     ac.cd_prestador,
     ac.cd_recurso_central,
     ac.cd_unidade_atendimento
 ORDER BY
     pac.nm_paciente
