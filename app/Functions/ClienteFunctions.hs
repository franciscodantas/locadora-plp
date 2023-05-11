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
import Data.List (sortBy)

{- Lista os filmes do sistema -}
listarFilmes :: IO String
listarFilmes = do
  filmes <- BD.getFilmeJSON "app/DataBase/Filme.json"
  return $ "Lista de filmes:\n" ++ organizaListagem filmes

{- Lista filmes de uma categoria -}
pesquisaFilmes :: String -> IO String
pesquisaFilmes cat = do
  filmes <- BD.getFilmeJSON "app/DataBase/Filme.json"
  let filmesFiltrados = filtraFilmes cat filmes
  return $ "Lista de filmes:\n" ++ organizaListagem filmesFiltrados

{- Lista as series do sistema do sistema -}
listarSeries :: String
listarSeries = "Lista de série:\n" ++ organizaListagem (BD.getSerieJSON "app/DataBase/Serie.json")

{- Lista series de uma categoria -}
pesquisaSeries:: String -> String
pesquisaSeries cat = do
  let series = filtraSeries cat (BD.getSerieJSON "app/DataBase/Serie.json")
  "Lista de séries:\n" ++ organizaListagem series

{- Lista os jogos do sistema -}
listarJogos :: String
listarJogos = "Lista de jogo:\n" ++ organizaListagem (BD.getJogoJSON "app/DataBase/Jogo.json")

{- Lista jogos de uma categoria -}
pesquisaJogos:: String -> String
pesquisaJogos cat = do
  let jogos = filtraJogos cat (BD.getJogoJSON "app/DataBase/Jogo.json")
  "Lista de jogos:\n" ++ organizaListagem jogos

{- Faz a organização das lista em uma string por linha usando a sua representação em string -}
organizaListagem :: Show t => [t] -> String
organizaListagem [] = ""
organizaListagem xs = go xs 1
  where
    go [] _ = ""
    go (x : xs) index = "\n" ++ show index ++ " - " ++ show x ++ "\n" ++ go xs (index + 1)

alugaFilmeDias :: String -> String -> Int -> IO String
alugaFilmeDias idCliente nomeProduto qtdDias = do
  clientList <- BD.getClienteJSON "app/DataBase/Cliente.json"
  let cliente = BD.getClienteByID idCliente clientList
  let nomeCliente = Models.Cliente.nome cliente

  filmeList <- BD.getFilmeJSON "app/DataBase/Filme.json"
  let filme = BD.getFilmeByNome nomeProduto filmeList
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
  clientList <- BD.getClienteJSON "app/DataBase/Cliente.json"
  let cliente = BD.getClienteByID idCliente clientList
  let nomeCliente = Models.Cliente.nome cliente

  filmeList <- (BD.getFilmeJSON "app/DataBase/Filme.json")
  let filme = BD.getFilmeByNome nomeProduto filmeList
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
  clientList <- BD.getClienteJSON "app/DataBase/Cliente.json"
  let cliente = BD.getClienteByID idCliente clientList
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
  clientList <- BD.getClienteJSON "app/DataBase/Cliente.json"
  let cliente = BD.getClienteByID idCliente clientList
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
  clientList <- BD.getClienteJSON "app/DataBase/Cliente.json"
  let cliente = BD.getClienteByID idCliente clientList
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
  clientList <- BD.getClienteJSON "app/DataBase/Cliente.json"
  let cliente = BD.getClienteByID idCliente clientList
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
  filmeList <- (BD.getFilmeJSON "app/DataBase/Filme.json")
  let filme = BD.getFilmeByNome nomeProduto filmeList
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

listarProdutos :: String -> IO String
listarProdutos idCliente = do
  carrinho <- BD.getCarrinho idCliente
  return $ "Carrinho:\n" ++ carrinho

removerProduto :: String -> String -> IO String
removerProduto idCliente nomeProduto = do
  filmeList <- (BD.getFilmeJSON "app/DataBase/Filme.json")
  let filme = BD.getFilmeByNome nomeProduto filmeList
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

recomendacoes :: String -> String -> IO String
recomendacoes op idCliente = do
  clientList <- (BD.getClienteJSON "app/DataBase/Cliente.json")
  let cliente = BD.getClienteByID idCliente clientList
      hist = getHistoricoID (Models.Cliente.historico cliente) []

  case op of
    "1" -> do
      let cat = getCategoriasFilmes (getFilmList hist []) []
      if any null cat || null  cat then do
        let cat = getMaisVendido (getHistorico clientList)
            recs = getFilmList cat []
        return $ "Filmes recomendados:\n" ++ organizaListagem (filter (\x -> Models.Filme.identificador x /= "-1") recs)
      else do
        filmeList <- (BD.getFilmeJSON "app/DataBase/Filme.json")
        let filmesNaoAlugados = filter (\x -> (notElem (Models.Filme.identificador x) hist)) filmeList
            recs = filter (\x -> (elem (Models.Filme.categoria x) cat)) filmesNaoAlugados
        return $ "Filmes recomendados:\n" ++ organizaListagem recs
    "2" -> do
      let cat = getCategoriasSeries (getSerList hist []) []
      if any null cat || null  cat then do
        let cat = getMaisVendido (getHistorico clientList)
            recs = getSerList cat []
        return $ "Séries recomendadas:\n" ++ organizaListagem (filter (\x -> Models.Serie.identificador x /= "-1") recs)
      else do
        let seriesNaoAlugadas = filter (\x -> (notElem (Models.Serie.identificador x) hist)) (BD.getSerieJSON "app/DataBase/Serie.json")
            recs = filter (\x -> (elem (Models.Serie.categoria x) cat)) seriesNaoAlugadas
        return $ "Séries recomendadas:\n" ++ organizaListagem recs
    "3" -> do
      let cat = getCategoriasJogos (getJogoList hist []) []
      if any null cat || null  cat then do
        let cat = getMaisVendido (getHistorico clientList)
            recs = getJogoList cat []
        return $ "Jogos recomendados:\n" ++ organizaListagem (filter (\x -> Models.Jogo.identificador x /= "-1") recs)
      else do
        let jogosNaoAlugados = filter (\x -> (notElem (Models.Jogo.identificador x) hist)) (BD.getJogoJSON "app/DataBase/Jogo.json")
            recs = filter (\x -> (elem (Models.Jogo.categoria x) cat)) jogosNaoAlugados
        return $ "Jogos recomendados:\n"


