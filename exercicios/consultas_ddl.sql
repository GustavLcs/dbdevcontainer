-- Criação da tabela Pessoa:
CREATE TABLE Pessoas (
    cpf char(11) NOT NULL,
    email varchar(50) NOT NULL,
    nome varchar(150) NOT NULL,
    data_nasc date NOT NULL,
    endereco varchar(300) NOT NULL,
    telefone varchar(15) NULL,
    CONSTRAINT pessoa_pk PRIMARY KEY (cpf),
    CONSTRAINT email_nome_uniquegroup Unique(email, nome)
);


-- Criação da tabela Paciente
CREATE TABLE Pacientes (
    cpf_pessoa char(11) NOT NULL,
    senha varchar(20) NOT NULL,
    plano_saude boolean NOT NULL DEFAULT 0,
    CONSTRAINT cpf_pessoa_fk FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa(cpf) ON DELETE CASCADE,
    CONSTRAINT cpf_pessoa_pk PRIMARY KEY (cpf_pessoa)
);


-- Criação da tabela Médico
CREATE TABLE Medicos (
    cpf_pessoa char(11) NOT NULL,
    crm varchar(10) NOT NULL UNIQUE,
    CONSTRAINT cpf_pessoa_fk FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa(cpf) ON DELETE CASCADE,
    CONSTRAINT cpf_pessoa_pk PRIMARY KEY (cpf_pessoa)
);


-- Criação da tabela Agendamento
CREATE TABLE Agendamentos (
    cpf_paciente char(11) NOT NULL,
    cpf_medico char(11) NOT NULL,
    dh_consulta timestamp NULL,
    dh_agendamento datetime NOT NULL,
    valor_consulta decimal(10, 2) NOT NULL DEFAULT(0.0),
    CONSTRAINT cpf_paciente_fk FOREIGN KEY (cpf_paciente) REFERENCES Pacientes(cpf_pessoa),
    CONSTRAINT cpf_medico_fk FOREIGN KEY (cpf_medico) REFERENCES Medicos(cpf_pessoa),
    CONSTRAINT cpf_paciente_pk PRIMARY KEY (cpf_paciente),
    CONSTRAINT cpf_medico_pk PRIMARY KEY (cpf_medico)
);


-- Criação da tabela Especialidade
CREATE TABLE Especialidades (
    id int GENERATED ALWAYS AS IDENTITY,
    descricao varchar(300) NOT NULL,
    CONSTRAINT id_pk PRIMARY KEY (id)
);


-- Criação da tabela MedicoEspecialidades
CREATE TABLE MedicoEspecialidades (
    cpf_medico char(11) NOT NULL,
    id_especialidade int NOT NULL,
    CONSTRAINT cpf_medico_fk FOREIGN KEY (cpf_medico) REFERENCES Medicos(cpf_pessoa),
    CONSTRAINT id_especialidade_fk FOREIGN KEY (id_especialidade) REFERENCES Especialidades(id),
    CONSTRAINT cpf_medico_pk PRIMARY KEY (cpf_medico),
    CONSTRAINT id_especialidade_pk PRIMARY KEY (id_especialidade)
);
