DROP SCHEMA IF EXISTS `vinicoladb` ;

CREATE SCHEMA IF NOT EXISTS `vinicoladb` DEFAULT CHARACTER SET utf8 ;
USE `vinicoladb` ;

DROP TABLE IF EXISTS `vinicoladb`.`Regiao`;

CREATE TABLE IF NOT EXISTS `vinicoladb`.`Regiao` (
  `codRegiao` BIGINT NOT NULL,
  `nomeRegiao` VARCHAR(100) NOT NULL,
  `descricaoRegiao` TEXT NULL,
  PRIMARY KEY (`codRegiao`));

DROP TABLE IF EXISTS `vinicoladb`.`Vinicola`;

CREATE TABLE IF NOT EXISTS `vinicoladb`.`Vinicola` (
  `codVinicola` BIGINT NOT NULL,
  `nomeVinicola` VARCHAR(100) NOT NULL,
  `descricaoVinicola` TEXT NULL,
  `foneVinicola` VARCHAR(25) NULL,
  `emailVinicola` VARCHAR(40) NULL,
  `codRegiao` BIGINT NOT NULL,
  PRIMARY KEY (`codVinicola`),
  UNIQUE INDEX `codVinicula_UNIQUE` (`codVinicola` ASC) VISIBLE,
  INDEX `fk_Vinicola_Regiao_idx` (`codRegiao` ASC) VISIBLE,
  CONSTRAINT `fk_Vinicola_Regiao`
    FOREIGN KEY (`codRegiao`)
    REFERENCES `vinicoladb`.`Regiao` (`codRegiao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

DROP TABLE IF EXISTS `vinicoladb`.`Vinho`;

CREATE TABLE IF NOT EXISTS `vinicoladb`.`Vinho` (
  `codVinho` BIGINT NOT NULL AUTO_INCREMENT,
  `nomeVinho` VARCHAR(50) NOT NULL,
  `tipoVinho` VARCHAR(30) NOT NULL,
  `anoVinho` INT NOT NULL,
  `descricaoVinho` TEXT NULL,
  `codVinicola` BIGINT NOT NULL,
  PRIMARY KEY (`codVinho`),
  UNIQUE INDEX `codVinho_UNIQUE` (`codVinho` ASC) VISIBLE,
  INDEX `fk_Vinho_Vinicola1_idx` (`codVinicola` ASC) VISIBLE,
  CONSTRAINT `fk_Vinho_Vinicola1`
    FOREIGN KEY (`codVinicola`)
    REFERENCES `vinicoladb`.`Vinicola` (`codVinicola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    

INSERT INTO vinicoladb.Regiao (codRegiao, nomeRegiao, descricaoRegiao)
VALUES (1,'Bordeaux (França)',
'Localizada no sudoeste da França, 
Bordeaux é uma das regiões vinícolas mais renomadas do mundo. 
Conhecida por seus vinhos tintos elegantes e complexos, 
geralmente feitos com uvas como Merlot,
Cabernet Sauvignon e Cabernet Franc.');

INSERT INTO vinicoladb.Regiao (codRegiao, nomeRegiao, descricaoRegiao)
VALUES (2,'Toscana (Itália)',
'Famosa pelos vinhos Chianti e Brunello di Montalcino, 
a Toscana é uma região central da Itália com colinas e 
clima ideal para a produção de vinhos. 
A uva Sangiovese é a mais emblemática da região.');

INSERT INTO vinicoladb.Regiao (codRegiao, nomeRegiao, descricaoRegiao)
VALUES (3,'Vale do Napa (Estados Unidos)',
'Situado na Califórnia, 
o Vale do Napa é o coração da indústria vinícola americana. 
Conhecido por seus vinhos premium, 
especialmente os Cabernet Sauvignon, 
combina tradição e inovação na produção.');

INSERT INTO vinicoladb.Regiao (codRegiao, nomeRegiao, descricaoRegiao)
VALUES (4,'Vale do Maipo (Chile)',
'Situado próximo à capital Santiago, 
o Vale do Maipo é uma das regiões vinícolas mais tradicionais do Chile. 
É especialmente conhecido por seus excelentes vinhos tintos, 
como Cabernet Sauvignon, 
com estilo elegante e estruturado.');

INSERT INTO vinicoladb.Regiao (codRegiao, nomeRegiao, descricaoRegiao)
VALUES (5,'Vale de Colchagua (Chile)',
'Parte da região do Vale Central, 
Colchagua tem clima ideal para uvas tintas como Carménère, 
Syrah e Malbec. Seus vinhos são encorpados, 
ricos e com grande potencial de envelhecimento, 
ganhando destaque internacional nos últimos anos.');

INSERT INTO vinicoladb.Vinicola (codVinicola, nomeVinicola, descricaoVinicola, foneVinicola,emailVinicola, codRegiao)
VALUES (1,'Château Margaux',
'Uma das vinícolas mais prestigiadas de Bordeaux, 
conhecida por seus vinhos tintos refinados e elegantes, 
com séculos de tradição.', 
'+33 (0)5 57 88 83 83', 
'chateau-margaux@chateau-margaux.com' ,1);

INSERT INTO vinicoladb.Vinicola (codVinicola, nomeVinicola, descricaoVinicola, foneVinicola,emailVinicola, codRegiao)
VALUES (2,'Antinori', 
' Uma das famílias vinícolas mais antigas da Itália, 
a Marchesi Antinori produz vinhos renomados como o Tignanello, 
combinando tradição e inovação.', 
'+39 055 2359730', 
'wineryshop@antinorichianticlassico.it' ,2);

INSERT INTO vinicoladb.Vinicola (codVinicola, nomeVinicola, descricaoVinicola, foneVinicola,emailVinicola, codRegiao)
VALUES (3,'Robert Mondavi Winery', 
'Ícone da viticultura californiana, 
ajudou a colocar Napa no mapa mundial 
com vinhos como Cabernet Sauvignon e Fumé Blanc.', 
'+1 (888) 766-6328', 
'reservations@robertmondaviwinery.com', 3);

INSERT INTO vinicoladb.Vinicola (codVinicola, nomeVinicola, descricaoVinicola, foneVinicola,emailVinicola, codRegiao)
VALUES (4,'Concha y Toro', 
'A maior vinícola do Chile e uma das mais conhecidas da América do Sul, 
famosa por rótulos como Casillero del Diablo.', 
'+56 72 300 4090', 
'compras@conchaytoro.cl' ,4);

INSERT INTO vinicoladb.Vinicola (codVinicola, nomeVinicola, descricaoVinicola, foneVinicola,emailVinicola, codRegiao)
VALUES (5, 'Viña Montes', 
'Destaque internacional por seus vinhos de alta qualidade, 
especialmente tintos como o Montes Alpha e Purple Angel.', 
'+56 72 285 4090', 
'info@monteswines.com' ,5);

INSERT INTO vinicoladb.Vinho (nomeVinho, tipoVinho, anoVinho, descricaoVinho, codVinicola)
VALUES ('Château Margaux', 'Tinto', 2015, 
' Uma safra excelente em Bordeaux, marcada por equilíbrio, potência e longevidade.', 1);

INSERT INTO vinicoladb.Vinho (nomeVinho, tipoVinho, anoVinho, descricaoVinho, codVinicola)
VALUES ('Tignanello ', 'Tinto', 2016, 
'Considerada uma das melhores safras da década para esse Super Toscano, 
com grande complexidade.', 2);

INSERT INTO vinicoladb.Vinho (nomeVinho, tipoVinho, anoVinho, descricaoVinho, codVinicola)
VALUES ('Cabernet Sauvignon Reserve', 'Tinto', 2013, 
'Ano excepcional em Napa, resultando em vinhos densos, elegantes e de guarda.', 3);

INSERT INTO vinicoladb.Vinho (nomeVinho, tipoVinho, anoVinho, descricaoVinho, codVinicola)
VALUES ('Casillero del Diablo Cabernet Sauvignon', 'Tinto', 2020, 
'Safra recente e amplamente disponível, com bom equilíbrio entre fruta e taninos.', 4);

INSERT INTO vinicoladb.Vinho (nomeVinho, tipoVinho, anoVinho, descricaoVinho, codVinicola)
VALUES ('Montes Alpha Syrah', 'Tinto', 2018, 
'Um ótimo ano para tintos no Chile, com vinhos estruturados e aromáticos.', 5);

SELECT 
	nomeVinho 'Nome do Vinho', 
    anoVinho 'Ano do Vinho', 
    nomeVinicola 'Vinicola' 
FROM vinicoladb.Vinho AS vinho
INNER JOIN vinicoladb.Vinicola AS vinicola ON vinicola.codVinicola = vinho.codVinicola;

CREATE OR REPLACE VIEW vinicoladb.VinicolaView AS
SELECT codVinicola, nomeVinicola
FROM vinicoladb.Vinicola;

CREATE USER 'Somellier'@'localhost' IDENTIFIED BY '12345';
GRANT SELECT ON vinicoladb.Vinho TO 'Somellier'@'localhost';
GRANT SELECT ON vinicoladb.VinicolaView TO 'Somellier'@'localhost';
ALTER USER 'Somellier'@'localhost' WITH MAX_QUERIES_PER_HOUR 40;
FLUSH PRIVILEGES;

SELECT user, host FROM mysql.user;
SHOW GRANTS FOR 'Somellier'@'localhost';
