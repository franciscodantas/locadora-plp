{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE InstanceSigs #-}

module Models.Gerente where
    import GHC.Generics
    
    data Gerente = Gerente {
        identificador :: String,
        nome:: String
    } deriving (Show, Generic,Eq)
