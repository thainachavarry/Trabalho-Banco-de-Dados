-- -----------------------------------------------------
-- Schema IESB
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `IESB` DEFAULT CHARACTER SET utf8 ;
USE `IESB` ;

-- -----------------------------------------------------
-- Table `IESB`.`Localizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IESB`.`Localizacao` (
  `idLocalizacao` INT NOT NULL,
  `Região` VARCHAR(45) NOT NULL,
  `Estado` VARCHAR(45) NOT NULL,
  `Municipio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLocalizacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IESB`.`Bandeira`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IESB`.`Bandeira` (
  `idBandeira` INT NOT NULL,
  `NomeBandeira` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBandeira`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IESB`.`Revendedora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IESB`.`Revendedora` (
  `idRevendedora` INT NOT NULL,
  `NomeRevendedora` VARCHAR(45) NOT NULL,
  `CNJPRevendedora` VARCHAR(45) NOT NULL,
  `Bandeira_idBandeira` INT NOT NULL,
  `Localizacao_idLocalizacao` INT NOT NULL,
  `Bandeira_idBandeira1` INT NOT NULL,
  PRIMARY KEY (`idRevendedora`, `Bandeira_idBandeira`),
  INDEX `fk_Revendedora_Localizacao_idx` (`Localizacao_idLocalizacao` ASC) VISIBLE,
  INDEX `fk_Revendedora_Bandeira1_idx` (`Bandeira_idBandeira1` ASC) VISIBLE,
  CONSTRAINT `fk_Revendedora_Localizacao`
    FOREIGN KEY (`Localizacao_idLocalizacao`)
    REFERENCES `IESB`.`Localizacao` (`idLocalizacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Revendedora_Bandeira1`
    FOREIGN KEY (`Bandeira_idBandeira1`)
    REFERENCES `IESB`.`Bandeira` (`idBandeira`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IESB`.`TipoProduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IESB`.`TipoProduto` (
  `idTipoProduto` INT NOT NULL,
  `NomeProduto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IESB`.`UnidadeMedida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IESB`.`UnidadeMedida` (
  `idUnidadeMedida` INT NOT NULL,
  `Unidade` INT NOT NULL,
  PRIMARY KEY (`idUnidadeMedida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IESB`.`Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IESB`.`Produtos` (
  `idProdutos` INT NOT NULL,
  `DataColeta` DATE NOT NULL,
  `ValorCompra` INT NULL,
  `ValorRevenda` INT NOT NULL,
  `TipoProduto_idTipoProduto` INT NOT NULL,
  `UnidadeMedida_idUnidadeMedida` INT NOT NULL,
  INDEX `fk_Produtos_TipoProduto1_idx` (`TipoProduto_idTipoProduto` ASC) VISIBLE,
  INDEX `fk_Produtos_UnidadeMedida1_idx` (`UnidadeMedida_idUnidadeMedida` ASC) VISIBLE,
  PRIMARY KEY (`idProdutos`),
  CONSTRAINT `fk_Produtos_TipoProduto1`
    FOREIGN KEY (`TipoProduto_idTipoProduto`)
    REFERENCES `IESB`.`TipoProduto` (`idTipoProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos_UnidadeMedida1`
    FOREIGN KEY (`UnidadeMedida_idUnidadeMedida`)
    REFERENCES `IESB`.`UnidadeMedida` (`idUnidadeMedida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IESB`.`Revendedora_has_Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IESB`.`Revendedora_has_Produtos` (
  `Revendedora_idRevendedora` INT NOT NULL,
  `Revendedora_Bandeira_idBandeira` INT NOT NULL,
  `Produtos_idProdutos` INT NOT NULL,
  PRIMARY KEY (`Revendedora_idRevendedora`, `Revendedora_Bandeira_idBandeira`, `Produtos_idProdutos`),
  INDEX `fk_Revendedora_has_Produtos_Produtos1_idx` (`Produtos_idProdutos` ASC) VISIBLE,
  INDEX `fk_Revendedora_has_Produtos_Revendedora1_idx` (`Revendedora_idRevendedora` ASC, `Revendedora_Bandeira_idBandeira` ASC) VISIBLE,
  CONSTRAINT `fk_Revendedora_has_Produtos_Revendedora1`
    FOREIGN KEY (`Revendedora_idRevendedora` , `Revendedora_Bandeira_idBandeira`)
    REFERENCES `IESB`.`Revendedora` (`idRevendedora` , `Bandeira_idBandeira`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Revendedora_has_Produtos_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `IESB`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

LOAD DATA LOCAL INFILE  'D:\\Users\\thata\\Downloads\\769525_1326400_bundle_archive\\2018-2_CA.csv' 
INTO TABLE vendas
CHARACTER SET utf8
FIELDS TERMINATED BY '\t' 
--  ENCLOSED BY '"'
LINES TERMINATED BY '\n'


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

 