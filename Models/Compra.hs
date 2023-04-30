module Models.Compra where
    import GHC.Generics
    
    data Compra = Compra {
        id:: String,
        idCliente:: String,
        idProduto:: String,
        dataCompra:: String
    } deriving (Show, Generic)