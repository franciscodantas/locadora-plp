{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE InstanceSigs #-}

module Models.Produto where
    import GHC.Generics

    data Produto = Produto {
        id:: String,
        idProduto:: String
    } deriving (Show, Generic)