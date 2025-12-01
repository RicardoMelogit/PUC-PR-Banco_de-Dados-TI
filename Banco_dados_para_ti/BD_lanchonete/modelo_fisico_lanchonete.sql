-- Criando Tabelas

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP SCHEMA IF EXISTS `mydb` ;

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `mydb` ;

DROP TABLE IF EXISTS `mydb`.`Lanches` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Lanches` (
  `CodLanches` INT NOT NULL,
  `NomeLanches` VARCHAR(45) NOT NULL,
  `Descricao` VARCHAR(100) NULL,
  `ValorLanches` DECIMAL(7) NOT NULL,
  PRIMARY KEY (`CodLanches`))
ENGINE = InnoDB;

SHOW WARNINGS;

DROP TABLE IF EXISTS `mydb`.`Clientes` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Clientes` (
  `CodClientes` INT NOT NULL,
  `NomeClientes` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodClientes`))
ENGINE = InnoDB;

SHOW WARNINGS;

DROP TABLE IF EXISTS `mydb`.`Entregadores` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Entregadores` (
  `CodEntregadores` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodEntregadores`))
ENGINE = InnoDB;

SHOW WARNINGS;


DROP TABLE IF EXISTS `mydb`.`Pedidos` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`Pedidos` (
  `CodPedidos` INT NOT NULL,
  `Data_hora` DATETIME NOT NULL,
  `ValorTotal` DECIMAL(6) NOT NULL,
  `CodCliente` INT NOT NULL,
  `CodEntregador` INT NOT NULL,
  `Status` INT NULL,
  PRIMARY KEY (`CodPedidos`),
  INDEX `fk_Pedidos_Clientes1_idx` (`CodCliente` ASC) VISIBLE,
  INDEX `fk_Pedidos_Entregadores1_idx` (`CodEntregador` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_Clientes1`
    FOREIGN KEY (`CodCliente`)
    REFERENCES `mydb`.`Clientes` (`CodClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Entregadores1`
    FOREIGN KEY (`CodEntregador`)
    REFERENCES `mydb`.`Entregadores` (`CodEntregadores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

DROP TABLE IF EXISTS `mydb`.`LanchesPedidos` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `mydb`.`LanchesPedidos` (
  `Quantidade` INT NOT NULL,
  `ValorLanches` DECIMAL(4) NOT NULL,
  `CodPedidos` INT NOT NULL,
  `CodLanches` INT NOT NULL,
  PRIMARY KEY (`CodPedidos`, `CodLanches`),
  INDEX `fk_LanchesPedidos_Pedidos1_idx` (`CodPedidos` ASC) VISIBLE,
  INDEX `fk_LanchesPedidos_Lanches1_idx` (`CodLanches` ASC) VISIBLE,
  CONSTRAINT `fk_LanchesPedidos_Pedidos1`
    FOREIGN KEY (`CodPedidos`)
    REFERENCES `mydb`.`Pedidos` (`CodPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LanchesPedidos_Lanches1`
    FOREIGN KEY (`CodLanches`)
    REFERENCES `mydb`.`Lanches` (`CodLanches`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Inserindo Pedidos

DELETE FROM mydb.LanchesPedidos;
DELETE FROM mydb.Pedidos;
DELETE FROM mydb.Entregadores;
DELETE FROM mydb.Lanches;
DELETE FROM mydb.Clientes;

INSERT INTO mydb.Clientes (CodClientes, NomeClientes, Endereco, Telefone) 
VALUES (1, 'Ricardo', 'Rua lino, 456', '(11)9909-9787');
INSERT INTO mydb.Clientes (CodClientes, NomeClientes, Endereco, Telefone) 
VALUES (2, 'Mariana', 'Rua Seis, 52', '(11)9989-5878');
INSERT INTO mydb.Clientes (CodClientes, NomeClientes, Endereco, Telefone) 
VALUES (3, 'Andre', 'Rua lino, 456', '(11)9999-5787');

INSERT INTO mydb.Lanches (CodLanches, NomeLanches, Descricao, ValorLanches) 
VALUES (1, 'X-Salada', 'Pão ham, hamburguer, queijo, salada e maionese', 30.00);
INSERT INTO mydb.Lanches (CodLanches, NomeLanches, Descricao, ValorLanches) 
VALUES (2, 'X-Bacon', 'Pão ham, hamburguer, queijo, bacon e maionese', 33.00);
INSERT INTO mydb.Lanches (CodLanches, NomeLanches, Descricao, ValorLanches) 
VALUES (3, 'X-burguer', 'Pão ham, hamburguer, queijo e maionese', 25.00);

INSERT INTO mydb.Entregadores (CodEntregadores, Nome, Telefone) 
VALUES (1, 'Cachorro loco', '(11)9534-1324');
INSERT INTO mydb.Entregadores (CodEntregadores, Nome, Telefone) 
VALUES (2, 'Gabiru', '(11)9131-1313');

INSERT INTO mydb.Pedidos (CodPedidos, Data_hora, ValorTotal, CodCliente, CodEntregador, Status) 
VALUES (1,'2025-04-20 19:15:15', 55.00, 2, 1, 0);
INSERT INTO mydb.Pedidos (CodPedidos, Data_hora, ValorTotal, CodCliente, CodEntregador, Status) 
VALUES (2,'2025-04-20 20:30:00', 91.00, 1, 1, 0);
INSERT INTO mydb.Pedidos (CodPedidos, Data_hora, ValorTotal, CodCliente, CodEntregador, Status) 
VALUES (3,'2025-04-20 22:20:23', 50.00, 3, 2, 1);

INSERT INTO mydb.LanchesPedidos (Quantidade, ValorLanches, CodPedidos, CodLanches)
VALUES (1, 30.00, 1, 1);
INSERT INTO mydb.LanchesPedidos (Quantidade, ValorLanches, CodPedidos, CodLanches)
VALUES (1, 25.00, 1, 3);
INSERT INTO mydb.LanchesPedidos (Quantidade, ValorLanches, CodPedidos, CodLanches)
VALUES (2, 33.00, 2, 2);
INSERT INTO mydb.LanchesPedidos (Quantidade, ValorLanches, CodPedidos, CodLanches)
VALUES (1, 25.00, 2, 3);
INSERT INTO mydb.LanchesPedidos (Quantidade, ValorLanches, CodPedidos, CodLanches)
VALUES (3, 25.00, 3, 3);


-- Pesquisando pedidos status em Preparação


SELECT 
	C.NomeClientes AS Cliente, C.Telefone AS 'Tel Cliente',
    P.CodPedidos, 
    DATE_FORMAT(P.Data_hora, '%d/%m/%Y %h:%i %p') AS 'Hora Pedido',
    NomeLanches, 
    Quantidade, 
    FORMAT(LP.ValorLanches, 2),
    Nome AS Entregador, 
    E.Telefone AS 'Tel Entregador', 
    FORMAT(P.ValorTotal, 2) AS 'Valor Total', 
    Status
FROM mydb.Clientes AS C
INNER JOIN mydb.Pedidos AS P ON P.CodCliente = C.CodClientes
INNER JOIN mydb.LanchesPedidos AS LP ON P.CodPedidos = LP.CodPedidos
INNER JOIN mydb.Lanches AS L ON L.CodLanches = LP.CodLanches
INNER JOIN mydb.Entregadores AS E ON E.CodEntregadores = P.CodEntregador
WHERE Status = 0

