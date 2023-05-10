<<<<<<< HEAD:app/Main.hs
{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import DataBase.GerenciadorBD as BD

import Functions.ClienteFunctions as FuncC
import Functions.FuncionarioFunctions as FuncF
import Functions.GerenteFunctions as FuncG

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

cliente :: IO ()
cliente = do
  putStr "\n======== Locadora - Sistema - Cliente ========\n"
  putStr "1 - Listar filmes\n" 
  putStr "2 - Escolher filme\n"
  putStr "3 - Listar series\n"
  putStr "4 - Escolher serie\n"
  putStr "5 - Listar jogos\n"
  putStr "6 - Escolher jogo\n"
  putStr "7 - Produto por categoria\n"
  putStr "8 - Adicionar Filme ao carrinho\n"
  putStr "9 - Adicionar Jogo ao carrinho\n"
  putStr "10 - Adicionar Série ao carrinho\n"
  putStr "11 - Remover do carrinho\n"
  putStr "12 - Ver carrinho\n"
  putStr "13 - Recomendações\n" --
  putStr "14 - menu principal\n"
  putStr "----> "
  op <- readLn :: IO Int
  -- limparTela
  menuCliente op

subMenuDiasSemanas :: IO String
subMenuDiasSemanas = do
  putStrLn "1 - Alugar por dias"
  putStrLn "2 - Alugar por semana"
  getLine

subMenuCategoria :: IO String
subMenuCategoria = do
  putStrLn "1 - Filmes por categoria"
  putStrLn "2 - Séries por categoria"
  putStrLn "3 - Jogos por categoria"
  getLine

subMenuRecs :: IO String
subMenuRecs = do
  putStrLn "1 - Recomendações de filme"
  putStrLn "2 - Recomendações de séries"
  putStrLn "3 - Recomendações de jogos"
  getLine

menuCliente :: Int -> IO ()
menuCliente op
  | op == 1 = do
      putStrLn FuncC.listarFilmes
      cliente
  | op == 2 = do
      putStrLn "Seu id: "
      idCliente <- getLine
      putStrLn "Nome do Filme:"
      nome <- getLine
      escolha <- subMenuDiasSemanas
      if escolha == "1"
        then do
          putStrLn "Quantidade de dias:"
          qtdDias <- readLn :: IO Int
          resultadoAluguel <- FuncC.alugaFilmeDias idCliente nome qtdDias
          putStrLn resultadoAluguel
          cliente
        else
          if escolha == "2"
            then do
              putStrLn "Quantidade de semanas:"
              qtdSemanas <- readLn :: IO Int
              resultadoAluguel <- FuncC.alugaFilmeSemanas idCliente nome qtdSemanas
              putStrLn resultadoAluguel
              cliente
            else do
              putStrLn "Opção inválida!"
              cliente
  | op == 3 = do
      putStrLn FuncC.listarSeries
      cliente
  | op == 4 = do
      putStrLn "Seu id: "
      idCliente <- getLine
      putStrLn "Nome da Série:"
      nome <- getLine
      escolha <- subMenuDiasSemanas
      if escolha == "1"
        then do
          putStrLn "Quantidade de dias:"
          qtdDias <- readLn :: IO Int
          resultadoAluguel <- FuncC.alugaSerieDias idCliente nome qtdDias
          putStrLn resultadoAluguel
          cliente
        else
          if escolha == "2"
            then do
              putStrLn "Quantidade de semanas:"
              qtdSemanas <- readLn :: IO Int
              resultadoAluguel <- FuncC.alugaSerieSemanas idCliente nome qtdSemanas
              putStrLn resultadoAluguel
              cliente
            else do
              putStrLn "Opção inválida!"
              cliente
  | op == 5 = do
      putStrLn FuncC.listarJogos
      cliente
  | op == 6 = do
      putStrLn "Seu id: "
      idCliente <- getLine
      putStrLn "Nome do Jogo:"
      nome <- getLine
      escolha <- subMenuDiasSemanas
      if escolha == "1"
        then do
          putStrLn "Quantidade de dias:"
          qtdDias <- readLn :: IO Int
          resultadoAluguel <- FuncC.alugaJogoDias idCliente nome qtdDias
          putStrLn resultadoAluguel
          cliente
        else
          if escolha == "2"
            then do
              putStrLn "Quantidade de semanas:"
              qtdSemanas <- readLn :: IO Int
              resultadoAluguel <- FuncC.alugaJogoSemanas idCliente nome qtdSemanas
              putStrLn resultadoAluguel
              cliente
            else do
              putStrLn "Opção inválida!"
              cliente
  | op == 7 = do
      escolha <- subMenuCategoria
      if escolha == "1"
        then do
          putStrLn "Categoria:\n"
          cat <- getLine
          let filmes = FuncC.pesquisaFilmes cat
          putStrLn filmes
          cliente
        else
          if escolha == "2"
            then do
              putStrLn "Categoria:\n"
              cat <- getLine
              let series = FuncC.pesquisaSeries cat
              putStrLn series
              cliente
            else
              if escolha == "3"
                then do
                  putStrLn "Categoria:\n"
                  cat <- getLine
                  let jogos = FuncC.pesquisaJogos cat
                  putStrLn jogos
                  cliente
                else do
                  putStrLn "Opção inválida!"
                  cliente
  | op == 8 = do
      putStrLn "Seu id: "
      idCliente <- getLine
      putStrLn "Nome do Produto:"
      nomeProduto <- getLine
      resultado <- FuncC.adicionarFilmeAoCarrinho idCliente nomeProduto
      putStrLn resultado
      cliente
  | op == 9 = do
      putStrLn "Seu id: "
      idCliente <- getLine
      putStrLn "Nome do Produto:"
      nomeProduto <- getLine
      resultado <- FuncC.adicionarJogoAoCarrinho idCliente nomeProduto
      putStrLn resultado
      cliente
  | op == 10 = do
      putStrLn "Seu id: "
      idCliente <- getLine
      putStrLn "Nome do Produto:"
      nomeProduto <- getLine
      resultado <- FuncC.adicionarSerieAoCarrinho idCliente nomeProduto
      putStrLn resultado
      cliente
  | op == 11 = do
      putStrLn "Seu id: "
      idCliente <- getLine
      putStrLn "Nome do Produto:"
      nomeProduto <- getLine
      resultado <- FuncC.removerProduto idCliente nomeProduto
      putStrLn resultado
      cliente
  | op == 12 = do
      putStrLn "Seu id: "
      idCliente <- getLine
      let resultado = FuncC.listarProdutos idCliente
      putStrLn resultado
      cliente
  | op == 13 = do
      putStrLn "Seu id: "
      idCliente <- getLine
      escolha <- subMenuRecs
      let recs = FuncC.recomendacoes escolha idCliente
      putStrLn recs
      cliente
  | op == 14 = main
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
      putStrLn "Filmes cadastrados:"
      putStrLn FuncF.listarFilmes
      funcionario
    | op == 2 = do
      putStrLn "Series cadastradas:"
      putStrLn FuncF.listarSeries
      funcionario
    | op == 3 = do
      putStrLn "Jogos cadastrados:"
      putStrLn FuncF.listarJogos
      funcionario
    | op == 4 = do
      putStrLn "Nome do Cliente:"
      nome <- getLine
      putStrLn "Id do Cliente:"
      idCliente <- getLine
      putStrLn "Seu Id:"
      id <- getLine
      putStrLn "Sua senha:"
      senha <- getLine
      resultadoCadastro <- FuncF.cadastrarCliente nome idCliente id senha
      putStrLn resultadoCadastro
      funcionario
    | op == 5 = do
      putStrLn "Clientes cadastrados:"
      putStrLn FuncF.listarClientes
      funcionario
    | op == 6 = do
      putStrLn "Id do cliente:"
      id <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.excluirCliente id idFun senha
      putStrLn resultado
      funcionario
    | op == 7 = do
      putStrLn "Id do cliente:"
      id <- getLine
      putStrLn (FuncF.exibirHistorico id)
      funcionario
    | op == 8 = do
      putStrLn "Id da serie:"
      idSerie <- getLine
      putStrLn "Nome da serie:"
      nome <- getLine
      putStrLn "Descrição:"
      descricao <- getLine
      putStrLn "Categoria:"
      categoria <- getLine
      putStrLn "Preço:"
      preco <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.cadastrarSerie idFun senha idSerie nome descricao categoria preco
      putStrLn resultado
      funcionario
    | op == 9 = do
      putStrLn "Id da Série:"
      id <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.excluirSerie id idFun senha
      putStrLn resultado
      funcionario
    | op == 10 = do
      putStrLn "Id do filme:"
      idSerie <- getLine
      putStrLn "Nome do filme:"
      nome <- getLine
      putStrLn "Descrição:"
      descricao <- getLine
      putStrLn "Categoria:"
      categoria <- getLine
      putStrLn "Preço:"
      preco <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.cadastrarFilme idFun senha idSerie nome descricao categoria preco
      putStrLn resultado
      funcionario
    | op == 11 = do
      putStrLn "Id da Filme:"
      id <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.excluirFilme id idFun senha
      putStrLn resultado
      funcionario
    | op == 12 = do
      putStrLn "Id do jogo:"
      idSerie <- getLine
      putStrLn "Nome do jogo:"
      nome <- getLine
      putStrLn "Descrição:"
      descricao <- getLine
      putStrLn "Categoria:"
      categoria <- getLine
      putStrLn "Preço:"
      preco <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.cadastrarJogo idFun senha idSerie nome descricao categoria preco
      putStrLn resultado
      funcionario
    | op == 13 = do
      putStrLn "Id da Jogo:"
      id <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.excluirJogo id idFun senha
      putStrLn resultado
      funcionario
    | op == 14 = main
    | otherwise = do
        putStr "Entrada inválida...\n"
        funcionario

gerente:: IO()
gerente = do
    putStr "\n======== Locadora - Sistema - Gerente ========\n"
    putStr "1- Cadastrar funcionário\n"
    putStr "2- Exibir funcionário\n"
    putStr "3- Listar funcionários\n"
    putStr "4- Estatisticas de vendas\n"
    putStr "5- menu principal\n"
    putStr "----> "
    op <- readLn:: IO Int
    menuGerente op

menuGerente:: Int -> IO()
menuGerente op
    | op == 1 = do
      putStrLn "Identidade do Funcionario:"
      id <- getLine
      putStrLn "Nome:"
      nome <- getLine
      putStrLn "Senha do gerente:"
      senha <- getLine
      resultado <- FuncG.cadastraFunc id nome senha
      putStrLn resultado
      gerente
    | op == 2 = do
      putStrLn "Identidade do Funcionario:"
      id <- getLine
      putStrLn (FuncG.exibirFuncionario id)
      gerente
    | op == 3 = do 
      putStrLn FuncG.listarFun
      gerente
    | op == 4 = do
      putStrLn FuncG.estatisticas
      putStrLn FuncG.rendaFilmes
      putStrLn FuncG.rendaSeries
      putStrLn FuncG.rendaJogos
      putStrLn FuncG.rendaTotal
      putStrLn FuncG.totalClientes
      putStrLn FuncG.totalFuncionarios
      putStrLn FuncG.totalJogosDisponiveis
      gerente
    | op == 5 = main
    | otherwise = do
        putStr "Entrada inválida...\n"
        gerente
=======
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
      putStrLn "Id do Cliente:"
      idCliente <- getLine
      putStrLn "Seu Id:"
      id <- getLine
      putStrLn "Sua senha:"
      senha <- getLine
      resultadoCadastro <- FuncF.cadastrarCliente nome idCliente id senha
      putStrLn resultadoCadastro
      main
    | op == 5 = do
      putStrLn FuncF.listarClientes
      main
    | op == 6 = do
      putStrLn "Id do cliente:"
      id <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.excluirCliente id idFun senha
      putStrLn resultado
      main
    | op == 7 = do
      putStrLn "Id do cliente:"
      id <- getLine
      putStrLn (FuncF.exibirHistorico id)
      main
    | op == 8 = do
      putStrLn "Id da serie:"
      idSerie <- getLine
      putStrLn "Nome da serie:"
      nome <- getLine
      putStrLn "Descrição:"
      descricao <- getLine
      putStrLn "Categoria:"
      categoria <- getLine
      putStrLn "Preço:"
      preco <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.cadastrarSerie idFun senha idSerie nome descricao categoria preco
      putStrLn resultado
      main
    | op == 9 = do
      putStrLn "Id da Série:"
      id <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.excluirSerie id idFun senha
      putStrLn resultado
      main
    | op == 10 = do
      putStrLn "Id do filme:"
      idSerie <- getLine
      putStrLn "Nome do filme:"
      nome <- getLine
      putStrLn "Descrição:"
      descricao <- getLine
      putStrLn "Categoria:"
      categoria <- getLine
      putStrLn "Preço:"
      preco <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.cadastrarFilme idFun senha idSerie nome descricao categoria preco
      putStrLn resultado
      main
    | op == 11 = do
      putStrLn "Id da Filme:"
      id <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.excluirFilme id idFun senha
      putStrLn resultado
      main
    | op == 12 = do
      putStrLn "Id do jogo:"
      idSerie <- getLine
      putStrLn "Nome do jogo:"
      nome <- getLine
      putStrLn "Descrição:"
      descricao <- getLine
      putStrLn "Categoria:"
      categoria <- getLine
      putStrLn "Preço:"
      preco <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.cadastrarJogo idFun senha idSerie nome descricao categoria preco
      putStrLn resultado
      main
    | op == 13 = do
      putStrLn "Id da Jogo:"
      id <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.excluirJogo id idFun senha
      putStrLn resultado
      main
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
>>>>>>> origin/main:Main.hs
