module Models.Filme where
    import GHC.Generics
    
    data Filme = Filme {
        identificador :: String,
        nome:: String,        
        descricao:: String,
        categoria:: String,
        qtdAlugueis:: Int,
        precoPorDia:: Float
    } deriving (Show, Generic)