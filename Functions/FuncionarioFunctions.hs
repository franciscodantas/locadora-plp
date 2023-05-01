module Functions.FuncionarioFunctions where
    import DataBase.GerenciadorBD as BD
    import Models.Filme
    import Models.Funcionario
    import Models.Cliente

    listarFilmes:: String
    listarFilmes = organizaListagem (BD.getFilmeJSON "DataBase/Filme.json")

    listarSeries:: String
    listarSeries = organizaListagem (BD.getSerieJSON "DataBase/Serie.json")

    listarJogos:: String
    listarJogos = organizaListagem (BD.getJogoJSON "DataBase/Jogo.json")

    listarClientes:: String
    listarClientes = organizaListagem (BD.getClienteJSON "DataBase/Cliente.json")

    cadastrarCliente :: String -> String -> String -> String -> IO String
    cadastrarCliente nome idCliente idFun senha = do
        if validaFuncionario idFun senha then do
            BD.saveClienteJSON idCliente nome
            return (show (BD.getClienteByID idCliente (getClienteJSON "DataBase/Cliente.json")))
        else return "Cadastro falhou!"
    
    excluirCliente :: String -> String -> String -> String
    excluirCliente id idFun senha=  do
        if validaFuncionario idFun senha then do
            removeClienteByID id (getClienteJSON "DataBase/Cliente.json")
            "Remoção feita com sucesso"
        else "Não foi possivel realizar ação"

    exibirHistorico :: String -> String
    exibirHistorico id = do
        let cliente = BD.getClienteByID id (getClienteJSON "DataBase/Cliente.json")
        "Historico do cliente: " ++ organizaListagem (Models.Cliente.historico cliente)

    cadastrarSerie :: String ->  String -> String -> String ->  String -> String -> String -> IO String
    cadastrarSerie idFun senha idSerie nome descricao categoria precoPorDia = do
        if validaFuncionario idFun senha then do
            BD.saveSerieJSON idSerie nome descricao categoria (read precoPorDia)
            return "Cadastro realizado"
        else
            return "Cadastro falhou"
    
    excluirSerie :: String -> String -> String -> String
    excluirSerie id idFun senha =  do
        if validaFuncionario idFun senha then do
            removeSerieByID id (getSerieJSON "DataBase/Serie.json")
            "Remoção feita com sucesso"
        else "Não foi possivel realizar ação"
    
    cadastrarFilme :: String ->  String -> String -> String ->  String -> String -> String -> IO String
    cadastrarFilme idFun senha idFilme nome descricao categoria precoPorDia = do
        if validaFuncionario idFun senha then do
            BD.saveFilmeJSON idFilme nome descricao categoria (read precoPorDia)
            return "Cadastro realizado"
        else
            return "Cadastro falhou"
    
    excluirFilme :: String -> String -> String -> String
    excluirFilme id idFun senha =  do
        if validaFuncionario idFun senha then do
            removeFilmeByID id (getFilmeJSON "DataBase/Filme.json")
            "Remoção feita com sucesso"
        else "Não foi possivel realizar ação"
    
    cadastrarJogo :: String ->  String -> String -> String ->  String -> String -> String -> IO String
    cadastrarJogo idFun senha idJogo nome descricao categoria precoPorDia = do
        if validaFuncionario idFun senha then do
            BD.saveJogoJSON idJogo nome descricao categoria (read precoPorDia)
            return "Cadastro realizado"
        else
            return "Cadastro falhou"
    
    excluirJogo :: String -> String -> String -> String
    excluirJogo id idFun senha =  do
        if validaFuncionario idFun senha then do
            removeJogoByID id (getJogoJSON "DataBase/Jogo.json")
            "Remoção feita com sucesso"
        else "Não foi possivel realizar ação"
    
    organizaListagem :: Show t => [t] -> String
    organizaListagem [] = ""
    organizaListagem (x:xs) = show x ++ "\n" ++ organizaListagem xs

    validaFuncionario:: String -> String -> Bool
    validaFuncionario id senha = do
        let funcionarios = getFuncionarioJSON "DataBase/Funcionario.json"
            funcionario = getFuncionarioByID id funcionarios
        Models.Funcionario.identificador funcionario /= "-1" && senha == "12988"