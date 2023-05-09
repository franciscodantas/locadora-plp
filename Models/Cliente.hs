{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE InstanceSigs #-}

module Models.Cliente where
    import GHC.Generics
    import Models.Produto as Produto
    import Models.Compra as Compra

    data Cliente = Cliente {
        identificador :: String,
        nome:: String,
        carrinho:: [Produto],
        historico:: [Compra]
    } deriving (Generic)
