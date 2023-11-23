"use strict"

async function fetchModels() {
  const response = await fetch("/models/feed.json")
  const models = await response.json()
  return models
}

const e = React.createElement

class ModelFeed extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      allPosts: [],
      filteredPosts: [],
      category: "All",
    }

    fetchModels().then((models) => {
      this.setState({ allPosts: models })
      this.setState({ filteredPosts: models })
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
      "Attention",
      "Convolution",
      "Energy",
      "Fully Connected",
      "Recurrent",
    ]

    return e(
      "div",
      { className: "catalog wrapper" },
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
      this.state.filteredPosts.map((post) => {
        return e(
          "div",
          { className: "item", key: post.slug },
          e(
            "div",
            { className: "content" },
            e("h1", { className: "name" }, post.name + `(${post.year})`),
            e("p", { className: "authors" }, e("small", {}, post.authors)),
            e("p", { className: "description" }, post.description),
            e(
              "div",
              { className: "links" },
              e("a", { href: post.slug }, "Read More"),
              e("a", { href: post.paper }, "Paper")
            )
          ),
          post.image &&
            e(
              "div",
              { className: "image" },
              e("img", { src: post.image }, null)
            )
        )
      })
    )
  }
}

const domContainer = document.querySelector("#react-feed")
ReactDOM.render(e(ModelFeed), domContainer)
