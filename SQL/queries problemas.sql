-- PROBLEMA 1
SELECT p.nombre,p.apellido ,p.telefono,p.fecha_nacimiento,c.fecha_hora ,
c.motivo,con.fecha AS "Fecha de Consulta",con.diagnostico,con.tratamiento,
con.observaciones,d.nombre ,d.apellido  FROM pacientes p
LEFT JOIN  citas c ON p.id_paciente = c.id_paciente
LEFT JOIN consultas con ON p.id_paciente = con.id_paciente
LEFT JOIN doctores d ON c.id_doctor = d.id_doctor OR con.id_doctor = d.id_doctor
ORDER BY 
p.id_paciente,
c.fecha_hora, 
con.fecha;


-- PROBLEMA 2
SELECT p.nombre,p.apellido,con.tratamiento ,con.fecha
FROM  pacientes p, consultas con WHERE  p.id_paciente = con.id_paciente
AND con.tratamiento IS NOT NULL AND con.tratamiento != '';


-- PROBLEMA 3
CREATE VIEW vista_primera_consulta AS
SELECT p.nombre,p.apellido, MIN(c.fecha) "Fecha de Primera Consulta"
FROM pacientes p, consultas c WHERE p.id_paciente = c.id_paciente
GROUP BY p.id_paciente;

SELECT * FROM vista_primera_consulta;

-- PROBLEMA 4
SELECT  nombre, apellido, fecha_nacimiento, 
DATEDIFF(CURDATE(), fecha_nacimiento) / 365 AS "Edad",
    CASE 
        WHEN DATEDIFF(CURDATE(), fecha_nacimiento) / 365 < 18 THEN 'Niño'
        WHEN DATEDIFF(CURDATE(), fecha_nacimiento) / 365 BETWEEN 18 AND 64 THEN 'Adulto'
        ELSE 'Anciano'
    END AS "Categoría de Edad"
FROM 
    pacientes;

-- PROBLEMA 5
CREATE VIEW vista_edad_y_ultima_consulta AS
SELECT  p.nombre , p.apellido , DATEDIFF(CURDATE(), p.fecha_nacimiento) / 365 AS "Edad",
(SELECT MAX(c.fecha) FROM consultas c WHERE c.id_paciente = p.id_paciente) "Fecha de Última Consulta"
FROM pacientes p;

SELECT * FROM vista_edad_y_ultima_consulta;


-- PROBLEMA 6
SELECT nombre,apellido ,ROUND(DATEDIFF(CURDATE(), fecha_nacimiento) / 365) AS "Edad"
FROM pacientes WHERE ROUND(DATEDIFF(CURDATE(), fecha_nacimiento) / 365) > 18;


-- PROBLEMA 7
CREATE VIEW enfermedades_previas AS
SELECT p.nombre,p.apellido ,h.enfermedades_previas ,d.nombre "Nombre del Doctor",d.apellido "Apellido del Doctor"
FROM  pacientes p
JOIN historial_clinico h ON p.id_paciente = h.id_paciente
JOIN consultas c ON p.id_paciente = c.id_paciente
JOIN doctores d ON c.id_doctor = d.id_doctor
WHERE h.enfermedades_previas IS NOT NULL
ORDER BY p.apellido, p.nombre;

SELECT * FROM enfermedades_previas;

-- PROBLEMA 8

SELECT p.nombre ,p.apellido ,h.alergias,con.fecha "Fecha de Última Consulta",con.tratamiento "Tratamiento Prescrito"
FROM pacientes p
JOIN historial_clinico h ON p.id_paciente = h.id_paciente
JOIN consultas con ON p.id_paciente = con.id_paciente
WHERE h.alergias IS NOT NULL
ORDER BY con.fecha DESC
LIMIT 20;

-- PROBLEMA 9 
CREATE VIEW vista_medicamentos_mas_comunes AS
SELECT con.medicamentos_habituales "Medicamento",COUNT(*) "Total de Prescripciones"
FROM historial_clinico con 
WHERE con.medicamentos_habituales IS NOT NULL AND con.medicamentos_habituales != ''
GROUP BY con.medicamentos_habituales
ORDER BY COUNT(*) DESC;

SELECT * FROM vista_medicamentos_mas_comunes LIMIT 15; 


-- PROBLEMA 10

SELECT p.nombre ,p.apellido,d.nombre,d.apellido ,COUNT(c.id_cita) AS "Total de Citas",MAX(c.fecha_hora) AS "Fecha de Última Cita",
(SELECT c2.motivo FROM citas c2 WHERE c2.id_paciente = p.id_paciente ORDER BY c2.fecha_hora DESC LIMIT 1) AS "Motivo de Última Cita"
FROM pacientes p
JOIN citas c ON p.id_paciente = c.id_paciente
JOIN doctores d ON c.id_doctor = d.id_doctor
GROUP BY p.id_paciente, d.id_doctor
ORDER BY p.apellido, p.nombre;







