{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import DataBase.GerenciadorBD as BD

import Functions.FuncionarioFunctions as FuncF

import Models.Filme
import Models.Serie
import Models.Jogo
import Models.Cliente
import Models.Funcionario
import Models.Gerente
import Models.Compra
import Models.Produto

import Data.Time.Clock
import qualified Data.Time.Format as TimeFormat

{-cadastrarFilme :: IO()
cadastrarFilme = do
	print "Nome"
	nome <- getLine

	print "Descrição"
	descricao <- getLine

	print "Categoria"
	categoria <- getLine

	print "Preco"
	preco <- readLn :: IO Float

	saveFilmeJSON "12345678-f" nome descricao categoria preco

obterFilme :: String -> Filme
obterFilme id = do
	let result = getFilmeByID id (getFilmeJSON "DataBase/Filme.json")
	result

editarQtdFilme :: String -> Int -> IO()
editarQtdFilme id qtd = do
	editFilmeQtdJSON id qtd

cadastrarSerie :: IO()
cadastrarSerie = do
	print "Nome"
	nome <- getLine

	print "Descrição"
	descricao <- getLine

	print "Categoria"
	categoria <- getLine

	print "Preco"
	preco <- readLn :: IO Float

	saveSerieJSON "12345678-f" nome descricao categoria preco

obterSerie :: String -> Serie
obterSerie id = do
	let result = getSerieByID id (getSerieJSON "DataBase/Serie.json")
	result

editarQtdSerie :: String -> Int -> IO()
editarQtdSerie id qtd = do
	editSerieQtdJSON id qtd

cadastrarJogo :: IO()
cadastrarJogo = do
	print "Nome"
	nome <- getLine

	print "Descrição"
	descricao <- getLine

	print "Categoria"
	categoria <- getLine

	print "Preco"
	preco <- readLn :: IO Float

	saveJogoJSON "12345678-f" nome descricao categoria preco

obterJogo :: String -> Jogo
obterJogo id = do
	let result = getJogoByID id (getJogoJSON "DataBase/Jogo.json")
	result

editarQtdJogo :: String -> Int -> IO()
editarQtdJogo id qtd = do
	editJogoQtdJSON id qtd

cadastrarCliente :: IO()
cadastrarCliente = do
	print "Nome"
	nome <- getLine

	saveClienteJSON "12345" nome

obterCliente :: String -> Cliente
obterCliente id = do
	let result = getClienteByID id (getClienteJSON "DataBase/Cliente.json")
	result

cadastrarGerente :: IO()
cadastrarGerente = do
	print "Nome"
	nome <- getLine

	saveGerenteJSON "12345" nome

obterGerente :: String -> Gerente
obterGerente id = do
	let result = getGerenteByID id (getGerenteJSON "DataBase/Gerente.json")
	result

cadastrarFuncionario :: IO()
cadastrarFuncionario = do
	print "Nome"
	nome <- getLine

	saveFuncionarioJSON "12345" nome

obterFuncionario :: String -> Funcionario
obterFuncionario id = do
	let result = getFuncionarioByID id (getFuncionarioJSON "DataBase/Funcionario.json")
	result

addProdutoCarrinho :: String -> String -> IO()
addProdutoCarrinho idCliente idProduto = do
	let p = Produto "1972949" idProduto
	editClienteCarrinhoJSON idCliente p

addCompraHistorico :: String -> String -> IO()
addCompraHistorico idCliente idProduto = do
	currentTime <- getCurrentTime
  	let currentDate = TimeFormat.formatTime TimeFormat.defaultTimeLocale "%d/%m/%Y" currentTime
	let c = Compra "1972949" idProduto idCliente currentDate
	editClienteHistoricoJSON idCliente c

registraCompra :: String -> String -> IO()
registraCompra idCliente idProduto = do
	currentTime <- getCurrentTime
  	let currentDate = TimeFormat.formatTime TimeFormat.defaultTimeLocale "%d/%m/%Y" currentTime
	let c = Compra "176256537" idCliente idProduto currentDate
	saveCompraJSON c

removeProdutoCarrinho :: String ->  String -> IO()
removeProdutoCarrinho idCliente idProduto = do
	removeClienteProdutoJSON idCliente idProduto
-}

main::IO()
main = do
        putStr "\n======== Locadora - Sistema ========\n"
        putStr "Selecione uma opção:\n"
        putStr "1 - Cliente\n"
        putStr "2 - Funcionário\n"
        putStr "3 - Gerencia\n"
        putStr "4 - Sair\n"
        putStr "----> "
        op <- readLn:: IO Int
        opcaoSelecionada op

opcaoSelecionada:: Int -> IO()
opcaoSelecionada op
        | op == 1 = cliente
        | op == 2 = funcionario
        | op == 3 = gerente
        | op == 4 = putStr "Saindo...\n"
        | otherwise = do
            putStr "Entrada inválida...\n"
            main

cliente:: IO()
cliente  = do
    putStr "\n======== Locadora - Sistema - Cliente ========\n"
    putStr "1 - Listar filmes\n"
    putStr "2 - Escolher filme\n"
    putStr "3 - Listar series\n"
    putStr "4 - Escolher serie\n"
    putStr "5 - Listar jogos\n"
    putStr "6 - Escolher jogo\n"
    putStr "7 - Recomendações\n"
    putStr "8 - menu principal\n"
    putStr "----> "
    op <- readLn:: IO Int
    menuCliente op


menuCliente:: Int -> IO()
menuCliente op
    | op == 1 = cliente
    | op == 2 = cliente
    | op == 3 = cliente
    | op == 4 = cliente
    | op == 5 = cliente
    | op == 6 = cliente
    | op == 7 = cliente
    | op == 8 = main
    | otherwise = do
        putStr "Entrada inválida...\n"
        cliente

funcionario:: IO()
funcionario  = do
    putStr "\n======== Locadora - Sistema - Funcionário ========\n"
    putStr "1 - Listar filmes disponiveis\n"
    putStr "2 - Listar series disponiveis\n"
    putStr "3 - Listar jogos disponiveis\n"
    putStr "4 - Cadastrar cliente\n"
    putStr "5 - Listar clientes\n"
    putStr "6 - Encerrar cadastro de cliente\n"
    putStr "7 - Exibir historico cliente\n"
    putStr "8 - Cadastrar série\n"
    putStr "9 - Excluir série\n"
    putStr "10 - Cadastrar filme\n"
    putStr "11 - Excluir filme\n"
    putStr "12 - Cadastrar jogo\n"
    putStr "13 - Exlcuir jogo\n"
    putStr "14 - menu principal\n"
    putStr "----> "
    op <- readLn:: IO Int
    menuFuncionario op

menuFuncionario:: Int -> IO()
menuFuncionario op
    | op == 1 = do
      putStrLn FuncF.listarFilmes
      main
    | op == 2 = do
      putStrLn FuncF.listarSeries
      main
    | op == 3 = do
      putStrLn FuncF.listarJogos
      main
    | op == 4 = do
      putStrLn "Nome do Cliente:"
      nome <- getLine
      resultadoCadastro <- FuncF.cadastrarCliente nome
      putStrLn resultadoCadastro
      main
    | op == 5 = do
      putStrLn FuncF.listarSeries
      main
    | op == 6 = funcionario
    | op == 7 = funcionario
    | op == 8 = funcionario
    | op == 9 = funcionario
    | op == 10 = funcionario
    | op == 11 = funcionario
    | op == 12 = funcionario
    | op == 13 = funcionario
    | op == 14 = main
    | otherwise = do
        putStr "Entrada inválida...\n"
        funcionario

gerente:: IO()
gerente = do
    putStr "\n======== Locadora - Sistema - Gerente ========\n"
    putStr "1- Cadastrar funcionário\n"
    putStr "2- Exibir funcionário\n"
    putStr "3- Exibir funcionários\n"
    putStr "4- Estatisticas de vendas\n"
    putStr "5- menu principal\n"
    putStr "----> "
    op <- readLn:: IO Int
    menuGerente op

menuGerente:: Int -> IO()
menuGerente op
    | op == 1 = gerente    | op == 2 = gerente
    | op == 3 = gerente
    | op == 4 = gerente
    | op == 5 = main
    | otherwise = do
        putStr "Entrada inválida...\n"
        gerente
