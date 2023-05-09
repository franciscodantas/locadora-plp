<<<<<<< HEAD:Models/Compra.hs
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
        show :: Compra -> String
=======
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE InstanceSigs #-}

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

    instance Eq Compra where
        c1 == c2 = idProduto c1 == idProduto c2

    instance Show Compra where
>>>>>>> 35f7eb47a26b833aa34770b747893458a8b42a11:app/Models/Compra.hs
        show (Compra id idCliente nomeCliente idProduto nomeProduto dataCompra) = nomeCliente ++ " comprou " ++ nomeProduto ++ " no dia " ++ dataCompra