module Functions.FuncionarioFunctions where
    import DataBase.GerenciadorBD as BD
    import Models.Filme
    import Models.Funcionario
    import Models.Cliente

    {- Lista os filmes do sistema -}
    listarFilmes:: String
    listarFilmes = organizaListagem (BD.getFilmeJSON "DataBase/Filme.json")

    {- Lista as series do sistema do sistema -}
    listarSeries:: String
    listarSeries = organizaListagem (BD.getSerieJSON "DataBase/Serie.json")

    {- Lista os jogos do sistema -}
    listarJogos:: String
    listarJogos = organizaListagem (BD.getJogoJSON "DataBase/Jogo.json")

    {- Lista os clientes do sistema -}
    listarClientes:: String
    listarClientes = organizaListagem (BD.getClienteJSON "DataBase/Cliente.json")

    {- cadastra um cliente no sistema -}
    cadastrarCliente :: String -> String -> String -> String -> IO String
    cadastrarCliente nome idCliente idFun senha = do
        if validaFuncionario idFun senha then do
            BD.saveClienteJSON idCliente nome
            return (show (BD.getClienteByID idCliente (getClienteJSON "DataBase/Cliente.json")))
        else return "Cadastro falhou!"
    
    {- Faz a remoção do cliente no sistema -}
    excluirCliente :: String -> String -> String -> String
    excluirCliente id idFun senha=  do
        if validaFuncionario idFun senha then do
            removeClienteByID id (getClienteJSON "DataBase/Cliente.json")
            "Remoção feita com sucesso"
        else "Não foi possivel realizar ação"

    {- Lista o historico de um determinado cliente -}
    exibirHistorico :: String -> String
    exibirHistorico id = do
        let cliente = BD.getClienteByID id (getClienteJSON "DataBase/Cliente.json")
        "Historico do cliente: " ++ organizaListagem (Models.Cliente.historico cliente)

    {- cadastra uma serie no sistema -}
    cadastrarSerie :: String ->  String -> String -> String ->  String -> String -> String -> IO String
    cadastrarSerie idFun senha idSerie nome descricao categoria precoPorDia = do
        if validaFuncionario idFun senha then do
            BD.saveSerieJSON idSerie nome descricao categoria (read precoPorDia)
            return "Cadastro realizado"
        else
            return "Cadastro falhou"
    
     {- exclui uma serie do  sistema -}
    excluirSerie :: String -> String -> String -> String
    excluirSerie id idFun senha =  do
        if validaFuncionario idFun senha then do
            removeSerieByID id (getSerieJSON "DataBase/Serie.json")
            "Remoção feita com sucesso"
        else "Não foi possivel realizar ação"

    {- cadastra um filme no sistema -}
    cadastrarFilme :: String ->  String -> String -> String ->  String -> String -> String -> IO String
    cadastrarFilme idFun senha idFilme nome descricao categoria precoPorDia = do
        if validaFuncionario idFun senha then do
            BD.saveFilmeJSON idFilme nome descricao categoria (read precoPorDia)
            return "Cadastro realizado"
        else
            return "Cadastro falhou"
    {- exclui um filme sistema -}
    excluirFilme :: String -> String -> String -> String
    excluirFilme id idFun senha =  do
        if validaFuncionario idFun senha then do
            removeFilmeByID id (getFilmeJSON "DataBase/Filme.json")
            "Remoção feita com sucesso"
        else "Não foi possivel realizar ação"
    
    {- cadastra um jogo no sistema -}
    cadastrarJogo :: String ->  String -> String -> String ->  String -> String -> String -> IO String
    cadastrarJogo idFun senha idJogo nome descricao categoria precoPorDia = do
        if validaFuncionario idFun senha then do
            BD.saveJogoJSON idJogo nome descricao categoria (read precoPorDia)
            return "Cadastro realizado"
        else
            return "Cadastro falhou"

    {- exclui um jogo do sistema -}
    excluirJogo :: String -> String -> String -> String
    excluirJogo id idFun senha =  do
        if validaFuncionario idFun senha then do
            removeJogoByID id (getJogoJSON "DataBase/Jogo.json")
            "Remoção feita com sucesso"
        else "Não foi possivel realizar ação"
    
     {- faz a organização das lista em uma string por linha usando a sua
        representação em string -}
    organizaListagem :: Show t => [t] -> String
    organizaListagem [] = ""
    organizaListagem (x:xs) = show x ++ "\n" ++ organizaListagem xs

     {- Faz a validação do funcionário, usando seu id e uma senha padrão
        para representar uma camada de segurança do sitesma -}
    validaFuncionario:: String -> String -> Bool
    validaFuncionario id senha = do
        let funcionarios = getFuncionarioJSON "DataBase/Funcionario.json"
            funcionario = getFuncionarioByID id funcionarios
        Models.Funcionario.identificador funcionario /= "-1" && senha == "12988"

