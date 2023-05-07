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
    cadastraFunc id nome senha = do
        if validaGerente senha then do
            Bd.saveFuncionarioJSON id nome
            return (show(Bd.getFuncionarioByID id (Bd.getFuncionarioJSON "app/DataBase/Funcionario.json")))
        else
            return "Cadastro falhou!"
    
    exibirFuncionario :: String -> String
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
        let top3 = take 3 (contagem historico)
        "Produtos mais vendidos:\n" ++ organizaProdutos top3 1
    
    organizaProdutos :: [(Compra,Int)] -> Int -> String
    organizaProdutos [] _ = ""
    organizaProdutos compras 3 = ""
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