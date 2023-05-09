<<<<<<< HEAD:Models/Gerente.hs
module Models.Gerente where
    import GHC.Generics
    
    data Gerente = Gerente {
        identificador :: String,
        nome:: String
    } deriving (Show, Generic)
=======
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE InstanceSigs #-}

module Models.Gerente where
    import GHC.Generics
    
    data Gerente = Gerente {
        identificador :: String,
        nome:: String
    } deriving (Show, Generic,Eq)
>>>>>>> 35f7eb47a26b833aa34770b747893458a8b42a11:app/Models/Gerente.hs
