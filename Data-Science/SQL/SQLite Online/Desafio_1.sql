-- Consulta 1: Retorne todas as disciplinas
SELECT * from Disciplinas;

-- Consulta 2: Retorne os alunos que estão aprovados na disciplina de matemática
SELECT nome_aluno, n.Nota
from Alunos a 
JOIN Notas n ON n.ID_Aluno = a.ID_Aluno
WHERE n.ID_Disciplina = '1' AND n.Nota >= '7.0';

-- Consulta 3: Identificar o total de disciplinas por turma
SELECT  t.Nome_Turma as Turma, COUNT(td.ID_Disciplina) AS 'Total de Disciplinas'
FROM Turma_Disciplinas td
JOIN Turmas t ON t.ID_Turma = td.ID_Turma
GROUP BY id_disciplina;

-- Consulta 4: Porcentagem dos alunos que estão aprovados
SELECT
    (SELECT COUNT(*) FROM Alunos) AS Total_Alunos,
    (SELECT COUNT(*) FROM Alunos a JOIN Notas n ON n.ID_Aluno = a.ID_Aluno WHERE n.Nota >= 7.0) AS Alunos_Aprovados,
    (SELECT COUNT(*) FROM Notas) AS Total_Notas,
    (ROUND(100.0 * (SELECT COUNT(*) FROM Alunos a JOIN Notas n ON n.ID_Aluno = a.ID_Aluno WHERE n.Nota >= 7.0) / (SELECT COUNT(*) 
    FROM Notas), 2) || '%') AS Porcentagem

-- Consulta 5: Porcentagem dos alunos que estão aprovados por disciplina
SELECT 
    d.Nome_Disciplina AS Disciplina,
    COUNT(*) AS Total_Alunos,
    SUM(CASE WHEN n.Nota >= 7.0 THEN 1 ELSE 0 END) AS Alunos_Aprovados,
    ROUND (SUM(CASE WHEN n.Nota >= 7.0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) || '%' AS Porcentagem_Aprovados
FROM 
    Alunos a 
JOIN 
    Notas n ON n.ID_Aluno = a.ID_Aluno
JOIN 
    Disciplinas d ON d.ID_Disciplina = n.ID_Disciplina
GROUP BY 
    Disciplina;