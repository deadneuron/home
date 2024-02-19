"use strict"

async function fetchNotebooks() {
  const response = await fetch("/notebooks/feed.json")
  const notebooks = await response.json()
  return notebooks
}

const e = React.createElement

class NotebookFeed extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      allPosts: [],
      filteredPosts: [],
      category: "All",
    }

    fetchNotebooks().then((notebooks) => {
      this.setState({ allPosts: notebooks })
      this.setState({ filteredPosts: notebooks })
    })
  }

  filterPosts(category) {
    if (category == "All") {
      this.setState({ filteredPosts: this.state.allPosts })
    } else {
      this.setState({
        filteredPosts: this.state.allPosts.filter((post) => {
          return post.categories.toLowerCase().includes(category.toLowerCase())
        }),
      })
    }
  }

  render() {
    const filters = [
      "All",
      "Compression",
      "Optimization",
      "Regularization",
      "Reinforcement",
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
          e("h2", {}, "Recent Notebooks"),
          filters.map((filter) => {
            return e(
              "span",
              {
                href: "#",
                key: filter,
                className: filter == this.state.category ? "active" : "",
                onClick: () => {
                  this.setState({ category: filter })
                  this.filterPosts(filter)
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
        this.state.filteredPosts.slice(0, 3).map((post) => {
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
        this.state.filteredPosts.slice(3, 7).map((post) => {
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
