# Front-End Architecture

## CSS Framework

We're using [Tailwind](https://tailwindcss.com/), a CSS framework (with dedicated tooling) that relies on utility classes help us work within the constraints of a system instead of littering our stylesheets with arbitrary values. They make it easy to be consistent with color choices, spacing, typography, shadows, and everything else that makes up a well-engineered design system.

Additionally, [DaisyUI](https://daisyui.com/) is used to provide some default components.

## JavaScript

The front-end is developped as an [Hypermedia-Driven Application](https://htmx.org/essays/hypermedia-driven-applications/):
pages are generated, using a template language, by the server (a paradigm know as Multi-Page Applications or MPAs), combined with the better user experience of Single-Page Applications (SPAs).

Additionally, two pieces of JavaScript are used to provide interactivity when useful or necessary:

- [HTMX](https://htmx.org/), a small library that gives access to AJAX, CSS Transitions, WebSockets and Server Sent Events directly in HTML, using attributes, so one can build modern user interfaces with the simplicity and power of hypertext.

- [AlpineJS](https://alpinejs.dev/): a rugged, minimal tool for composing behavior directly in your markup, that complements HTMX well.

On top of HTMX, the project ships a small **PyWire** component system (`app/flask/lib/pywire/`) inspired by Livewire: server-rendered, stateful UI components that update over AJAX. UI components are auto-discovered and registered by **flask-super** from each module's `components/` directory; partial re-rendering of Jinja2 templates uses **jinja2-fragments**.

## Assets bundling

We're using the [Vite](https://vitejs.dev/) to bundle assets (CSS, JavaScript).

Vite is integrated (mostly) transparently with the backend using the [Flask-Vite](https://github.com/abilian/flask-vite) plugin we developed during the project.
