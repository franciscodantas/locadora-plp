{-# LANGUAGE DeriveGeneric #-}
module Models.Compra where

    import GHC.Generics

    data Compra = Compra {
        id:: String,
        idCliente:: String,
        nomeCliente:: String,
        idProduto:: String,
        nomeProduto:: String,
        dataCompra:: String
    } deriving (Generic)

    instance Show Compra where
        show (Compra id idCliente nomeCliente idProduto nomeProduto dataCompra) = nomeCliente ++ " comprou " ++ nomeProduto ++ " no dia " ++ dataCompra