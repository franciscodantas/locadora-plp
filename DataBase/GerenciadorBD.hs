module DataBase.GerenciadorBD (module DataBase.GerenciadorBD) where

-- Meta requisitos --
import Data.Aeson
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.Char8 as BC
import GHC.Generics
import System.IO.Unsafe
import System.IO
import System.Directory

-- Importação do modelo dos Objetos do sistema --
import Models.Filme
import Models.Serie
import Models.Jogo
import Models.Cliente
import Models.Funcionario
import Models.Gerente
import Models.Compra
import Models.Produto

instance FromJSON Filme
instance ToJSON Filme

-- Pega todos os filmes --
getFilmeJSON :: String -> [Filme]
getFilmeJSON path = do
    let file = unsafePerformIO( B.readFile path )
    let decodedFile = decode file :: Maybe [Filme]
    case decodedFile of
        Nothing -> []
        Just out -> out

-- Salva um novo filme no arquivos de filmes --
saveFilmeJSON :: String -> String -> String -> String -> Float -> IO()
saveFilmeJSON identificador nome descricao categoria preco = do
    let p = Filme identificador nome descricao categoria 0 preco
    let filmeList = (getFilmeJSON "DataBase/Filme.json") ++ [p]
    
    B.writeFile "../Temp.json" $ encode filmeList
    removeFile "DataBase/Filme.json"
    renameFile "../Temp.json" "DataBase/Filme.json"

getFilmeByID :: String -> [Filme] -> Filme
getFilmeByID _ [] = Filme "-1" "" "" "" 0 0.0
getFilmeByID identifierS (x:xs)
    | (Models.Filme.identificador x) == identifierS = x
    | otherwise = getFilmeByID identifierS xs

removeFilmeByID :: String -> [Filme] -> [Filme]
removeFilmeByID _ [] = []
removeFilmeByID identifierS (x:xs)
    | (Models.Filme.identificador x) == identifierS = xs
    | otherwise = [x] ++ (removeFilmeByID identifierS xs)

editFilmeQtdJSON :: String -> Int -> IO()
editFilmeQtdJSON identifier qtd = do
    let filmeList = getFilmeJSON "DataBase/Filme.json"
    let f = getFilmeByID identifier filmeList
    let p = Filme identifier (Models.Filme.nome f) (Models.Filme.descricao f) (Models.Filme.categoria f) qtd (Models.Filme.precoPorDia f)
    let newFilmeList = (removeFilmeByID identifier filmeList) ++ [p]

    B.writeFile "../Temp.json" $ encode newFilmeList
    removeFile "DataBase/Filme.json"
    renameFile "../Temp.json" "DataBase/Filme.json"

saveAlteracoesFilme :: [Filme] -> IO()
saveAlteracoesFilme filmeList = do
    B.writeFile "../Temp.json" $ encode filmeList
    removeFile "DataBase/Filme.json"
    renameFile "../Temp.json" "DataBase/Filme.json"

instance FromJSON Jogo
instance ToJSON Jogo

-- Pega todos os Jogos --
getJogoJSON :: String -> [Jogo]
getJogoJSON path = do
    let file = unsafePerformIO( B.readFile path )
    let decodedFile = decode file :: Maybe [Jogo]
    case decodedFile of
        Nothing -> []
        Just out -> out

-- Salva um novo Jogo no arquivos de Jogos --
saveJogoJSON :: String -> String -> String -> String -> Float -> IO()
saveJogoJSON identificador nome descricao categoria preco = do
    let p = Jogo identificador nome descricao categoria 0 preco
    let jogoList = (getJogoJSON "DataBase/Jogo.json") ++ [p]
    
    B.writeFile "../Temp.json" $ encode jogoList
    removeFile "DataBase/Jogo.json"
    renameFile "../Temp.json" "DataBase/Jogo.json"

