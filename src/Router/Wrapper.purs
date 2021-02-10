module React.Basic.Router.Wrapper where

import Prelude

import Data.Newtype (unwrap)
import Data.Nullable (null, toNullable)
import Effect (Effect)
import Effect.Uncurried (runEffectFn2)
import React.Basic (element, JSX)
import React.Basic.Router.Foreign as Foreign
import React.Basic.Router.Types (History, LinkProps, RedirectProps, RouteProps, SwitchProps)

-- | Render some UI when its path matches the current URL.
-- |
-- | https://reactrouter.com/web/api/Route
route :: forall props. RouteProps props -> JSX
route { exact, path, render } = element Foreign.route { exact: exact, path: toNullable path, render }

-- | Renders the first child `route` or `redirect` that matches the location.
-- |
-- | https://reactrouter.com/web/api/Switch
switch :: SwitchProps -> JSX
switch = element Foreign.switch

-- | Provides declarative, accessible navigation around your application.
-- |
-- | https://reactrouter.com/web/api/Link
link :: forall props state. LinkProps props state -> JSX
link = element Foreign.link

-- | Rendering a `redirect` will navigate to a new location.
-- |
-- | https://reactrouter.com/web/api/Redirect
redirect :: forall state. RedirectProps state -> JSX
redirect = element Foreign.redirect

-- | Call `history.push()` with a `null` state.
--
-- | https://reactrouter.com/web/api/history
push :: forall state. History state -> String -> Effect Unit
push history path = runEffectFn2 (unwrap history).push path null

-- TODO useHistory
-- Would require a Hooks dependency?
-- https://reactrouter.com/web/api/Hooks/usehistory