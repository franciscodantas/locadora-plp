module Main where

import DataBase.GerenciadorBD as BD

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

cadastrarFilme :: IO()
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

main::IO()
main = do
	-- cadastrarFilme
	-- cadastrarSerie
	-- cadastrarJogo

	-- cadastrarCliente
	-- cadastrarGerente
	-- cadastrarFuncionario
	
	-- let nome = (Models.Filme.nome (obterFilme "1232578-f"))
	-- print nome
	-- let nome = (Models.Serie.nome (obterSerie "123245678-f"))
	-- print nome
	-- let nome = (Models.Jogo.nome (obterJogo "12334678-f"))
	-- print nome

	-- editarQtdFilme "1234568-f" 10
	-- editarQtdJogo "12345678-f" 3
	-- editarQtdSerie "123455678-f" 7

	-- let nome = (Models.Cliente.nome (obterCliente "123454443"))
	-- print nome
	-- let nome = (Models.Gerente.nome (obterGerente "12386645"))
	-- print nome
	-- let nome = (Models.Funcionario.nome (obterFuncionario "1234234565"))
	-- print nome

	-- addProdutoCarrinho "123454443" "1232578-f"
	-- addCompraHistorico "12398745" "1232345678-f" 

	-- registraCompra "123454443" "1232578-f"

	-- addProdutoCarrinho "12343325" "1232578-f"
	-- addProdutoCarrinho "12343325" "123245678-f"
	-- removeProdutoCarrinho "12343325" "1232578-f"