getJogoByID :: String -> [Jogo] -> Jogo
getJogoByID _ [] = Jogo "-1" "" "" "" 0 0.0
getJogoByID identifierS (x:xs)
    | (Models.Jogo.identificador x) == identifierS = x
    | otherwise = getJogoByID identifierS xs

removeJogoByID :: String -> [Jogo] -> [Jogo]
removeJogoByID _ [] = []
removeJogoByID identifierS (x:xs)
    | (Models.Jogo.identificador x) == identifierS = xs
    | otherwise = [x] ++ (removeJogoByID identifierS xs)

editJogoQtdJSON :: String -> Int -> IO()
editJogoQtdJSON identifier qtd = do
    let jogoList = getJogoJSON "DataBase/Jogo.json"
    let f = getJogoByID identifier jogoList
    let p = Jogo identifier (Models.Jogo.nome f) (Models.Jogo.descricao f) (Models.Jogo.categoria f) qtd (Models.Jogo.precoPorDia f)
    let newJogoList = (removeJogoByID identifier jogoList) ++ [p]

    B.writeFile "../Temp.json" $ encode newJogoList
    removeFile "DataBase/Jogo.json"
    renameFile "../Temp.json" "DataBase/Jogo.json"

saveAlteracoesJogo :: [Jogo] -> IO()
saveAlteracoesJogo jogoList = do
    B.writeFile "../Temp.json" $ encode jogoList
    removeFile "DataBase/Jogo.json"
    renameFile "../Temp.json" "DataBase/Jogo.json"

instance FromJSON Serie
instance ToJSON Serie

-- Pega todos os Series --
getSerieJSON :: String -> [Serie]
getSerieJSON path = do
    let file = unsafePerformIO( B.readFile path )
    let decodedFile = decode file :: Maybe [Serie]
    case decodedFile of
        Nothing -> []
        Just out -> out

-- Salva um novo Serie no arquivos de Series --
saveSerieJSON :: String -> String -> String -> String -> Float -> IO()
saveSerieJSON identificador nome descricao categoria preco = do
    let p = Serie identificador nome descricao categoria 0 preco
    let serieList = (getSerieJSON "DataBase/Serie.json") ++ [p]
    
    B.writeFile "../Temp.json" $ encode serieList
    removeFile "DataBase/Serie.json"
    renameFile "../Temp.json" "DataBase/Serie.json"

getSerieByID :: String -> [Serie] -> Serie
getSerieByID _ [] = Serie "-1" "" "" "" 0 0.0
getSerieByID identifierS (x:xs)
    | (Models.Serie.identificador x) == identifierS = x
    | otherwise = getSerieByID identifierS xs

removeSerieByID :: String -> [Serie] -> [Serie]
removeSerieByID _ [] = []
removeSerieByID identifierS (x:xs)
    | (Models.Serie.identificador x) == identifierS = xs
    | otherwise = [x] ++ (removeSerieByID identifierS xs)

editSerieQtdJSON :: String -> Int -> IO()
editSerieQtdJSON identifier qtd = do
    let serieList = getSerieJSON "DataBase/Serie.json"
    let f = getSerieByID identifier serieList
    let p = Serie identifier (Models.Serie.nome f) (Models.Serie.descricao f) (Models.Serie.categoria f) qtd (Models.Serie.precoPorDia f)
    let newSerieList = (removeSerieByID identifier serieList) ++ [p]

    B.writeFile "../Temp.json" $ encode newSerieList
    removeFile "DataBase/Serie.json"
    renameFile "../Temp.json" "DataBase/Serie.json"

saveAlteracoesSerie :: [Serie] -> IO()
saveAlteracoesSerie serieList = do
    B.writeFile "../Temp.json" $ encode serieList
    removeFile "DataBase/Serie.json"
    renameFile "../Temp.json" "DataBase/Serie.json"

instance FromJSON Cliente
instance ToJSON Cliente

instance FromJSON Produto
instance ToJSON Produto

