-- -----------------------------------------------------------
-- Inserção de dados
-- -----------------------------------------------------------

-- Inserção de usuários (antigos vendedores, compradores e o novo dono da fazenda)
INSERT INTO app_user (name, phone, email, cpf_cnpj, address, password_digest) VALUES
('Fazenda Central', NULL, 'fazenda@email.com', '00000000000000', 'Sede da Fazenda, 1', 'hashed_password_1'),
('João da Silva', '5511987654321', 'joao.silva@email.com', '12345678901234', 'Rua das Vacas, 123', 'hashed_password_2'),
('Maria Oliveira', '5521912345678', 'maria.olivera@email.com', '98765432101', 'Avenida dos Gados, 456', 'hashed_password_3'),
('Pedro Souza', NULL, 'pedro.souza@email.com', '55544433322211', 'Estrada do Boi, 789', 'hashed_password_4');

INSERT INTO lot (creation_date, origin_location) VALUES
('2022-01-15', 'Fazenda São João'),
('2023-03-20', 'Fazenda Camaquã'),
('2023-11-01', 'Fazenda Internacional');

INSERT INTO medicine (name, manufacturer, dosage, type, cost) VALUES
('Vermífugo A', 'Pharma Agro', '10ml', 'Vermífugo', 50.00),
('Antibiótico B', 'Agro Vida', '20mg/kg', 'Antibiótico', 120.50),
('Vacina C', 'Bovino Health', '5ml', 'Vacina', 75.25);

INSERT INTO diet (aliment_type, cost_kg, nutrients) VALUES
('Pasto e Ração Crescimento', 1.50, 'Alto em proteínas para ganho de peso.'),
('Ração de Manutenção', 1.00, 'Balanceada para manutenção de peso.'),
('Pasto de Alta Qualidade', 0.80, 'Rico em fibras e vitaminas.');

-- Inserção de dados nas tabelas principais

-- id_owner: 1 (Fazenda Central)
INSERT INTO animal (ear_tag, breed, sex, birth_date, current_weight, status, production_objective, id_lot, id_owner) VALUES
('BR0001', 'Nelore', 'M', '2022-05-10', 350.5, 'Ativo', 'Corte', 1, 1),
('BR0002', 'Angus', 'F', '2022-08-20', 280.0, 'Ativo', 'Reprodução', 1, 1),
('BR0003', 'Holandês', 'F', '2023-01-05', 180.2, 'Ativo', 'Leite', 2, 1),
('BR0004', 'Nelore', 'M', '2023-07-12', 150.0, 'Ativo', 'Corte', 3, 1);

-- id_seller: 1 (João), id_buyer: 2 (Maria) ou 3 (Pedro)
INSERT INTO sale (sale_date, total_value, payment_method, id_seller, id_buyer) VALUES
('2023-08-01', 5000.00, 'Transferência Bancária', 2, 3), -- Vendedor João, Comprador Pedro
('2023-09-15', 3500.00, 'Pix', 3, 4), -- Vendedor Maria, Comprador Empresa
('2023-12-10', 12000.00, 'Boleto', 2, 4); -- Vendedor João, Comprador Empresa

-- -----------------------------------------------------------
-- Inserção de dados nas tabelas de junção e registro
-- -----------------------------------------------------------

INSERT INTO symptom (id_animal, date_symptom, description) VALUES
(1, '2023-06-25', 'Tosse frequente e perda de apetite.'),
(3, '2023-09-10', 'Manchas na pele.');

INSERT INTO heat (id_animal, date_heat, observation) VALUES
(2, '2023-08-30', 'Primeiro cio, comportamento normal.'),
(3, '2023-10-05', 'Cio detectado, pronta para inseminação.');

INSERT INTO application (application_date, notes, id_animal, id_medicine) VALUES
('2023-06-26', 'Início do tratamento com antibiótico.', 1, 2),
('2023-09-11', 'Tratamento tópico para as manchas.', 3, 1),
('2023-11-20', 'Vacina anual.', 4, 3);

