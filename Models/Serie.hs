<<<<<<< HEAD:Models/Serie.hs
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
=======
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE InstanceSigs #-}

module Models.Serie where
    import GHC.Generics

    data Serie = Serie {
        identificador :: String,
        nome:: String,        
        descricao:: String,
        categoria:: String,
        qtdAlugueis:: Int,
        precoPorDia:: Float
    } deriving (Generic,Eq)

    instance Show Serie where
        show :: Serie -> String
        show (Serie identificador nome descricao categoria qtdAlugueis precoPorDia) = "Nome: " ++ nome ++ "\n(" ++ filter (\c -> c /= '/' && c /= '\'') descricao ++ ")\n" ++ "Valor por dia: R$" ++ show precoPorDia
>>>>>>> 35f7eb47a26b833aa34770b747893458a8b42a11:app/Models/Serie.hs
