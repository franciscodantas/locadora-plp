module Functions.GerenteFunctions (
    cadastraFunc,
    exibirFuncionario, listarFun,estatisticas
) where

    import DataBase.GerenciadorBD as Bd
    import Models.Funcionario
    import Models.Cliente
    import Models.Compra
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

    estatisticas :: String
    estatisticas = do
        let historico = getHistorico (Bd.getClienteJSON "app/DataBase/Cliente.json")
        let maiorComprador = getMaiorComprador (Bd.getClienteJSON "app/DataBase/Cliente.json")
        let maisVendido = getMaisVendido historico
        "Estatistícas de Venda:\n---------------\n" ++ maiorComprador ++ "\n---------------\n" ++maisVendido
    
    getMaisVendido :: [Compra] -> String
    getMaisVendido historico = do
        let top3 = take 3 (repetidos(contagem historico))
        "Produtos mais vendidos (Top 3):\n" ++ organizaProdutos top3 1
    
    repetidos :: [(Compra,Int)] -> [(Compra,Int)]
    repetidos [] = []
    repetidos (x:xs) = x : repetidos (filter (/= x) xs)
    
    organizaProdutos :: [(Compra,Int)] -> Int -> String
    organizaProdutos [] cont = show cont ++ "."
    organizaProdutos compras 4 = ""
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

    cadastrarFuncionario :: String -> String -> IO String
    cadastrarFuncionario idFuncionario nome = do
        if validaFuncionario idFuncionario nome then do
            BD.saveFuncionarioJSON idFuncionario nome
            return (show (BD.getFuncionarioByID idFuncionario (getFuncionarioJSON "DataBase/Funcionario.json")))
        else return "Cadastro falhou!"


    {- Lista os Funcionarios do sistema -}
    listarFuncionarios:: String
    listarFuncionarios = organizaListagem (BD.getFuncionarioJSON "DataBase/Funcionario.json")


    {- Exibir funcionário -}

    listarFuncionario:: String -> IO String
    listarFuncionario idFuncionario = do
        if validaFuncionario idFuncionario then
            return (show (BD.getFuncionarioByID idFuncionario (getFuncionarioJSON "DataBase/Funcionario.json")))
        else return "Não encontrado"

    rendaFilmes:: Float
    rendaFilmes = do
        let filmes = BD.getFilmeJSON "DataBase/Filme.json"
        sum [Models.Filme.qtdAlugueis f * Models.Filme.precoPorDia f | f <- filmes]

    rendaSeries:: Float
    rendaSeries = do
        let series = BD.getSerieJSON "DataBase/Serie.json"
        sum [Models.Serie.qtdAlugueis s * Models.Serie.precoPorDia s | s <- series]

    rendaJogos:: Float
    rendaJogos = do
        let jogos = BD.getSerieJSON "DataBase/Jogo.json"
        sum [Models.Jogo.qtdAlugueis j * Models.Jogo.precoPorDia j | j <- jogos]

    totalRenda :: Float
    totalRenda = rendaFilmes + rendaSeries + rendaJogos

    estatisticasNovas :: String
    estatisticasNovas = do
        let historico = getHistorico (Bd.getClienteJSON "app/DataBase/Cliente.json")
        "Estatistícas das rendas:\n---------------\n" ++ rendaFilmes ++ "\n---------------\n" ++ rendaSeries ++ "\n---------------\n" ++ rendaJogos ++ "\n---------------\n" totalRenda