INSERT INTO sale_animal (id_sale, id_animal) VALUES
(1, 2),
(2, 3),
(3, 1);

INSERT INTO animal_diet (id_animal, id_diet, date_beginning, date_end, daily_quantity) VALUES
(1, 1, '2022-05-10', '2023-01-01', 5.0),
(1, 2, '2023-01-02', NULL, 6.5),
(2, 1, '2022-08-20', NULL, 4.0),
(3, 3, '2023-01-05', NULL, 20.0);

-- -----------------------------------------------------------
-- Consultas
-- -----------------------------------------------------------

-- Listar todos os animais, exibindo a identificação da orelha (ear_tag), a raça e a data de nascimento.
SELECT ear_tag, breed, birth_date
FROM animal;

-- Calcular o valor total de todas as vendas realizadas.
SELECT SUM(total_value) AS valor_total_vendas
FROM sale;

-- Obter a lista de animais, mostrando o nome da raça e o local de origem do lote.
SELECT
    a.ear_tag,
    a.breed,
    a.sex,
    l.origin_location
FROM
    animal a
INNER JOIN
    lot l ON a.id_lot = l.id_lot;

-- Encontrar quais animais foram vendidos, para qual comprador e por qual vendedor.
-- Agora usa a tabela 'app_user' duas vezes com aliases para diferenciar comprador e vendedor.
SELECT
    an.ear_tag AS animal_id,
    buyer.name AS nome_comprador,
    seller.name AS nome_vendedor,
    s.sale_date AS data_venda
FROM
    sale_animal san
INNER JOIN
    animal an ON san.id_animal = an.id_animal
INNER JOIN
    sale s ON san.id_sale = s.id_sale
INNER JOIN
    app_user buyer ON s.id_buyer = buyer.id_user
INNER JOIN
    app_user seller ON s.id_seller = seller.id_user;

-- Listar todos os animais e a última data de sintoma registrada, se houver.
SELECT
    a.ear_tag,
    a.breed,
    s.date_symptom AS ultima_data_sintoma,
    s.description AS descricao_sintoma
FROM
    animal a
LEFT JOIN
    symptom s ON a.id_animal = s.id_animal
ORDER BY
    a.ear_tag;

-- Calcular o custo total de medicamentos aplicados por animal.
SELECT
    a.ear_tag,
    SUM(m.cost) AS custo_total_medicamentos
FROM
    animal a
INNER JOIN
    application app ON a.id_animal = app.id_animal
INNER JOIN
    medicine m ON app.id_medicine = m.id_medicine
GROUP BY
    a.ear_tag
ORDER BY
    custo_total_medicamentos DESC;

-- Encontrar o nome do medicamento mais caro e o seu custo.
SELECT name, cost
FROM medicine
WHERE cost = (SELECT MAX(cost) FROM medicine);

-- Listar os animais atualmente em uma dieta específica.
SELECT
    a.ear_tag,
    d.aliment_type
FROM
    animal a
INNER JOIN
    animal_diet ad ON a.id_animal = ad.id_animal
INNER JOIN
    diet d ON ad.id_diet = d.id_diet
WHERE
    ad.date_end IS NULL;


-- -----------------------------------------------------------
-- Procedimento e Gatilho (Trigger)
-- -----------------------------------------------------------

-- Caso animal seja atualizado, atualiza status para vendido
-- e um novo registro é inserido na tabela 'sale_animal'.
CREATE OR REPLACE FUNCTION update_animal_status_after_sale()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE animal
    SET status = 'Vendido'
    WHERE id_animal = NEW.id_animal;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Este gatilho está ligado à tabela 'sale_animal'.
-- Ele executa a função 'update_animal_status_after_sale'
-- após cada nova linha ser inserida (AFTER INSERT).
CREATE TRIGGER trg_update_animal_status
AFTER INSERT ON sale_animal
FOR EACH ROW
EXECUTE FUNCTION update_animal_status_after_sale();
