# Using Gleam in your Phoenix Hooks
[Phoenix](https://www.phoenixframework.org/) uses [Elixir](https://elixir-lang.org/), but when dealing with [LiveView Hooks](https://hexdocs.pm/phoenix_live_view/js-interop.html) it requires JavaScript. But how about using another functional language in that area?. 

Presenting [Gleam](https://gleam.run/)

The power of a type system, the expressiveness of functional programming, with a familiar and modern syntax. 

Gleam comes with compiler, build tool, formatter, editor integrations, and package manager all built in, so creating a Gleam project is just running `gleam new`. 


In my humble opinion, **Gleam is the perfect alternative to Typescript!** if you want all the goodies of a functional language and a type system for your Phoenix Hooks.

## Installation

Be sure the `gleam` binary is in your _$PATH_. You can refer to the [Installation Guide](https://gleam.run/getting-started/installing/) for more details.

```sh
$ gleam --version
gleam 0.26.1
```
## GleamPhx Project

This will be an small and simple project (Phoenix 1.6) with no ecto. Just a LiveView with a simple hook for demostration.

### Creating our Project 

First let's start with a project named `gleamphx` with no database requirement (just to be slim).

```sh
$ mix phx.new . --app gleamphx --no-ecto
```

### Creating our Gleam Project

Let's go to `assets/` directory and create a new `Gleam Project` named `hooks`.

```sh
$ cd assets
$ gleam new hooks
$ cd hooks
```

Now we edit `gleam.toml` so we can setup the `Javascript` target.

```toml
name = "hooks"
version = "0.1.0"
description = "A Gleam project"
# ...
target = "javascript"

[javascript]
# Generate TypeScript .d.ts files
typescript_declarations = true

# Which JavaScript runtime to use with `gleam run`, `gleam test` etc.
runtime = "node" # or "deno"
```

#### JavaScript Code

This will be the main Javascript file that will export all of our hooks. This file will be used in `app.js` later.

```sh
$ touch assets/hooks/index.js
```

```js
import * as Hello from "./build/dev/javascript/hooks/hello.mjs";

export default { Hello };
```

#### Gleam Code

Inside the `src/` directory we will create our hooks.
Lets create `hello.gleam` hook.

```gleam
import gleam/io

pub fn mounted() {
  io.println("Hello from Gleam!")
}
```

### Phoenix Config

Ok we are ready with our hook. Lets configure Phoenix!.

#### assets/app.js

First lets edit `assets/app.js` to import our hooks.

```js
// ...
import Hooks from "../hooks"
// ...

let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks, params: {_csrf_token: csrfToken}})

```

#### mix.exs

Let's add a new build step in `assets.deploy` task.

```elixir
"gleam.build": [
        "cmd cd assets/hooks && rm -rf build && gleam build"
      ]
```

This task only builds the gleam code to the target javascript files.

```elixir
defp aliases do
    [
      "gleam.build": [
        "cmd cd assets/hooks && rm -rf build && gleam build"
      ],
      setup: ["deps.get"],
      "assets.deploy": [
        "gleam.build",
        "esbuild default --minify",
        "phx.digest"]
    ]
  end
```

We add the task to the `assets.deploy` pipeline.

#### lib/gleamphx_web/router.ex

Ok now we just have to test. Let's create a simple live view with a div that is Hooked to the `Hello` function in Gleam.

First we configure our router

```elixir
scope "/", GleamphxWeb do
    pipe_through :browser

    live "/", Live.Example, :index
  end
```

#### lib/gleamphx_web/live/example.ex

And then create our module

```elixir
defmodule GleamphxWeb.Live.Example do
  use GleamphxWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
      <div id="ExampleGleamHook" phx-hook="Hello">Example Hooked Component</div>
    """
  end
end
```

If everything went OK then after `mix phx.server` you will see in the browser console a message similar to this.


![GleamPHX](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/n4349x25h1veqhchfxgd.png)

## Routes

- "/": Example Gleam code using console.log
- "/video": Example Gleam code interacting with the `MediaStream` api and `this.el`;

## Next Steps?

TODO: Maybe configure autoreload on change of gleam files.

You can check out the example project here https://github.com/ElixirCL/gleamphx