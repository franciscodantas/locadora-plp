<<<<<<< HEAD:Models/Produto.hs
module Models.Produto where
    import GHC.Generics

    data Produto = Produto {
        id:: String,
        idProduto:: String
    } deriving (Show, Generic)
=======
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE InstanceSigs #-}

module Models.Produto where
    import GHC.Generics

    data Produto = Produto {
        id:: String,
        idProduto:: String
    } deriving (Show, Generic,Eq)
>>>>>>> 35f7eb47a26b833aa34770b747893458a8b42a11:app/Models/Produto.hs
