{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE InstanceSigs #-}

module Models.Funcionario where
    import GHC.Generics
    
    
    data Funcionario = Funcionario {
        identificador :: String,
        nome:: String
    } deriving (Show, Generic, Read)

    

