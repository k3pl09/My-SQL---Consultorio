CREATE DATABASE Consultorio;
USE consultorio;

-- Tabla de Pacientes
CREATE TABLE pacientes (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(15),
    direccion VARCHAR(255)
);

-- Tabla de Doctores
CREATE TABLE doctores (
    id_doctor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100) UNIQUE
);

-- Tabla de Historial Clínico
CREATE TABLE historial_clinico (
    id_historial INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT,
    enfermedades_previas VARCHAR(100),
    alergias VARCHAR(100),
    medicamentos_habituales VARCHAR(100),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente) ON DELETE CASCADE
);


-- Tabla de Citas
CREATE TABLE citas (
    id_cita INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT,
    id_doctor INT,
    fecha_hora DATETIME,
    motivo VARCHAR(255),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente) ON DELETE SET NULL,
    FOREIGN KEY (id_doctor) REFERENCES doctores(id_doctor) ON DELETE SET NULL
);

-- Tabla de Consultas
CREATE TABLE consultas (
    id_consulta INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT,
    id_doctor INT,
    fecha DATE,
    diagnostico VARCHAR(100),
    tratamiento VARCHAR(100),
    observaciones VARCHAR(100),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente) ON DELETE SET NULL,
    FOREIGN KEY (id_doctor) REFERENCES doctores(id_doctor) ON DELETE SET NULL
);


