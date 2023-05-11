module Functions.GerenteFunctions (
    cadastraFunc,
    exibirFuncionario, listarFun,estatisticas, rendaFilmes, rendaSeries, 
    rendaJogos, rendaTotal, totalClientes, totalFuncionarios, totalJogosDisponiveis
) where

    import DataBase.GerenciadorBD as Bd
    import Models.Funcionario
    import Models.Cliente
    import Models.Compra
    import Models.Filme
    import Models.Serie
    import Models.Jogo
    import Data.List (sortBy)

    cadastraFunc :: String -> String -> String -> IO String
    cadastraFunc id nome senha
        | any null [(filter (/= ' ') id), (filter (/= ' ') nome)] = return "Cadastro falhou!"
        | not (validaGerente senha) = return "Cadastro falhou!"
        | otherwise = do
            Bd.saveFuncionarioJSON id nome
            getFun <- Bd.getFuncionarioJSON "app/DataBase/Funcionario.json"
            return (show(Bd.getFuncionarioByID id getFun))
    
    exibirFuncionario :: String -> IO String
    exibirFuncionario "" = return "Id inválido!"
    exibirFuncionario id = do
        getFun <- Bd.getFuncionarioJSON "app/DataBase/Funcionario.json"
        let funcionario = show(Bd.getFuncionarioByID id getFun)
        if funcionario == "Nome:  - (-1)" then return "Funcionario não existe" else return (show(funcionario))

    listarFun :: IO String
    listarFun = do
        getFun <- Bd.getFuncionarioJSON "app/DataBase/Funcionario.json"
        return $ organizaListagem getFun

    estatisticas :: IO String
    estatisticas = do
        clienteList <- Bd.getClienteJSON "app/DataBase/Cliente.json"
        let historico = getHistorico clienteList
        let maiorComprador = getMaiorComprador clienteList
        let maisVendido = getMaisVendido historico
        return ("Estatísticas de Venda:\n---------------\n" ++ maiorComprador ++ "\n---------------\n" ++ maisVendido)

    
    getMaisVendido :: [Compra] -> String
    getMaisVendido historico = do
        let top3 = take 3 (repetidos(contagem historico))
        "Produtos mais vendidos (Top 3):\n" ++ organizaProdutos top3 1
    
    repetidos :: [(Compra,Int)] -> [(Compra,Int)]
    repetidos [] = []
    repetidos (x:xs) = x : repetidos (filter (/= x) xs)
    
    organizaProdutos :: [(Compra,Int)] -> Int -> String
    organizaProdutos compras 4 = ""
    organizaProdutos [] cont = show cont ++ "."
    organizaProdutos (x:xs) cont = show cont ++ ". " ++ Models.Compra.nomeProduto (fst x) ++ " - " ++ show(snd x) ++ " venda(as)\n" ++ organizaProdutos xs (cont+1)
    
    contagem :: [Compra] -> [(Compra,Int)]
    contagem historico = do
        let aux = map (\c -> (c, length (filter (==c) historico))) historico
        let ordenado = sortBy (\(_, n1) (_, n2) -> compare n2 n1) aux
        ordenado

    getMaiorComprador :: [Cliente] -> String
    getMaiorComprador clientes = do
        let maior = foldr1 (\c1 c2 -> if length (historico c1) > length (historico c2) then c1 else c2) clientes
        "Maior comprador:\nNome: " ++ Models.Cliente.nome maior ++ "\nIdentificador: " ++ Models.Cliente.identificador maior ++ "\nQuantidade de compras: " ++ show (length (Models.Cliente.historico maior))


    getHistorico :: [Cliente] -> [Compra]
    getHistorico [] = []
    getHistorico (x:xs) = Models.Cliente.getCompras x ++ getHistorico xs

    organizaListagem :: Show t => [t] -> String
    organizaListagem [] = ""
    organizaListagem (x:xs) = show x ++ "\n" ++ organizaListagem xs

    validaGerente:: String -> Bool
    validaGerente senha = senha == "01110"

    removeEspacos :: String -> String 
    removeEspacos = map (\c -> if c == ' ' then '-' else c)
    
    rendaFilmes :: IO String
    rendaFilmes = do
        calF <- calculaRendaFilmes
        return $ "\n A renda dos filmes alugados é de: R$ " ++ show calF ++ ",00"

    rendaSeries :: IO String
    rendaSeries = do
        calS <- calculaRendaSeries
        return $ "\n A renda das series alugadas é de: R$ " ++ show calS ++ ",00"
    
    rendaJogos :: IO String
    rendaJogos = do
        calJ <- calculaRendaJogos
        return $ "\n A renda dos jogos alugadas é de: R$ " ++ show calJ ++ ",00"

    calculaRendaFilmes :: IO Integer
    calculaRendaFilmes = do 
        filme <- Bd.getFilmeJSON "app/DataBase/Filme.json"
        return $ floor (renda filme)
        where 
            renda filme = sum [fromIntegral (Models.Filme.qtdAlugueis f) * Models.Filme.precoPorDia f | f <- filme]

    calculaRendaSeries :: IO Integer
    calculaRendaSeries = do
        series <- Bd.getSerieJSON "app/DataBase/Serie.json"
        return $ floor (renda series)
        where
            renda series = sum [fromIntegral (Models.Serie.qtdAlugueis s) * Models.Serie.precoPorDia s | s <- series]

    calculaRendaJogos :: IO Integer
    calculaRendaJogos = do
        jogos <- Bd.getJogoJSON "app/DataBase/Jogo.json"
        return $ floor (renda jogos)
        where
            renda jogos = sum [fromIntegral (Models.Jogo.qtdAlugueis j) * Models.Jogo.precoPorDia j | j <- jogos]

    rendaTotal :: IO String
    rendaTotal = do
        total <-calculaRendaTotal
        return $ "\n A renda total dos alugueis é de: R$ " ++ show total ++ ",00"

    calculaRendaTotal :: IO Integer
    calculaRendaTotal = do
        calF <- calculaRendaFilmes
        calJ <- calculaRendaJogos
        calS <- calculaRendaSeries
        return (calF + calJ + calS)

    totalClientes :: IO String
    totalClientes = do
      clienteList <- Bd.getClienteJSON "app/DataBase/Cliente.json"
      let quantidadeClientes = length clienteList
      return ("\nQuantidade de clientes ativos: " ++ show quantidadeClientes)

    totalFuncionarios :: IO String
    totalFuncionarios = do
        getFun <- getFuncionarioJSON "app/DataBase/Funcionario.json"
        return $ "Quantidade de funcionarios: " ++ show (length getFun)

    totalJogosDisponiveis :: IO String
    totalJogosDisponiveis = do
        getJogos <- getJogoJSON "app/DataBase/Jogo.json"
        return $ "Jogos disponiveis para alugar: " ++ show (length getJogos)