instance FromJSON Compra
instance ToJSON Compra

-- Pega todos os Clientes --
getClienteJSON :: String -> [Cliente]
getClienteJSON path = do
    let file = unsafePerformIO( B.readFile path )
    let decodedFile = decode file :: Maybe [Cliente]
    case decodedFile of
        Nothing -> []
        Just out -> out

-- Salva um novo Cliente no arquivos de Clientes --
saveClienteJSON :: String -> String -> IO()
saveClienteJSON identificador nome = do
    let produtosList = [] :: [Produto]
    let compraList = [] :: [Compra]

    let p = Cliente identificador nome produtosList compraList
    let clienteList = (getClienteJSON "DataBase/Cliente.json") ++ [p]
    
    B.writeFile "../Temp.json" $ encode clienteList
    removeFile "DataBase/Cliente.json"
    renameFile "../Temp.json" "DataBase/Cliente.json"

getClienteByID :: String -> [Cliente] -> Cliente
getClienteByID _ [] = do
    let produtosList = [] :: [Produto]
    let compraList = [] :: [Compra]

    Cliente "-1" "" produtosList compraList
getClienteByID identifierS (x:xs)
    | (Models.Cliente.identificador x) == identifierS = x
    | otherwise = getClienteByID identifierS xs

removeClienteByID :: String -> [Cliente] -> [Cliente]
removeClienteByID _ [] = []
removeClienteByID identifierS (x:xs)
    | (Models.Cliente.identificador x) == identifierS = xs
    | otherwise = [x] ++ (removeClienteByID identifierS xs)

editClienteCarrinhoJSON :: String -> Produto -> IO()
editClienteCarrinhoJSON identifier produto = do
    let clienteList = getClienteJSON "DataBase/Cliente.json"
    let f = getClienteByID identifier clienteList
    let new_carrinho = (Models.Cliente.carrinho f) ++ [produto]
    let p = Cliente identifier (Models.Cliente.nome f) new_carrinho (Models.Cliente.historico f)
    let newClienteList = (removeClienteByID identifier clienteList) ++ [p]

    B.writeFile "../Temp.json" $ encode newClienteList
    removeFile "DataBase/Cliente.json"
    renameFile "../Temp.json" "DataBase/Cliente.json"

removeProduto :: String -> [Produto] -> [Produto]
removeProduto _ [] = []
removeProduto identifierS (x:xs)
    | (Models.Produto.idProduto x) == identifierS = xs
    | otherwise = [x] ++ (removeProduto identifierS xs)

removeClienteProdutoJSON :: String -> String -> IO()
removeClienteProdutoJSON identifier idProduto = do
    let clienteList = getClienteJSON "DataBase/Cliente.json"
    let f = getClienteByID identifier clienteList
    let new_carrinho = removeProduto idProduto (Models.Cliente.carrinho f)
    let p = Cliente identifier (Models.Cliente.nome f) new_carrinho (Models.Cliente.historico f)
    let newClienteList = (removeClienteByID identifier clienteList) ++ [p]

    B.writeFile "../Temp.json" $ encode newClienteList
    removeFile "DataBase/Cliente.json"
    renameFile "../Temp.json" "DataBase/Cliente.json"

editClienteHistoricoJSON :: String -> Compra -> IO()
editClienteHistoricoJSON identifier compra = do
    let clienteList = getClienteJSON "DataBase/Cliente.json"
    let f = getClienteByID identifier clienteList
    let new_historico = (Models.Cliente.historico f) ++ [compra]
    let p = Cliente identifier (Models.Cliente.nome f) (Models.Cliente.carrinho f) new_historico
    let newClienteList = (removeClienteByID identifier clienteList) ++ [p]

    B.writeFile "../Temp.json" $ encode newClienteList
    removeFile "DataBase/Cliente.json"
    renameFile "../Temp.json" "DataBase/Cliente.json"

