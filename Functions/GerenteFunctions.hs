module Functions.GerenteFunctions where
    import DataBase.GerenciadorBD as BD
    import Models.Filme
    import Models.Funcionario
    import Models.Cliente
    import Models.Gerente



    {- cadastra um Funcionario no sistema -}
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

                                    

    {- Estatisticas de vendas   

    exibirEstatisticas :: String -> IO String
    exibirEstatisticas id = do
        let Funcionario = BD.getFuncionarioByID id (getFuncionarioJSON "DataBase/Funcionario.json")
        
    -}
