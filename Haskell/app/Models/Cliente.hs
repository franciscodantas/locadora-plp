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
    } deriving (Generic,Eq)

    instance Show Cliente where
        show :: Cliente -> String
        show (Cliente identificador nome carrinho historico) = "Nome: " ++ nome ++ "- " ++ identificador ++ " - realizou " ++ show (length historico) ++ " compra(as)"
    
    getCompras :: Cliente -> [Compra]
    getCompras cliente = historico cliente
