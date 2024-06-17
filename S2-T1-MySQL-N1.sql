------ TIENDA
SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
SELECT * FROM producto;
SELECT nombre, Precio AS Precio_EUR, Precio * 1.10 AS Precio_USD FROM producto;
SELECT nombre AS `nom de "producto"`, Precio AS euros, Precio * 1.10 AS `dòlars nord-americans` FROM producto;
SELECT UPPER(nombre), precio FROM producto;
SELECT LOWER(nombre), precio FROM producto;
SELECT nombre AS Fabricante, UPPER(LEFT(nombre, 2)) AS 'Fabricante Abrev.' FROM fabricante;
SELECT nombre, ROUND(precio, 0) AS Redondeo FROM producto;
SELECT nombre, TRUNCATE(precio, 0) AS 'Precio Truncado' FROM producto;
SELECT codigo_fabricante FROM producto;
SELECT DISTINCT codigo_fabricante FROM producto;
SELECT nombre FROM fabricante ORDER BY nombre ASC;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 2 OFFSET 3;
SELECT nombre, precio from producto ORDER BY precio ASC LIMIT 1;

------- UNIVERSIDAD

--Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre FROM persona ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

--Esbrina el nom i els dos cognoms dels/les alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona WHERE telefono = '' OR telefono IS NULL;

--Retorna el llistat dels/les alumnes que van néixer en 1999.
SELECT * FROM persona WHERE YEAR(fecha_nacimiento) = 1999;

--Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM persona WHERE tipo='profesor' AND (telefono IS NULL OR telefono = '') AND RIGHT(nif, 1) = 'K';

--Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura WHERE id_grado = 7 AND cuatrimestre = 1 AND curso = 3;

--Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats/des. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre AS Departamento FROM persona JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;

--Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asignatura.nombre, curso_escolar.anyo_fin, curso_escolar.anyo_fin FROM asignatura JOIN alumno_se_matricula_asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE persona.nif = '26902806M';

--Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT dep.nombre AS Departamento FROM departamento dep JOIN profesor prof ON dep.id = prof.id_departamento JOIN asignatura asig ON prof.id_profesor = asig.id_profesor JOIN grado gr ON asig.id_grado = gr.id WHERE gr.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

--Retorna un llistat amb tots els/les alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT per.apellido1, per.apellido2, per.nombre FROM persona per JOIN alumno_se_matricula_asignatura al ON per.id = al.id_alumno JOIN curso_escolar ce ON al.id_curso_escolar = ce.id WHERE ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019;

--Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats/des. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT d.nombre as Departamento, p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor prof ON p.id = prof.id_profesor LEFT JOIN departamento d ON prof.id_departamento = d.id ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre ASC;

--Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT prof.id_profesor, persona.apellido1, persona.apellido2, persona.nombre FROM profesor prof LEFT JOIN persona ON prof.id_profesor = persona.id LEFT JOIN departamento ON prof.id_departamento = departamento.id WHERE departamento.id IS NULL;

--Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT d.nombre AS Departamento, prof.id_profesor FROM departamento d LEFT JOIN profesor prof ON d.id = prof.id_departamento WHERE prof.id_departamento IS NULL;

--Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT prof.id_profesor, p.nombre, p.apellido1, a.nombre AS Asignatura FROM profesor prof LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor JOIN persona p ON prof.id_profesor = p.id WHERE a.id_profesor IS NULL;

--Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT nombre AS Asignatura FROM asignatura WHERE id_profesor IS NULL ORDER BY nombre ASC;

--Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT d.nombre AS 'Dpto', ce.id AS 'Curso Escolar' FROM departamento d LEFT JOIN profesor prof ON d.id = prof.id_departamento LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor LEFT JOIN alumno_se_matricula_asignatura ama ON a.id = ama.id_asignatura LEFT JOIN curso_escolar ce ON ama.id_curso_escolar = ce.id WHERE ce.id IS NULL;

--Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(*) FROM persona WHERE tipo = 'alumno';

--Calcula quants/es alumnes van néixer en 1999.
SELECT COUNT(*) FROM persona WHERE YEAR(fecha_nacimiento) = '1999';

--Calcula quants/es professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT d.nombre AS 'Dpto.', COUNT(prof.id_profesor) AS 'Num. Professors' FROM profesor prof LEFT JOIN departamento d ON prof.id_departamento = d.id WHERE prof.id_profesor IS NOT NULL GROUP BY d.nombre ORDER BY COUNT(prof.id_profesor) DESC;

--Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Té en compte que poden existir departaments que no tenen professors/es associats/des. Aquests departaments també han d'aparèixer en el llistat.
SELECT d.nombre AS 'Dpto.', COUNT(prof.id_profesor) AS 'Num. Professors' FROM departamento d LEFT JOIN profesor prof ON d.id = prof.id_departamento GROUP BY d.nombre;

--Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Té en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT g.nombre AS Grau, COUNT(a.id) AS 'Num. Assignatures' FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY COUNT(a.id) DESC;