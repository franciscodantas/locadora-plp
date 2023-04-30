module Functions.FuncionarioFunctions where
    import DataBase.GerenciadorBD as BD
    import Models.Filme
    import Data.Time.Clock.POSIX (getPOSIXTime)
    
    gerarIdCliente :: IO String
    gerarIdCliente = do
        timestamp <- getPOSIXTime
        let idInt = round $ timestamp / 100000
        return $ show idInt
    
    listarFilmes:: String
    listarFilmes = organizaListagem (BD.getFilmeJSON "DataBase/Filme.json")

    listarSeries:: String
    listarSeries = organizaListagem (BD.getSerieJSON "DataBase/Serie.json")

    listarJogos:: String
    listarJogos = organizaListagem (BD.getJogoJSON "DataBase/Jogo.json")

    cadastrarCliente :: String -> IO String
    cadastrarCliente nome = do
        id <- gerarIdCliente
        BD.saveClienteJSON id nome
        return (show (BD.getClienteByID id (getClienteJSON "DataBase/Serie.json")))

    organizaListagem :: Show t => [t] -> String
    organizaListagem [] = ""
    organizaListagem (x:xs) = show x ++ "\n" ++ organizaListagem xs