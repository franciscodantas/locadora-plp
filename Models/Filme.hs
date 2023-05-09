<<<<<<< HEAD:Models/Filme.hs
module Models.Filme where
    import GHC.Generics
    
    data Filme = Filme {
        identificador :: String,
        nome:: String,        
        descricao:: String,
        categoria:: String,
        qtdAlugueis:: Int,
        precoPorDia:: Float
    } deriving (Generic)

    instance Show Filme where
        show :: Filme -> String
=======
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE InstanceSigs #-}

module Models.Filme where
    import GHC.Generics
    
    data Filme = Filme {
        identificador :: String,
        nome:: String,        
        descricao:: String,
        categoria:: String,
        qtdAlugueis:: Int,
        precoPorDia:: Float
    } deriving (Generic,Eq)

    instance Show Filme where
        show :: Filme -> String
>>>>>>> 35f7eb47a26b833aa34770b747893458a8b42a11:app/Models/Filme.hs
        show (Filme identificador nome descricao categoria qtdAlugueis precoPorDia) = "Nome: " ++ nome ++ "\n(" ++ filter (\c -> c /= '/' && c /= '\'') descricao ++ ")\n" ++ "Valor por dia: R$" ++ show precoPorDia