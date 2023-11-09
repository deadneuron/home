"use strict"

async function fetchNotebooks() {
  const response = await fetch("/notebooks/feed.json")
  const notebooks = await response.json()
  return notebooks
}

const e = React.createElement

class PostList extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      posts: [],
      category: "All",
    }

    fetchNotebooks().then((notebooks) => {
      this.setState({ posts: notebooks })
    })
  }

  renderList() {
    return this.state.posts.map((post) => {
      return e(
        "div",
        { className: "post", key: post.slug },
        e("small", {}, post.date),
        e("h1", {}, post.title),
        e("p", {}, post.description),
        e("a", { href: post.slug }, "Read More")
      )
    })
  }

  render() {
    return e("div", {}, this.renderList())
  }
}

class NotebookFeed extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      posts: [],
      category: "All",
    }

    fetchNotebooks().then((notebooks) => {
      this.setState({ posts: notebooks })
    })
  }

  render() {
    const filters = [
      "All",
      "Architecture",
      "Compression",
      "Optimization",
      "Regularization",
    ]

    return e(
      "div",
      { className: "feed wrapper" },
      e(
        "div",
        { className: "filters" },
        e(
          "nav",
          { className: "categories" },
          filters.map((filter) => {
            return e(
              "span",
              {
                href: "#",
                key: filter,
                className: filter == this.state.category ? "active" : "",
                onClick: () => {
                  this.setState({ category: filter })
                },
              },
              filter
            )
          })
        ),
        e(
          "nav",
          { className: "mobile-categories" },
          e("span", {}, "Recent Posts")
        )
      ),
      e(
        "div",
        { className: "primary-col" },
        this.state.posts.slice(0, 2).map((post) => {
          return e(
            "div",
            { className: "post", key: post.slug },
            e("small", { className: "date" }, post.date),
            e("h1", { className: "title" }, post.title),
            e("p", { className: "description" }, post.description),
            e("a", { href: post.slug }, "Read More")
          )
        })
      ),
      e(
        "div",
        { className: "secondary-col" },
        this.state.posts.slice(2, 6).map((post) => {
          return e(
            "div",
            { className: "post", key: post.slug },
            e("small", { className: "date" }, post.date),
            e("h1", { className: "title" }, post.title),
            e("p", { className: "description" }, post.description),
            e("a", { href: post.slug }, "Read More")
          )
        })
      )
    )
  }
}

const domContainer = document.querySelector("#react-feed")
ReactDOM.render(e(NotebookFeed), domContainer)
