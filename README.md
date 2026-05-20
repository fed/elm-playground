# elm-playground

## Project structure

- `src/`: Contains the Elm source code files.
  - [`Main.elm`](src/Main.elm): The main application entry point (configured to initialise and wire up the `UserProfileApp` stateful container).
  - [`UserProfileApp.elm`](src/UserProfileApp.elm): The stateful app container. It manages asynchronous data fetching from GitHub, follower state transitions, and mounts the layout.
  - [`UserProfileCard.elm`](src/UserProfileCard.elm): A stateless presentation UI component that renders the user card (avatar, handle, name).
  - [`Counter.elm`](src/Counter.elm): A counter application using a `Browser.sandbox`. Features `+` and `-` buttons that increment/decrement a numeric state.
  - [`Button.elm`](src/Button.elm): A button component that tracks its own click count.
  - [`ShoppingList.elm`](src/ShoppingList.elm): Renders a list of items and applies conditional styling dynamically based on the item types.
  - [`Utils.elm`](src/Utils.elm): A utility module exposing a simple string-formatting `greet` function.
- [`index.html`](index.html): The HTML entry point, it embeds and runs the compiled Elm application (`app.js`) inside a `<div id="app">`.
- [`elm.json`](elm.json): The Elm configuration file defining all the dependencies.
- [`app.js`](app.js): The compiled output JavaScript of the Elm application. Not commited.

## Building process

To run and experiment with these examples, you first need to have Elm installed on your system. You can install it globally using:

```bash
npm install -g elm
```

### Option 1: Run interactively with `elm reactor`

`elm reactor` is the built-in development server that lets you run and browse all Elm files in the browser.

1. Start the reactor from the root of this project:

```bash
elm reactor
```

2. Navigate to http://localhost:8000

3. Click on any file in the `src/` folder (such as `Counter.elm`) to run it immediately with live rendering

### Option 2: Compile to `app.js` and serve via HTML

To view a specific Elm file loaded inside the `index.html` scaffolding:

1. Compile your Elm file of choice to the target output `app.js`. For example, to run the Counter app inside `index.html`:

```bash
elm make src/Counter.elm --output=app.js
```

_(or compile `Main.elm` once you have implement a matching module)._

2. Run `open index.html` to open it in your browser.

## Tailwind integration

This project uses Tailwind CSS v4 Play CDN (`@tailwindcss/browser@4`) loaded in the `<head>` of the `index.html`. There's no tooling or setup requirement, you don't need any npm packages or bundlers to build, compile, or watch CSS files. The browser compiles utility classes on the fly in real time.
