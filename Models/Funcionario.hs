<<<<<<< HEAD:Models/Funcionario.hs
module Models.Funcionario where
    import GHC.Generics
    
    
    data Funcionario = Funcionario {
        identificador :: String,
        nome:: String
    } deriving (Show, Generic, Read)

    

=======
{-# LANGUAGE DeriveGeneric #-}
module Models.Funcionario where

    import GHC.Generics
    
    
    data Funcionario = Funcionario {
        identificador :: String,
        nome:: String
    } deriving (Generic, Read,Eq)

    instance Show Funcionario where
        show (Funcionario identificador nome) = "Nome: " ++ nome ++ " - (" ++ identificador ++")"
>>>>>>> 35f7eb47a26b833aa34770b747893458a8b42a11:app/Models/Funcionario.hs
