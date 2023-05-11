{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import DataBase.GerenciadorBD as BD

import Functions.ClienteFunctions as FuncC
import Functions.FuncionarioFunctions as FuncF
import Functions.GerenteFunctions as FuncG
    ( cadastraFunc,
      exibirFuncionario,
      listarFun,
      estatisticas,
      rendaFilmes,
      rendaSeries,
      rendaJogos,
      rendaTotal,
      totalClientes,
      totalFuncionarios,
      totalJogosDisponiveis )

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
        putStr "\n======== Locadora - Sistema ========\n" --v
        putStr "Selecione uma opção:\n" --v
        putStr "1 - Cliente\n" --v
        putStr "2 - Funcionário\n" --v
        putStr "3 - Gerencia\n" --v
        putStr "4 - Sair\n" --v
        putStr "----> " --v
        op <- readLn:: IO Int --v
        opcaoSelecionada op --v

opcaoSelecionada:: Int -> IO() --v
opcaoSelecionada op --v
        | op == 1 = cliente --v
        | op == 2 = funcionario --v
        | op == 3 = gerente --v
        | op == 4 = putStr "Saindo...\n" --v
        | otherwise = do --v
            putStr "Entrada inválida...\n" --v
            main

cliente :: IO ()
cliente = do
  putStr "\n======== Locadora - Sistema - Cliente ========\n" --v
  putStr "1 - Listar filmes\n" --v
  putStr "2 - Escolher filme\n" --v
  putStr "3 - Listar series\n" --v
  putStr "4 - Escolher serie\n" --v
  putStr "5 - Listar jogos\n" --v
  putStr "6 - Escolher jogo\n" --v
  putStr "7 - Produto por categoria\n" --v
  putStr "8 - Adicionar Filme ao carrinho\n" --v
  putStr "9 - Adicionar Jogo ao carrinho\n" --v
  putStr "10 - Adicionar Série ao carrinho\n" --v
  putStr "11 - Remover do carrinho\n" --v
  putStr "12 - Ver carrinho\n" --v
  putStr "13 - Recomendações\n" --v
  putStr "14 - menu principal\n" --v
  putStr "----> " --v
  op <- readLn :: IO Int --v
  -- limparTela
  menuCliente op --v

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
  | op == 1 = do --v
    lF <- FuncC.listarFilmes
    putStrLn lF
    cliente
  | op == 2 = do --v
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
  | op == 3 = do --v
    lS <- FuncC.listarSeries
    putStrLn lS
    cliente
  | op == 4 = do --v
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
  | op == 5 = do --v
    lJ <- FuncC.listarJogos
    putStrLn lJ
    cliente
  | op == 6 = do --v
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
  | op == 7 = do --v
      escolha <- subMenuCategoria
      if escolha == "1"
        then do
          putStrLn "Categoria:\n"
          cat <- getLine
          filmes <- FuncC.pesquisaFilmes cat
          putStrLn filmes
          cliente
        else
          if escolha == "2"
            then do
              putStrLn "Categoria:\n"
              cat <- getLine
              series <- FuncC.pesquisaSeries cat
              putStrLn series
              cliente
            else
              if escolha == "3"
                then do
                  putStrLn "Categoria:\n"
                  cat <- getLine
                  jogos <- FuncC.pesquisaJogos cat
                  putStrLn jogos
                  cliente
                else do
                  putStrLn "Opção inválida!"
                  cliente
  | op == 8 = do --v
      putStrLn "Seu id: "
      idCliente <- getLine
      putStrLn "Nome do Produto:"
      nomeProduto <- getLine
      resultado <- FuncC.adicionarFilmeAoCarrinho idCliente nomeProduto
      putStrLn resultado
      cliente
  | op == 9 = do --v
      putStrLn "Seu id: "
      idCliente <- getLine
      putStrLn "Nome do Produto:"
      nomeProduto <- getLine
      resultado <- FuncC.adicionarJogoAoCarrinho idCliente nomeProduto
      putStrLn resultado
      cliente
  | op == 10 = do --v
      putStrLn "Seu id: "
      idCliente <- getLine
      putStrLn "Nome do Produto:"
      nomeProduto <- getLine
      resultado <- FuncC.adicionarSerieAoCarrinho idCliente nomeProduto
      putStrLn resultado
      cliente
  | op == 11 = do --v
      putStrLn "Seu id: "
      idCliente <- getLine
      putStrLn "Nome do Produto:"
      nomeProduto <- getLine
      resultado <- FuncC.removerProduto idCliente nomeProduto
      putStrLn resultado
      cliente
  | op == 12 = do --v
      putStrLn "Seu id: "
      idCliente <- getLine
      resultado <- FuncC.listarProdutos idCliente
      putStrLn resultado
      cliente
  | op == 13 = do --v
      putStrLn "Seu id: "
      idCliente <- getLine
      escolha <- subMenuRecs
      recs <- FuncC.recomendacoes escolha idCliente
      putStrLn recs
      cliente
  | op == 14 = main --v
  | otherwise = do --v
      putStr "Entrada inválida...\n" --v
      cliente --v

funcionario:: IO() --v
funcionario  = do --v
    putStr "\n======== Locadora - Sistema - Funcionário ========\n" --v
    putStr "1 - Listar filmes disponiveis\n" --v
    putStr "2 - Listar series disponiveis\n" --v
    putStr "3 - Listar jogos disponiveis\n" --v
    putStr "4 - Cadastrar cliente\n" --v
    putStr "5 - Listar clientes\n" --v
    putStr "6 - Encerrar cadastro de cliente\n" --v
    putStr "7 - Exibir historico cliente\n" --v
    putStr "8 - Cadastrar série\n" --v
    putStr "9 - Excluir série\n" --v
    putStr "10 - Cadastrar filme\n" --v
    putStr "11 - Excluir filme\n" --v
    putStr "12 - Cadastrar jogo\n" --v
    putStr "13 - Exlcuir jogo\n" --v
    putStr "14 - menu principal\n" --v
    putStr "----> " --v
    op <- readLn:: IO Int --v
    menuFuncionario op --v

menuFuncionario:: Int -> IO()
menuFuncionario op
    | op == 1 = do --v
      putStrLn "Filmes cadastrados:"
      lF <- FuncF.listarFilmes
      putStrLn lF
      funcionario
    | op == 2 = do --v
      putStrLn "Series cadastradas:"
      lS <- FuncF.listarSeries
      putStrLn lS
      funcionario
    | op == 3 = do --v
      putStrLn "Jogos cadastrados:"
      lJ <- FuncF.listarJogos
      putStrLn lJ
      funcionario 
    | op == 4 = do --v
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
    | op == 5 = do --v
      putStrLn "Clientes cadastrados:"
      resultado <- FuncF.listarClientes
      putStrLn resultado
      funcionario
    | op == 6 = do --v
      putStrLn "Id do cliente:"
      id <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.excluirCliente id idFun senha
      putStrLn resultado
      funcionario
    | op == 7 = do --v
      putStrLn "Id do cliente:"
      id <- getLine
      resultado <- FuncF.exibirHistorico id
      putStrLn resultado
      funcionario
    | op == 8 = do --v
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
    | op == 9 = do --v
      putStrLn "Id da Série:"
      id <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.excluirSerie id idFun senha
      putStrLn resultado
      funcionario
    | op == 10 = do --v
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
    | op == 11 = do --v
      putStrLn "Id da Filme:"
      id <- getLine
      putStrLn "Id do Funcionario:"
      idFun <- getLine
      putStrLn "Senha:"
      senha <- getLine
      resultado <- FuncF.excluirFilme id idFun senha
      putStrLn resultado
      funcionario
    | op == 12 = do --v
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
    | op == 13 = do --v
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
    | otherwise = do --v
        putStr "Entrada inválida...\n"
        funcionario

gerente:: IO() --v
gerente = do --v
    putStr "\n======== Locadora - Sistema - Gerente ========\n" --v
    putStr "1- Cadastrar funcionário\n" --v
    putStr "2- Exibir funcionário\n" --v
    putStr "3- Listar funcionários\n" --v
    putStr "4- Estatisticas de vendas\n" --v
    putStr "5- menu principal\n" --v
    putStr "----> " --v
    op <- readLn:: IO Int --v
    menuGerente op --v

menuGerente:: Int -> IO()
menuGerente op
    | op == 1 = do --v
      putStrLn "Identidade do Funcionario:"
      id <- getLine
      putStrLn "Nome:"
      nome <- getLine
      putStrLn "Senha do gerente:"
      senha <- getLine
      resultado <- FuncG.cadastraFunc id nome senha
      putStrLn resultado
      gerente
    | op == 2 = do --v
      putStrLn "Identidade do Funcionario:"
      id <- getLine
      exibi <- FuncG.exibirFuncionario id
      putStrLn exibi
      gerente
    | op == 3 = do --v
      lista <- FuncG.listarFun
      putStrLn lista
      gerente
    | op == 4 = do --v
        estatisticasString <- FuncG.estatisticas --
        totalClientesString <- FuncG.totalClientes -- 
        rendaF <- FuncG.rendaFilmes
        rendaS <- FuncG.rendaSeries
        rendaJ <- FuncG.rendaJogos
        rendaT <- FuncG.rendaTotal
        totalF <- FuncG.totalFuncionarios
        totalJ <- FuncG.totalJogosDisponiveis

        putStrLn estatisticasString
        putStrLn rendaF
        putStrLn rendaS
        putStrLn rendaJ
        putStrLn rendaT
        putStrLn totalClientesString
        putStrLn totalF
        putStrLn totalJ

        gerente
    | op == 5 = main --v
    | otherwise = do --v
        putStr "Entrada inválida...\n" --v
        gerente --v
