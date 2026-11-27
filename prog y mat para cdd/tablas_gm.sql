CREATE SCHEMA proyecto;
SET search_path TO proyecto;

CREATE TABLE gusano_barrenador (
	id_gb INT PRIMARY KEY,
	especie VARCHAR(50) NOT NULL,
	esperanza_vida INT NOT NULL,
	longitud INT NOT NULL 
);

CREATE TABLE salud (
	id_salud INT PRIMARY KEY,
	tipo_lesion VARCHAR(50) NOT NULL,
	region_danada VARCHAR(50) NOT NULL,
	gravedad VARCHAR(50) NOT NULL,
	embarazo VARCHAR(10) NOT NULL
);

CREATE TABLE animal (
	id_animal INT PRIMARY KEY,
	edad INT NOT NULL,
	sexo VARCHAR(15) NOT NULL,
	especie VARCHAR(15) NOT NULL,
	peso INT NOT NULL,
	id_salud INT NOT NULL,
	FOREIGN KEY (id_salud) REFERENCES salud(id_salud)
);

CREATE TABLE lugar (
	id_lugar INT PRIMARY KEY,
	latitud REAL NOT NULL,
	longitud REAL NOT NULL,
	municipio VARCHAR(50) NOT NULL,
	estado VARCHAR(50) NOT NULL
);

--DROP TABLE casos_infectados;
CREATE TABLE casos_infectados (
	id_caso INT PRIMARY KEY,
	fecha DATE NOT NULL,
	resultado_caso VARCHAR(50) NOT NULL,
	tratamiento VARCHAR(50) NOT NULL,
	id_animal INT NOT NULl,
	id_lugar INT NOT NULl,
	id_gb INT NOT NULL,
	FOREIGN KEY (id_animal) REFERENCES animal(id_animal),
	FOREIGN KEY (id_lugar) REFERENCES lugar(id_lugar),
	FOREIGN KEY (id_gb) REFERENCES gusano_barrenador(id_gb) 
);

CREATE TABLE camapanas_prevencion (
	id_prevencion INT PRIMARY KEY,
	fecha DATE NOT NULL,
	resultado INT NOT NULL,
	revision_ganado VARCHAR(50) NOT NULL,
	larvicida VARCHAR(50) NOT NULL,
	control_mosca VARCHAR(50),
	moscas_esteriles_liberadas INT,
	id_lugar INT NOT NULL,
	FOREIGN KEY (id_lugar) REFERENCES lugar(id_lugar)
);

CREATE TABLE registro_climatico (
	id_registro INT PRIMARY KEY,
	precipitacion REAL NOT NULL,
	temperatura DECIMAL(2,2) NOT NULL,
	humedad DECIMAL(2,2) NOT NULL,
	frecuencia INT NOT NULL,
	fecha DATE NOT NULL,
	id_lugar INT NOT NULL,
	FOREIGN KEY (id_lugar) REFERENCES lugar(id_lugar)
);



INSERT INTO gusano_barrenador (id_gb, especie, esperanza_vida, longitud)
VALUES 
('1', 'Cochliomyia hominivorax', '21', '15'),
('2', 'Cochliomyia macellaria', '18', '12'),
('3', 'Chrysomya megacephala', '20', '10'),
('4', 'Dermatobia hominis', '25', '18'),
('5', 'Sarcophaga carnaria', '15', '9');

SELECT * FROM gusano_barrenador;


-- con una tabla ya creada
COPY lugar(id_lugar, latitud, longitud, municipio, estado)
FROM 'D:\papeles maestria\ejercicios_maestria_icd\prog y mat para cdd\datos\lugar.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM lugar;


CREATE OR REPLACE VIEW gusano_macellaria AS
SELECT * 
FROM gusano_barrenador
WHERE especie = 'Cochliomyia macellaria';


COPY casos_infectados(id_caso, fecha, resultado_caso, tratamiento, id_animal, id_lugar, id_gb)
FROM 'D:\papeles maestria\ejercicios_maestria_icd\prog y mat para cdd\datos\casos_afectados.csv'
DELIMITER ',' CSV HEADER;











