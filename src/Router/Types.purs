module React.Basic.Router.Types where

import Prelude

import Data.Maybe (Maybe)
import Data.Newtype (class Newtype)
import Data.Nullable (Nullable)
import Effect.Uncurried (EffectFn2)
import Foreign (Foreign)
import React.Basic.Classic (JSX)

type JSRouterProps a = { location :: Location a }

type Match =
  { params :: Foreign
  , isExact :: Boolean
  , path :: String
  , url :: String
  }

-- TODO This would be a better type for the Match?
-- type Match params =
--   { params :: params
--   , isExact :: Boolean
--   , path :: String
--   , url :: String
--   }

type Location state =
  { key :: String
  , pathname :: String
  , search :: String
  , hash :: String
  , state :: Nullable state
  }

type BaseRedirectProps state =
  ( to   :: To state
  , from :: String
  , push :: Boolean
  )

type RedirectProps state = Record (BaseRedirectProps state)

type DelayedRedirectProps state = { delay :: Number | BaseRedirectProps state }

type To state_ =
  { pathname :: String
  , state :: state_
  }

type SwitchProps = { children :: Array JSX }

type RouteProps jsProps =
  { exact :: Boolean
  , path :: Maybe String
  , render :: jsProps -> JSX
  }

type LinkProps props state = { to :: To state, children :: Array JSX, className :: String }

-- | Compatible with @types/react-router RouteComponentProps
-- |
-- | https://reactrouter.com/web/api/Route/route-props
type RouteComponentProps r =
  ( history :: History Foreign -- https://reactrouter.com/web/api/history
  , location :: Location Foreign
  , match :: Match
  | r
  )


-- | This is a wrapper type for
-- | https://reactrouter.com/web/api/history
-- |
-- | You cannot make a `History`, you can only receive it from a component
-- | called by the `RouteComponentProps` of a component called by `withRouter`.
newtype History state = History
-- Should correspond to
--
-- JavaScript:
-- https://github.com/ReactTraining/history/blob/28c89f4091ae9e1b0001341ea60c629674e83627/packages/history/index.ts#L221
--
-- TypeScript:
-- https://github.com/DefinitelyTyped/DefinitelyTyped/blob/03f6cda7661bb87bde7dbf3968c4549cf12c043f/types/history/index.d.ts#L11
  { push :: EffectFn2 String (Nullable state) Unit
  }
derive instance newtypeHistory :: Newtype (History state) _

