# The Ultimate Turbo Modal for Rails (UTMR)

There are MANY Turbo/Hotwire/Stimulus modal dialog implementations out there, and it seems like everyone goes about it a different way. However, as you may have learned the hard way, the majority fall short in different, often subtle ways. They generally cover the basics quite well, but do not check all the boxes for real-world use.

UTMR uses [Tailwind CSS](https://tailwindcss.com), [Stimulus](https://stimulus.hotwired.dev), [Turbo](https://turbo.hotwired.dev/), [Morphdom](https://github.com/patrick-steele-idem/morphdom) and [el-transition](https://github.com/mmccall10/el-transition).

I believe UTMR is the best implementation and checks all the boxes. It is featureful, yet extremely easy to use.

![The Unicat](./public/unicat-sm.jpg "The Unicat")


&nbsp;
&nbsp;
# Features and capabilities

- Extremely easy to use
- Fully responsive
- Does not break if a user navigates directly to a page that is usually shown in a modal
- Opening a modal in a new browser tab (ie: right click) gracefully degrades without having to code a modal and non-modal version of the same page
- Automatically handles URL history (ie: pushState) for shareable URLs
- pushState URL optionally overridable
- Seamless support for multi-page navigation within the modal
- Seamless support for forms with validations
- Seamless support for Rails flash messages
- Enter/leave animation (fade in/out)
- Support for long modals (scrollable)
- Properly locks the background page when scrolling a long modal
- Click outside the modal to dismiss
- Keyboard control; ESC to dismiss
- Automatic (or not) close button


&nbsp;
&nbsp;
# Playing with the demo

```sh
bin/rails db:create db:migrate db:seed
bin/dev
open http://localhost:3000
```

&nbsp;
&nbsp;
# Installation inside your own Rails app

There are a few simple steps involved in getting up and running.

&nbsp;
&nbsp;
## Run the installation script

First, start by running the installation script. You'll be prompted before each step so you know exactly what's going on.

```sh
# Replace path with your own application's Rails root
ruby ./install.rb ~/code/my_project_path
```

PS: If you wish, please review [`install.rb`](https://github.com/cmer/ultimate-turbo-modal/blob/main/install.rb); it's quite easy to follow what it does.

&nbsp;
&nbsp;
## And a few simple manual steps...

There are a few things you should do manually:

1. Add `app/components` to your Tailwind `content` block. The file is at `config/tailwind.config.js`.
2. Add the following code to your Javascript entrypoint. For example, `javascript/application.js`:

```javascript
// Handle frame-missing events gracefully for redirects, like in Turbo 7.2
document.addEventListener("turbo:frame-missing", function (event) {
  if (event.detail.response.redirected) {
    event.preventDefault()
    event.detail.visit(event.detail.response)
  }
})

// Morphdom Turbo Frame rendering to allow navigation within Turbo Frames
// without having to teardown the entire frame. This is needed to prevent
// the leaving and entering animations from repeating when navigating
// within the modal. You could optionally not use the code below if you
// do not intend to allow navigation within the modal.
addEventListener("turbo:before-frame-render", (event) => {
  event.detail.render = (currentElement, newElement) => {
    morphdom(currentElement, newElement, {
      childrenOnly: true,
      onBeforeElUpdated: (fromEl, toEl) => !fromEl.isEqualNode(toEl)
    })
  }
})
```

3. Add the following as the first element in the `body` tag of `views/layouts/application.html.erb`:

```erb
<%= turbo_frame_tag "modal" %>
```

4. A new Stimulus controller named `modal_controller.js` was copied to `app/javascript/controllers`. Make sure your application registers it. This should be done by default.

5. There's no step 5.

&nbsp;
&nbsp;
# Usage

To start, I recommend you look at some examples, such as:

- [`app/views/modal/show.html.erb`](https://github.com/cmer/ultimate-turbo-modal/blob/main/app/views/modal/show.html.erb)
- [`app/views/posts/new.html.erb`](https://github.com/cmer/ultimate-turbo-modal/blob/main/app/views/posts/new.html.erb)
- [`app/views/posts/show.html.erb`](https://github.com/cmer/ultimate-turbo-modal/blob/main/app/views/posts/show.html.erb)
- [`app/views/posts/edit.html.erb`](https://github.com/cmer/ultimate-turbo-modal/blob/main/app/views/posts/edit.html.erb)

In a nutshell, there are two simple steps to get going.

1. Wrap your view inside a block as follow:

```erb
<%= render UI::Modal::Component.new do %>
  Hello World!
<% end %>
```

2. Link to your view by specifying a target Turbo Frame:

```erb
<%= link_to "Open Modal", post_path(@post), data: { turbo_frame: "modal" } %>
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
# Options

## `frame`, default: `true`

Adds padding and a close button inside the modal. The close button can optionally be hidden.

## `close_button`, default: `true`

Shows or hide a close button (X) at the top right of the modal. This option has no effect if `frame` is `false`.

## `advance_history`, default: `true`

When opening the modal, the URL in the URL bar will change to the URL of the view being shown in the modal. The Back button dismisses the modal and navigates back.

## `advance_history_url`, default: `nil`

Override for the URL being shown in the URL bar when `advance_history` is enabled. Default is the actual URL.


### Example usage with options

```erb
<%= render UI::Modal::Component.new(frame: true, close_button: false, advance_history_url: "/foo/bar") do %>
  Hello World!
<% end %>
```
