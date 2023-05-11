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
            return (show(Bd.getFuncionarioByID id (Bd.getFuncionarioJSON "app/DataBase/Funcionario.json")))
    
    exibirFuncionario :: String -> String
    exibirFuncionario "" = "Id inválido!"
    exibirFuncionario id = do
        let funcionario = show(Bd.getFuncionarioByID id (Bd.getFuncionarioJSON "app/DataBase/Funcionario.json"))
        if funcionario == "Nome:  - (-1)" then "Funcionario não existe" else show(funcionario)

    listarFun :: String
    listarFun = organizaListagem (Bd.getFuncionarioJSON "app/DataBase/Funcionario.json")

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
    
    rendaFilmes :: String
    rendaFilmes = "\n A renda dos filmes alugados é de: R$ " ++ show (calculaRendaFilmes) ++ ",00"

    rendaSeries :: String
    rendaSeries = "\n A renda das series alugadas é de: R$ " ++ show (calculaRendaSeries) ++ ",00"
    
    rendaJogos :: String
    rendaJogos = "\n A renda dos jogos alugadas é de: R$ " ++ show (calculaRendaJogos) ++ ",00"

    calculaRendaFilmes :: Integer
    calculaRendaFilmes = floor renda :: Integer
        where
            filmes = Bd.getFilmeJSON "app/DataBase/Filme.json"
            renda = sum [fromIntegral (Models.Filme.qtdAlugueis f) * Models.Filme.precoPorDia f | f <- filmes]

    calculaRendaSeries :: Integer
    calculaRendaSeries = floor renda :: Integer
        where
            series = Bd.getSerieJSON "app/DataBase/Serie.json"
            renda = sum [fromIntegral (Models.Serie.qtdAlugueis s) * Models.Serie.precoPorDia s | s <- series]

    calculaRendaJogos :: Integer
    calculaRendaJogos = floor renda :: Integer
        where
            jogos = Bd.getJogoJSON "app/DataBase/Jogo.json"
            renda = sum [fromIntegral (Models.Jogo.qtdAlugueis j) * Models.Jogo.precoPorDia j | j <- jogos]

    rendaTotal :: String
    rendaTotal = "\n A renda total dos alugueis é de: R$ " ++ show (calculaRendaTotal) ++ ",00"

    calculaRendaTotal :: Integer
    calculaRendaTotal = (calculaRendaFilmes + calculaRendaJogos + calculaRendaSeries)

    totalClientes :: IO String
    totalClientes = do
      clienteList <- Bd.getClienteJSON "app/DataBase/Cliente.json"
      let quantidadeClientes = length clienteList
      return ("\nQuantidade de clientes ativos: " ++ show quantidadeClientes)

    totalFuncionarios :: String
    totalFuncionarios = "Quantidade de funcionarios: " ++ show (length (getFuncionarioJSON "app/DataBase/Funcionario.json"))

    totalJogosDisponiveis :: String
    totalJogosDisponiveis = "Jogos disponiveis para alugar: " ++ show (length (getFuncionarioJSON "app/DataBase/Jogo.json"))
