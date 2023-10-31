# The Ultimate Turbo Modal for Rails (UTMR)

There are MANY Turbo/Hotwire/Stimulus modal dialog implementations out there, and it seems like everyone goes about it a different way. However, as you may have learned the hard way, the majority fall short in different, often subtle ways. They generally cover the basics quite well, but do not check all the boxes for real-world use.

UTMR aims to be the be-all and end-all of Turbo Modals. I believe it is the best implementation and checks all the boxes. It is feature-rich, yet extremely easy to use.

Under the hood, it uses [Stimulus](https://stimulus.hotwired.dev), [Turbo](https://turbo.hotwired.dev/), [el-transition](https://github.com/mmccall10/el-transition), and optionally [Idiomorph](https://github.com/bigskysoftware/idiomorph).

It currently ships in a single flavor: Tailwind CSS. It is easy to create your own to suit your needs such as vanilla CSS or any other CSS framework you may prefer. See `lib/ultimate_turbo_modal/flavors/tailwind.rb` for the Tailwind code.


&nbsp;
&nbsp;
## Features and capabilities

- Extremely easy to use
- Fully responsive
- Does not break if a user navigates directly to a page that is usually shown in a modal
- Opening a modal in a new browser tab (ie: right click) gracefully degrades without having to code a modal and non-modal version of the same page
- Automatically handles URL history (ie: pushState) for shareable URLs
- pushState URL optionally overrideable
- Seamless support for multi-page navigation within the modal
- Seamless support for forms with validations
- Seamless support for Rails flash messages
- Enter/leave animation (fade in/out)
- Support for long, scrollable modals
- Properly locks the background page when scrolling a long modal
- Click outside the modal to dismiss
- Keyboard control; ESC to dismiss
- Automatic (or not) close button


&nbsp;
&nbsp;
## Demo

A demo application can be found at https://github.com/cmer/ultimate_turbo_modal-demo. A video demo can be seen here: [https://youtu.be/eG5uWTH74NA](https://youtu.be/eG5uWTH74NA)


&nbsp;
&nbsp;
## Installation

1. Install the gem and add to the application's Gemfile by executing:

    $ bundle add ultimate_turbo_modal

2. Install the npm package:

    $ yarn add ultimate_turbo_modal

    - or -

    $ bin/rails importmaps pin ultimate_turbo_modal

3. Add the following as the first element in the `body` tag of `views/layouts/application.html.erb`:

```erb
<%= turbo_frame_tag "modal" %>
``````

4. Register the Stimulus controller in `app/javascript/controllers/index.js` adding the following lines at the end.

```js
import setupUltimateTurboModal from "ultimate_turbo_modal";
setupUltimateTurboModal(application);
```

5. Optionally (but recommended), configure UTMR to use Idiomorph. See below for details.

&nbsp;
&nbsp;
## Usage

1. Wrap your view inside a `modal` block as follow:

```erb
<%= modal do %>
  Hello World!
<% end %>
```

2. Link to your view by specifying `modal` as the target Turbo Frame:

```erb
<%= link_to "Open Modal", "/hello_world", data: { turbo_frame: "modal" } %>
```

Clicking on the link will automatically open the content of the view inside a modal. If you open the link in a new tab, it will render normally outside of the modal. Nothing to do!

If you need to do something a little bit more advanced when the view is shown outside of a modal, you can use the `#inside_modal?` method as such:

```erb
<% if inside_modal? %>
  <h1 class="text-2xl mb-8">Hello from modal</h1>
<% else %>
  <h1 class="text-2xl mb-8">Hello from a normal page render</h1>
<% end %>
```

&nbsp;
&nbsp;
## Options

### `padding`, default: `true`

Adds padding inside the modal.

### `close_button`, default: `true`

Shows or hide a close button (X) at the top right of the modal.

### `advance_history`, default: `true`

When opening the modal, the URL in the URL bar will change to the URL of the view being shown in the modal. The Back button dismisses the modal and navigates back.

### `advance_history_url`, default: `nil`

Override for the URL being shown in the URL bar when `advance_history` is enabled. Default is the actual URL.


### Example usage with options

```erb
<%= modal(padding: true, close_button: false, advance_history_url: "/foo/bar") do %>
  Hello World!
<% end %>
```

## Installing & Configuring Idiomorph

// Morph Turbo Frame rendering to allow navigation within Turbo Frames
// without having to teardown the entire frame. This is needed to prevent
// the leaving and entering animations from repeating when navigating
// within the modal. You could optionally not use the code below if you
// do not intend to allow navigation within the modal.
//
// Note that Turbo 8 will include Idiomorph by default.
//
// In the meantime, add `<script src="https://unpkg.com/idiomorph"></script>`
// to your HTML <head>.
addEventListener("turbo:before-frame-render", (event) => {
  event.detail.render = (currentElement, newElement) => {
    Idiomorph.morph(currentElement, newElement, {
      morphstyle: 'innerHTML'
    })
  }
})


&nbsp;
&nbsp;
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cmer/ultimate_turbo_modal.

&nbsp;
&nbsp;
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