{- Filtra filmes por categoria -}
filtraFilmes:: String -> [Filme] -> [Filme]
filtraFilmes cat [] = []
filtraFilmes cat lista = filter (\x -> (Models.Filme.categoria x) == cat) lista

{- Filtra séries por categoria -}
filtraSeries:: String -> [Serie] -> [Serie]
filtraSeries cat [] = []
filtraSeries cat lista = filter (\x -> (Models.Serie.categoria x) == cat) lista

{- Filtra jogos por categoria -}
filtraJogos:: String -> [Jogo] -> [Jogo]
filtraJogos cat [] = []
filtraJogos cat lista = filter (\x -> (Models.Jogo.categoria x) == cat) lista

{- Retorna uma lista de filmes com base em uma lista de IDs -}
getFilmList :: [String] -> IO [Filme] -> IO [Filme]
getFilmList [] filmes = filmes
getFilmList (x:xs) filmes = do
  filme <- BD.getFilmeByID x =<< filmes
  newFilmes <- getFilmList xs filmes
  return (filme : newFilmes)

{- Retorna uma lista de categorias baseado em uma lista de filmes -}
getCategoriasFilmes:: [Filme] -> [String] -> [String]
getCategoriasFilmes [] categorias = categorias
getCategoriasFilmes (x:xs) categorias = do
  let c = Models.Filme.categoria x
  if (elem c categorias)
    then
      getCategoriasFilmes xs categorias
    else do
      let newLista = append c categorias
      getCategoriasFilmes xs newLista

{- Retorna uma lista de séries com base em uma lista de IDs -}
getSerList:: [String] -> [Serie] -> [Serie]
getSerList [] series = series
getSerList (x:xs) series = do
  let f = BD.getSerieByID x (BD.getSerieJSON "app/DataBase/Serie.json")
  let newList = append f series
  getSerList xs newList

{- Retorna uma lista de categorias baseado em uma lista de séries -}
getCategoriasSeries:: [Serie] -> [String] -> [String]
getCategoriasSeries [] categorias = categorias
getCategoriasSeries (x:xs) categorias = do
  let c = Models.Serie.categoria x
  if (elem c categorias)
    then
      getCategoriasSeries xs categorias
    else do
      let newLista = append c categorias
      getCategoriasSeries xs newLista

{- Retorna uma lista de jogos com base em uma lista de IDs -}
getJogoList:: [String] -> [Jogo] -> [Jogo]
getJogoList [] jogos = jogos
getJogoList (x:xs) jogos = do
  let f = BD.getJogoByID x (BD.getJogoJSON "app/DataBase/Jogo.json")
  let newList = append f jogos
  getJogoList xs newList

{- Retorna uma lista de categorias baseado em uma lista de jogos -}
getCategoriasJogos:: [Jogo] -> [String] -> [String]
getCategoriasJogos [] categorias = categorias
getCategoriasJogos (x:xs) categorias = do
  let c = Models.Jogo.categoria x
  if (elem c categorias)
    then
      getCategoriasJogos xs categorias
    else do
      let newLista = append c categorias
      getCategoriasJogos xs newLista

{- Retorna uma lista com os IDs dos produtos no histórico de um cliente -}
getHistoricoID:: [Compra] -> [String] -> [String]
getHistoricoID [] lista = lista
getHistoricoID (x:xs) lista = do
  let newLista = append (Models.Compra.idProduto x) lista
  getHistoricoID xs newLista

{- Adiciona um elemento novo a uma lista de elementos -}
append:: t -> [t] -> [t]
append a [] = [a]
append a (x:xs) = x : append a xs

getMaisVendido :: [Compra] -> [String]
getMaisVendido historico = (repetidos (contagem historico))


repetidos :: [(Compra,Int)] -> [String]
repetidos [] = []
repetidos (x:xs) = (Models.Compra.idProduto (fst x)) : repetidos (filter (/= x) xs)

contagem :: [Compra] -> [(Compra,Int)]
contagem historico = do
  let aux = map (\c -> (c, length (filter (==c) historico))) historico
  let ordenado = sortBy (\(_, n1) (_, n2) -> compare n2 n1) aux
  ordenado

getHistorico :: [Cliente] -> [Compra]
getHistorico [] = []
getHistorico (x:xs) = Models.Cliente.getCompras x ++ getHistorico xs