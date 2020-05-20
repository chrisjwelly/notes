To learn how to make API requests, refer to these links: [official](https://reactnative.dev/docs/network#using-fetch), and by [TutorialsPoint](https://www.tutorialspoint.com/react_native/react_native_http.htm).

I personally used the TutorialsPoint one as I could simply re-use the code:

```js
// Don't copy wholesale yet. Read on for a potential problem with this:
class XXX extends Component {
  state = {
    data: ''
  }
  componentDidMount = () => {
    fetch('https://jsonplaceholder.typicode.com/posts/1', {
        method: 'GET'
    })
    .then((response) => response.json())
    .then((responseJson) => {
        console.log(responseJson);
        this.setState({
          data: responseJson
        })
    })
    .catch((error) => {
        console.error(error);
    });
  }

  render() {
    return (
      // some calls to this.state.data
      ...
    );
  }
}
```

However, this was problematic as in the lifecycle, `render` is called before `componentDidMount`. So the first call to `render` would have an undefined `this.state.data`.

A quick solution I got by watching this [video](https://www.youtube.com/watch?v=u1JQwaIds7A) is to add an `isLoading` state initialised with `true` and set to `false` after you fetch some data in `componentDidMount`. You might want to use the `ActivityIndicator` component to show a spinning loading screen.

Essentially you will include an if-else statement where the predicate is the `isLoading` state. In the first call to `render`, we haven't fetched data yet, so we will show the `ActivityIndicator`. After we finish the call to `componentDidMount`, there is a change in state, and this will trigger another call to `render`, but this time our `isLoading` would have been set to `false` (because we will set it as such inside `componentDidMount`). So we safely run the code while having `this.state.data` properly initialised.