saveAlteracoesCliente :: [Cliente] -> IO()
saveAlteracoesCliente clienteList = do
    B.writeFile "../Temp.json" $ encode clienteList
    removeFile "DataBase/Cliente.json"
    renameFile "../Temp.json" "DataBase/Cliente.json"

instance FromJSON Gerente
instance ToJSON Gerente

-- Pega todos os Gerentes --
getGerenteJSON :: String -> [Gerente]
getGerenteJSON path = do
    let file = unsafePerformIO( B.readFile path )
    let decodedFile = decode file :: Maybe [Gerente]
    case decodedFile of
        Nothing -> []
        Just out -> out

-- Salva um novo Gerente no arquivos de Gerentes --
saveGerenteJSON :: String -> String -> IO()
saveGerenteJSON identificador nome = do
    let p = Gerente identificador nome
    let gerenteList = (getGerenteJSON "DataBase/Gerente.json") ++ [p]
    
    B.writeFile "../Temp.json" $ encode gerenteList
    removeFile "DataBase/Gerente.json"
    renameFile "../Temp.json" "DataBase/Gerente.json"

getGerenteByID :: String -> [Gerente] -> Gerente
getGerenteByID _ [] = Gerente "-1" ""
getGerenteByID identifierS (x:xs)
    | (Models.Gerente.identificador x) == identifierS = x
    | otherwise = getGerenteByID identifierS xs

instance FromJSON Funcionario
instance ToJSON Funcionario

-- Pega todos os Funcionarios --
getFuncionarioJSON :: String -> [Funcionario]
getFuncionarioJSON path = do
    let file = unsafePerformIO( B.readFile path )
    let decodedFile = decode file :: Maybe [Funcionario]
    case decodedFile of
        Nothing -> []
        Just out -> out

-- Salva um novo Funcionario no arquivos de Funcionarios --
saveFuncionarioJSON :: String -> String -> IO()
saveFuncionarioJSON identificador nome = do
    let p = Funcionario identificador nome
    let funcionarioList = (getFuncionarioJSON "DataBase/Funcionario.json") ++ [p]
    
    B.writeFile "../Temp.json" $ encode funcionarioList
    removeFile "DataBase/Funcionario.json"
    renameFile "../Temp.json" "DataBase/Funcionario.json"

getFuncionarioByID :: String -> [Funcionario] -> Funcionario
getFuncionarioByID _ [] = Funcionario "-1" ""
getFuncionarioByID identifierS (x:xs)
    | (Models.Funcionario.identificador x) == identifierS = x
    | otherwise = getFuncionarioByID identifierS xs

removeFuncionarioByID :: String -> [Funcionario] -> [Funcionario]
removeFuncionarioByID _ [] = []
removeFuncionarioByID identifierS (x:xs)
    | (Models.Funcionario.identificador x) == identifierS = xs
    | otherwise = [x] ++ (removeFuncionarioByID identifierS xs)

saveAlteracoesFuncionario :: [Funcionario] -> IO()
saveAlteracoesFuncionario funcionarioList = do
    B.writeFile "../Temp.json" $ encode funcionarioList
    removeFile "DataBase/Funcionario.json"
    renameFile "../Temp.json" "DataBase/Funcionario.json"

-- Pega todo histórico --
getCompraJSON :: String -> [Compra]
getCompraJSON path = do
    let file = unsafePerformIO( B.readFile path )
    let decodedFile = decode file :: Maybe [Compra]
    case decodedFile of
        Nothing -> []
        Just out -> out

-- Add compra ao histórico --
saveCompraJSON :: Compra -> IO()
saveCompraJSON compra = do
    let compraList = (getCompraJSON "DataBase/Historico.json") ++ [compra]
    
    B.writeFile "../Temp.json" $ encode compraList
    removeFile "DataBase/Historico.json"
    renameFile "../Temp.json" "DataBase/Historico.json"
