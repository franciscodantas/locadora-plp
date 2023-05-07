module Functions.ClienteFunctions where

import Data.Aeson
import Data.Char (isAlpha, isAlphaNum, toLower)
import Data.Time.Clock (getCurrentTime)
import Data.Time.Format (defaultTimeLocale, formatTime)
import DataBase.GerenciadorBD as BD
import Models.Cliente
import Models.Compra
import Models.Filme
import Models.Funcionario
import Models.Jogo
import Models.Produto
import Models.Serie
import System.Random (mkStdGen, newStdGen, randomRs)

{- Lista os filmes do sistema -}
listarFilmes :: String
listarFilmes = "Lista de filmes:\n" ++ organizaListagem (BD.getFilmeJSON "app/DataBase/Filme.json")

{- Lista as series do sistema do sistema -}
listarSeries :: String
listarSeries = "Lista de série:\n" ++ organizaListagem (BD.getSerieJSON "app/DataBase/Serie.json")

{- Lista os jogos do sistema -}
listarJogos :: String
listarJogos = "Lista de jogo:\n" ++ organizaListagem (BD.getJogoJSON "app/DataBase/Jogo.json")

{- Faz a organização das lista em uma string por linha usando a sua representação em string -}
organizaListagem :: Show t => [t] -> String
organizaListagem [] = ""
organizaListagem xs = go xs 1
  where
    go [] _ = ""
    go (x : xs) index = "\n" ++ show index ++ " - " ++ show x ++ "\n" ++ go xs (index + 1)

alugaFilmeDias :: String -> String -> Int -> IO String
alugaFilmeDias idCliente nomeProduto qtdDias = do
  let cliente = BD.getClienteByID idCliente (BD.getClienteJSON "app/DataBase/Cliente.json")
  let nomeCliente = Models.Cliente.nome cliente

  let filme = BD.getFilmeByNome nomeProduto (BD.getFilmeJSON "app/DataBase/Filme.json")
  let idFilme = Models.Filme.identificador filme

  dataCompra <- getCurrentDate
  let idCompra = generateID 'c'
  let compra = Compra idCompra idCliente nomeCliente idFilme nomeProduto dataCompra

  BD.editClienteHistoricoJSON idCliente compra

  let preco = fromIntegral qtdDias * Models.Filme.precoPorDia filme
  let saida = "\nAluguel de " ++ nomeProduto ++ "realizado por " ++ show preco ++ " reais\n"

  return saida

alugaFilmeSemanas :: String -> String -> Int -> IO String
alugaFilmeSemanas idCliente nomeProduto qtdSemanas = do
  let cliente = BD.getClienteByID idCliente (BD.getClienteJSON "app/DataBase/Cliente.json")
  let nomeCliente = Models.Cliente.nome cliente

  let filme = BD.getFilmeByNome nomeProduto (BD.getFilmeJSON "app/DataBase/Filme.json")
  let idFilme = Models.Filme.identificador filme

  dataCompra <- getCurrentDate
  let idCompra = generateID 'c'
  let compra = Compra idCompra idCliente nomeCliente idFilme nomeProduto dataCompra

  BD.editClienteHistoricoJSON idCliente compra

  let preco = fromIntegral qtdSemanas * 7 * Models.Filme.precoPorDia filme
  let saida = "\nAluguel de " ++ nomeProduto ++ "realizado por " ++ show preco ++ " reais\n"
  return saida

alugaSerieDias :: String -> String -> Int -> IO String
alugaSerieDias idCliente nomeProduto qtdDias = do
  let cliente = BD.getClienteByID idCliente (BD.getClienteJSON "app/DataBase/Cliente.json")
  let nomeCliente = Models.Cliente.nome cliente

  let serie = BD.getSerieByNome nomeProduto (BD.getSerieJSON "app/DataBase/Serie.json")
  let idSerie = Models.Serie.identificador serie

  dataCompra <- getCurrentDate
  let idCompra = generateID 'c'
  let compra = Compra idCompra idCliente nomeCliente idSerie nomeProduto dataCompra

  BD.editClienteHistoricoJSON idCliente compra

  let preco = fromIntegral qtdDias * Models.Serie.precoPorDia serie
  let saida = "\nAluguel de " ++ nomeProduto ++ "realizado por " ++ show preco ++ " reais\n"
  return saida

alugaSerieSemanas :: String -> String -> Int -> IO String
alugaSerieSemanas idCliente nomeProduto qtdSemanas = do
  let cliente = BD.getClienteByID idCliente (BD.getClienteJSON "app/DataBase/Cliente.json")
  let nomeCliente = Models.Cliente.nome cliente

  let serie = BD.getSerieByNome nomeProduto (BD.getSerieJSON "app/DataBase/Serie.json")
  let idSerie = Models.Serie.identificador serie

  dataCompra <- getCurrentDate
  let idCompra = generateID 'c'
  let compra = Compra idCompra idCliente nomeCliente idSerie nomeProduto dataCompra

  BD.editClienteHistoricoJSON idCliente compra

  let preco = fromIntegral qtdSemanas * 7 * Models.Serie.precoPorDia serie
  let saida = "\nAluguel de " ++ nomeProduto ++ "realizado por " ++ show preco ++ " reais\n"
  return saida

