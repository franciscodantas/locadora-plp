module Functions.GerenteFunctions (
    cadastraFunc,
    exibirFuncionario,
    exibirFuncionarios
) where

    import DataBase.GerenciadorBD as Bd
    import Models.Funcionario

    cadastraFunc :: String -> String -> String -> IO String
    cadastraFunc id nome senha = do
        if validaGerente senha then do
            Bd.saveFuncionarioJSON id nome
            return (show(Bd.getFuncionarioByID id (Bd.getFuncionarioJSON "DataBase/Funcionario.json")))
        else
            return "Cadastro falhou!"
    
    exibirFuncionario :: String -> String
    exibirFuncionario id = do
        let funcionario = show(Bd.getFuncionarioByID id (Bd.getFuncionarioJSON "DataBase/Funcionario.json"))
        if funcionario == "Nome:  - (-1)" then "Funcionario não existe" else show(funcionario)

    va :: String
    va = "Vá se fuder"

    organizaListagem :: Show t => [t] -> String
    organizaListagem [] = ""
    organizaListagem (x:xs) = show x ++ "\n" ++ organizaListagem xs

    validaGerente:: String -> Bool
    validaGerente senha = senha == "01110"