
{-# LANGUAGE JavaScriptFFI, CPP, OverloadedStrings #-}

module Web.VirtualDom.Html.Events
    ( Event
    , stopPropagation
    , stopImmediatePropagation
    , preventDefault
    , onclick
    , value
    ) where

import GHCJS.Types
import Data.JSString

import Web.VirtualDom.Html (Property)
import qualified Web.VirtualDom as VirtualDom


newtype Event = Event JSVal

foreign import javascript unsafe "$1.stopPropagation()"
  stopPropagation :: Event -> IO ()
-- stopPropagation = er $ \e -> [jsu_| `e.stopPropagation(); |]
-- {-# INLINE stopPropagation #-}

foreign import javascript unsafe "$1.stopImmediatePropagation()"
  stopImmediatePropagation :: Event -> IO ()
-- stopImmediatePropagation = er $ \e -> [jsu_| `e.stopImmediatePropagation(); |]
-- {-# INLINE stopImmediatePropagation #-}

foreign import javascript unsafe "$1.preventDefault()"
  preventDefault :: Event -> IO ()
-- preventDefault = er $ \e -> [jsu_| `e.preventDefault(); |]
-- {-# INLINE preventDefault #-}

-- ctrlKey :: KeyModEvent_ a => a -> Bool
-- ctrlKey = er $ \e -> [jsu'| `e.ctrlKey |]
-- {-# INLINE ctrlKey #-}
--
-- metaKey :: KeyModEvent_ a => a -> Bool
-- metaKey = er $ \e -> [jsu'| `e.ctrlKey |]
-- {-# INLINE metaKey #-}
--
-- shiftKey :: KeyModEvent_ a => a -> Bool
-- shiftKey = er $ \e -> [jsu'| `e.ctrlKey |]
-- {-# INLINE shiftKey #-}
--
-- key :: KeyboardEvent -> JSString
-- key = er $ \e -> [jsu'| `e.key |]
-- {-# INLINE key #-}
--
-- button :: MouseEvent_ a => a -> Int
-- button = er $ \e -> [jsu'| `e.button |]
-- {-# INLINE button #-}
--
-- buttons :: MouseEvent_ a => a -> Int
-- buttons = er $ \e -> [jsu'| `e.buttons |]
-- {-# INLINE buttons #-}
--
-- deltaX :: WheelEvent -> Double
-- deltaX = er $ \e -> [jsu'| `e.deltaX |]
-- {-# INLINE deltaX #-}
--
-- deltaY :: WheelEvent -> Double
-- deltaY = er $ \e -> [jsu'| `e.deltaY |]
-- {-# INLINE deltaY #-}
--
-- deltaZ :: WheelEvent -> Double
-- deltaZ = er $ \e -> [jsu'| `e.deltaZ |]
-- {-# INLINE deltaZ #-}
--
-- deltaMode :: WheelEvent -> Double
-- deltaMode = er $ \e -> [jsu'| `e.deltaMode |]
-- {-# INLINE deltaMode #-}
--
-- clientX :: MouseEvent -> Int
-- clientX = er $ \e -> [jsu'| `e.clientX|0 |]
-- {-# INLINE clientX #-}
--
-- clientY :: MouseEvent -> Int
-- clientY = er $ \e -> [jsu'| `e.clientY|0 |]
-- {-# INLINE clientY #-}

onclick :: (Event -> IO ()) -> Property
onclick = VirtualDom.on "click" . contramapS (Event)

-- or just Event -> JSString
foreign import javascript unsafe "$1.target.value"
  value :: Event -> JSString


contramapS f k x = k (f x)
