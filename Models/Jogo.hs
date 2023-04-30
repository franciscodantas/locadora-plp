module Models.Jogo where
    import GHC.Generics

    data Jogo = Jogo {
        identificador :: String,
        nome:: String,        
        descricao:: String,
        categoria:: String,
        qtdAlugueis:: Int,
        precoPorDia:: Float
    } deriving (Show, Generic)
