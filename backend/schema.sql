-- Banco de Dados: IntegraMedic

-- ==========================================
-- Módulo 0: Controle de Acesso e Usuários
-- ==========================================
CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    -- Níveis de Permissão solicitados: TOTAL, MEDIANA, CONSULTA
    nivel_permissao VARCHAR(20) CHECK (nivel_permissao IN ('TOTAL', 'MEDIANA', 'CONSULTA')) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- Módulo 1: Cadastro de Pacientes (Odonto/Med)
-- ==========================================
CREATE TABLE IF NOT EXISTS pacientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco TEXT,
    
    -- Dados Clínicos e Odontológicos Básicos
    tipo_sanguineo VARCHAR(5),
    alergias TEXT,
    medicamentos_uso_continuo TEXT,
    observacoes_odontologicas TEXT,
    
    -- Sistema de Pontuação/Fidelidade
    pontuacao INT DEFAULT 0,
    
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Auxiliar para Odontograma
CREATE TABLE IF NOT EXISTS paciente_odontograma (
    id SERIAL PRIMARY KEY,
    paciente_id INT REFERENCES pacientes(id) ON DELETE CASCADE,
    numero_dente INT NOT NULL, 
    estado_dente VARCHAR(100), 
    observacao TEXT,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);