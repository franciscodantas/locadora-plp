{-# LANGUAGE DeriveGeneric #-}
module Models.Funcionario where

    import GHC.Generics
    
    
    data Funcionario = Funcionario {
        identificador :: String,
        nome:: String
    } deriving (Generic, Read,Eq)

    instance Show Funcionario where
        show (Funcionario identificador nome) = "Nome: " ++ nome ++ " - (" ++ identificador ++")"