alugaJogoDias :: String -> String -> Int -> IO String
alugaJogoDias idCliente nomeProduto qtdDias = do
  let cliente = BD.getClienteByID idCliente (BD.getClienteJSON "app/DataBase/Cliente.json")
  let nomeCliente = Models.Cliente.nome cliente

  let jogo = BD.getJogoByNome nomeProduto (BD.getJogoJSON "app/DataBase/Jogo.json")
  let idJogo = Models.Jogo.identificador jogo

  dataCompra <- getCurrentDate
  let idCompra = generateID 'c'
  let compra = Compra idCompra idCliente nomeCliente idJogo nomeProduto dataCompra

  BD.editClienteHistoricoJSON idCliente compra

  let preco = fromIntegral qtdDias * Models.Jogo.precoPorDia jogo
  let saida = "\nAluguel de " ++ nomeProduto ++ "realizado por " ++ show preco ++ " reais\n"
  return saida

alugaJogoSemanas :: String -> String -> Int -> IO String
alugaJogoSemanas idCliente nomeProduto qtdSemanas = do
  let cliente = BD.getClienteByID idCliente (BD.getClienteJSON "app/DataBase/Cliente.json")
  let nomeCliente = Models.Cliente.nome cliente

  let jogo = BD.getJogoByNome nomeProduto (BD.getJogoJSON "app/DataBase/Jogo.json")
  let idJogo = Models.Jogo.identificador jogo

  dataCompra <- getCurrentDate
  let idCompra = generateID 'c'
  let compra = Compra idCompra idCliente nomeCliente idJogo nomeProduto dataCompra

  BD.editClienteHistoricoJSON idCliente compra

  let preco = fromIntegral qtdSemanas * 7 * Models.Jogo.precoPorDia jogo
  let saida = "\nAluguel de " ++ nomeProduto ++ "realizado por " ++ show preco ++ " reais\n"
  return saida

generateID :: Char -> String
generateID c =
  let g = mkStdGen 42 -- use a fixed seed for reproducibility
      alphaNums = filter isAlphaNum (randomRs ('a', 'z') g)
      upperNums = filter isAlphaNum (randomRs ('A', 'Z') g)
      nums = filter isAlphaNum (randomRs ('0', '9') g)
      idStr = take 9 (alphaNums ++ upperNums ++ nums)
   in idStr ++ "-" ++ [toLower c]

getCurrentDate :: IO String
getCurrentDate = do
  formatTime defaultTimeLocale "%d/%m/%y" <$> getCurrentTime

adicionarFilmeAoCarrinho :: String -> String -> IO String
adicionarFilmeAoCarrinho idCliente nomeProduto = do
  let filme = BD.getFilmeByNome nomeProduto (BD.getFilmeJSON "app/DataBase/Filme.json")
  let idFilme = Models.Filme.identificador filme

  let produto = Produto (generateID 'p') idFilme

  BD.editClienteCarrinhoJSON idCliente produto

  let saida = "Produto " ++ nomeProduto ++ " adicionado ao carrinho"

  return saida

adicionarSerieAoCarrinho :: String -> String -> IO String
adicionarSerieAoCarrinho idCliente nomeProduto = do
  let serie = BD.getSerieByNome nomeProduto (BD.getSerieJSON "app/DataBase/Serie.json")
  let idSerie = Models.Serie.identificador serie

  let produto = Produto (generateID 'p') idSerie

  BD.editClienteCarrinhoJSON idCliente produto

  let saida = "Produto " ++ nomeProduto ++ " adicionado ao carrinho"

  return saida

adicionarJogoAoCarrinho :: String -> String -> IO String
adicionarJogoAoCarrinho idCliente nomeProduto = do
  let jogo = BD.getJogoByNome nomeProduto (BD.getJogoJSON "app/DataBase/Jogo.json")
  let idJogo = Models.Jogo.identificador jogo

  let produto = Produto (generateID 'p') idJogo

  BD.editClienteCarrinhoJSON idCliente produto

  let saida = "Produto " ++ nomeProduto ++ " adicionado ao carrinho"

  return saida

listarProdutos :: String -> String
listarProdutos idCliente = "Carrinho:\n" ++ BD.getCarrinho idCliente

removerProduto :: String -> String -> IO String
removerProduto idCliente nomeProduto = do
  let filme = BD.getFilmeByNome nomeProduto (BD.getFilmeJSON "app/DataBase/Filme.json")
  let idFilme = Models.Filme.identificador filme

  let serie = BD.getSerieByNome nomeProduto (BD.getSerieJSON "app/DataBase/Serie.json")
  let idSerie = Models.Serie.identificador serie

  let jogo = BD.getJogoByNome nomeProduto (BD.getJogoJSON "app/DataBase/Jogo.json")
  let idJogo = Models.Jogo.identificador jogo

  if ((Models.Filme.identificador filme) == "-1" && (Models.Serie.identificador serie) == "-1")
    then do
      BD.removeClienteProdutoJSON idCliente idJogo
      return "Produto removido com sucesso!"
    else
      if ((Models.Filme.identificador filme) == "-1" && (Models.Jogo.identificador jogo) == "-1")
        then do
          BD.removeClienteProdutoJSON idCliente idSerie
          return "Produto removido com sucesso!"
        else do
          BD.removeClienteProdutoJSON idCliente idFilme
          return "Produto removido com sucesso!"

recomendacoes :: String -> String
recomendacoes idCliente = ""

