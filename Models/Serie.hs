module Models.Serie where
    import GHC.Generics

    data Serie = Serie {
        identificador :: String,
        nome:: String,        
        descricao:: String,
        categoria:: String,
        qtdAlugueis:: Int,
        precoPorDia:: Float
    } deriving (Generic)

    instance Show Serie where
        show :: Serie -> String
        show (Serie identificador nome descricao categoria qtdAlugueis precoPorDia) = "Nome: " ++ nome ++ "\n(" ++ filter (\c -> c /= '/' && c /= '\'') descricao ++ ")\n" ++ "Valor por dia: R$" ++ show precoPorDia
