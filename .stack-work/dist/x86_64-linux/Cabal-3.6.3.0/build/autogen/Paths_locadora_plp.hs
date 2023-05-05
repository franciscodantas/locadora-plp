{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_locadora_plp (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/workspaces/locadora-plp/.stack-work/install/x86_64-linux/76609c4f20f7f910a922b802d75f557b1d79b1c00dce2f9bc667c1a791a57345/9.2.7/bin"
libdir     = "/workspaces/locadora-plp/.stack-work/install/x86_64-linux/76609c4f20f7f910a922b802d75f557b1d79b1c00dce2f9bc667c1a791a57345/9.2.7/lib/x86_64-linux-ghc-9.2.7/locadora-plp-0.1.0.0-2YOw4WmvlsBHrK5z3twgps"
dynlibdir  = "/workspaces/locadora-plp/.stack-work/install/x86_64-linux/76609c4f20f7f910a922b802d75f557b1d79b1c00dce2f9bc667c1a791a57345/9.2.7/lib/x86_64-linux-ghc-9.2.7"
datadir    = "/workspaces/locadora-plp/.stack-work/install/x86_64-linux/76609c4f20f7f910a922b802d75f557b1d79b1c00dce2f9bc667c1a791a57345/9.2.7/share/x86_64-linux-ghc-9.2.7/locadora-plp-0.1.0.0"
libexecdir = "/workspaces/locadora-plp/.stack-work/install/x86_64-linux/76609c4f20f7f910a922b802d75f557b1d79b1c00dce2f9bc667c1a791a57345/9.2.7/libexec/x86_64-linux-ghc-9.2.7/locadora-plp-0.1.0.0"
sysconfdir = "/workspaces/locadora-plp/.stack-work/install/x86_64-linux/76609c4f20f7f910a922b802d75f557b1d79b1c00dce2f9bc667c1a791a57345/9.2.7/etc"

getBinDir     = catchIO (getEnv "locadora_plp_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "locadora_plp_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "locadora_plp_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "locadora_plp_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "locadora_plp_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "locadora_plp_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
