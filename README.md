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

Suppose we have a TypeScript React component `MyComponent` which expects the following
type for `props`:

```typescript
export interface I_MyProps {
  prop1: number;
  callback: (count: number, flag: string) => void;
}
type Props = I_MyProps & RouteComponentProps<{ param1: number; param2: string }>;

export MyComponent = (props: Props) => {
    const { param2 } = match.params;
```

We want to replace `MyComponent` with a PureScript React Basic component.

The `props` type for our PureScript React Basic component `MyComponent` will be:

```purescript
type I_MyProps r =
  ( prop1 :: Int
  , callback: EffectFn2 Int String Unit
  | r
  )

type Props = Record (I_MyProps (RouteComponentProps ()))

MyComponent :: ReactComponent Props
MyComponent = unsafePerformEffect $ reactComponent "MyComponent" $ \props -> React.do
  let param2Maybe = hush $ runExcept $ props.match.params # readString <=< readProp "param2"
```