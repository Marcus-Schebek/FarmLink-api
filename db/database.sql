-- -----------------------------------------------------------
-- Limpa e cria o banco de dados 'farm'
-- -----------------------------------------------------------
DROP DATABASE IF EXISTS farm;
CREATE DATABASE farm;

-- -----------------------------------------------------------
-- Tabela de usuários (com login e senha)
-- -----------------------------------------------------------
CREATE TABLE app_user (
    id_user SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(255),
    email VARCHAR(255) NOT NULL UNIQUE,
    cpf_cnpj VARCHAR(255) UNIQUE,
    address VARCHAR(255),
    password_digest VARCHAR(255) NOT NULL
);

-- -----------------------------------------------------------
-- Lotes
-- -----------------------------------------------------------
CREATE TABLE lot (
    id_lot SERIAL PRIMARY KEY,
    creation_date DATE NOT NULL,
    origin_location VARCHAR(255)
);

-- -----------------------------------------------------------
-- Medicamentos
-- -----------------------------------------------------------
CREATE TABLE medicine (
    id_medicine SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    manufacturer VARCHAR(255) NOT NULL,
    dosage VARCHAR(255) NOT NULL,
    type VARCHAR(255),
    cost DECIMAL(10, 2)
);

-- -----------------------------------------------------------
-- Dietas
-- -----------------------------------------------------------
CREATE TABLE diet (
    id_diet SERIAL PRIMARY KEY,
    aliment_type VARCHAR(255) NOT NULL,
    cost_kg DECIMAL(10, 2),
    nutrients TEXT
);

-- -----------------------------------------------------------
-- Animais
-- -----------------------------------------------------------
CREATE TABLE animal (
    id_animal SERIAL PRIMARY KEY,
    ear_tag VARCHAR(255) NOT NULL,
    breed VARCHAR(255),
    sex VARCHAR(10),
    birth_date DATE,
    current_weight DECIMAL(10, 2),
    status VARCHAR(255),
    production_objective VARCHAR(255),
    id_lot INT,
    id_owner INT,
    FOREIGN KEY (id_lot) REFERENCES lot(id_lot) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_owner) REFERENCES app_user(id_user) ON UPDATE CASCADE ON DELETE SET NULL
);

-- -----------------------------------------------------------
-- Vendas
-- -----------------------------------------------------------
CREATE TABLE sale (
    id_sale SERIAL PRIMARY KEY,
    sale_date DATE NOT NULL,
    total_value DECIMAL(10,2),
    payment_method VARCHAR(255),
    id_seller INT NOT NULL,
    id_buyer INT NOT NULL,
    FOREIGN KEY (id_seller) REFERENCES app_user (id_user) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_buyer) REFERENCES app_user (id_user) ON UPDATE CASCADE ON DELETE SET NULL
);

-- -----------------------------------------------------------
-- Relação venda ↔ animal
-- -----------------------------------------------------------
CREATE TABLE sale_animal (
    id_sale INT NOT NULL,
    id_animal INT NOT NULL,
    PRIMARY KEY (id_sale, id_animal),
    FOREIGN KEY (id_sale) REFERENCES sale (id_sale) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_animal) REFERENCES animal (id_animal) ON UPDATE CASCADE ON DELETE CASCADE
);

-- -----------------------------------------------------------
-- Sintomas
-- -----------------------------------------------------------
CREATE TABLE symptom (
    id_symptom SERIAL PRIMARY KEY,
    id_animal INT NOT NULL,
    date_symptom DATE NOT NULL,
    description TEXT,
    FOREIGN KEY (id_animal) REFERENCES animal(id_animal) ON UPDATE CASCADE ON DELETE CASCADE
);

-- -----------------------------------------------------------
-- Cio
-- -----------------------------------------------------------
CREATE TABLE heat (
    id_heat SERIAL PRIMARY KEY,
    id_animal INT NOT NULL,
    date_heat DATE NOT NULL,
    observation TEXT,
    FOREIGN KEY (id_animal) REFERENCES animal(id_animal) ON UPDATE CASCADE ON DELETE CASCADE
);

-- -----------------------------------------------------------
-- Aplicações de medicamento
-- -----------------------------------------------------------
CREATE TABLE application (
    id_application SERIAL PRIMARY KEY,
    application_date DATE NOT NULL,
    notes TEXT,
    id_animal INT NOT NULL,
    id_medicine INT NOT NULL,
    FOREIGN KEY (id_animal) REFERENCES animal (id_animal) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_medicine) REFERENCES medicine (id_medicine) ON UPDATE CASCADE ON DELETE SET NULL
);

-- -----------------------------------------------------------
-- Relação animal ↔ dieta
-- -----------------------------------------------------------
CREATE TABLE animal_diet (
    id_animal INT NOT NULL,
    id_diet INT NOT NULL,
    date_beginning DATE NOT NULL,
    date_end DATE,
    daily_quantity DECIMAL(10, 2),
    PRIMARY KEY (id_animal, id_diet, date_beginning),
    FOREIGN KEY (id_animal) REFERENCES animal(id_animal) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_diet) REFERENCES diet(id_diet) ON UPDATE CASCADE ON DELETE CASCADE
);
