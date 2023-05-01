module Models.Jogo where
    import GHC.Generics

    data Jogo = Jogo {
        identificador :: String,
        nome:: String,        
        descricao:: String,
        categoria:: String,
        qtdAlugueis:: Int,
        precoPorDia:: Float
    } deriving (Generic)

    instance Show Jogo where
        show :: Jogo -> String
        show (Jogo identificador nome descricao categoria qtdAlugueis precoPorDia) = "Nome: " ++ nome ++ "\n(" ++ filter (\c -> c /= '/' && c /= '\'') descricao ++ ")\n" ++ "Valor por dia: R$" ++ show precoPorDia
