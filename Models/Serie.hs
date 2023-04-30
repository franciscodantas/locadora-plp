module Models.Serie where
    import GHC.Generics

    data Serie = Serie {
        identificador :: String,
        nome:: String,        
        descricao:: String,
        categoria:: String,
        qtdAlugueis:: Int,
        precoPorDia:: Float
    } deriving (Show, Generic)
