{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import DataBase.GerenciadorBD as BD

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
      putStrLn FuncG.va
      gerente
    | op == 4 = gerente
    | op == 5 = main
    | otherwise = do
        putStr "Entrada inválida...\n"
        gerente
