# purescript-react-basic-router

[PureScript React Basic](https://pursuit.purescript.org/packages/purescript-react-basic/)
 wrapper for [React Router web](https://reactrouter.com/web/).

## Cross Compass fork

This package was forked and extended from https://github.com/KSF-Media/purescript-react-basic-router

The package is incomplete. It contains the features
which we needed to embed PureScript React Basic components in a TypeScript
web application which is routed by
[@types/react-router-dom](https://www.npmjs.com/package/@types/react-router-dom).


# Usage

Suppose we have this nonsense redirecting TypeScript React component `MyComponent` which
uses the `history` and `match` fields of
[`RouteComponentProps`](https://reactrouter.com/web/api/Route/route-props):

```typescript
export interface I_MyProps {
  prop1: number;
  callback: (count: number, flag: string) => void;
}
type Props = I_MyProps & RouteComponentProps<{ param1: number; paramUrl: string }>;

export MyComponent = (props: Props) => {
  const { param1, paramUrl } = props.match.params;
  useEffect((param1) => {
    if (param1 > 0) {
      props.history.push(paramUrl, null);
    }
    else {
      props.callback(param1, paramUrl);
    }
  });
  ...
```

Then this PureScript React Basic Hooks `MyComponent` will have an API
compatible with TypeScript `MyComponent`, and can be dropped
into the TypeScript program to replace the TypeScript `MyComponent`:

```purescript
type I_MyProps r =
  ( prop1 :: Int
  , callback :: EffectFn2 Int String Unit
  | r
  )
type Props = Record (I_MyProps (RouteComponentProps ()))

MyComponent :: ReactComponent Props
MyComponent = unsafePerformEffect $ reactComponent "MyComponent" $ \props -> React.do
  let param1 = fromRight $ runExcept $ props.match.params # readInt <=< readProp "param1"
  let paramUrl = fromRight $ runExcept $ props.match.params # readString <=< readProp "paramUrl"
  useEffect param1 $
    if (param1 > 0)
      then push props.history paramUrl (null :: Nullable Foreign)
      else runEffectFn2 props.callback param1 paramUrl
  ...
```