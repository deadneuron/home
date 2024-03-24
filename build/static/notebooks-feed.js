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
      category: "all",
      tag: "all",
    }

    fetchNotebooks().then((notebooks) => {
      this.setState({ allPosts: notebooks })
      this.setState({ filteredPosts: notebooks })
    })
  }

  filterCategory(category) {
    if (category.toLowerCase() == "all") {
      this.setState({ filteredPosts: this.state.allPosts })
    } else {
      this.setState({
        filteredPosts: this.state.allPosts.filter((post) => {
          return post.categories.toLowerCase().includes(category.toLowerCase())
        }),
      })
    }
  }

  filterTag(tag) {
    if (tag.toLowerCase() == "all") {
      this.setState({ filteredPosts: this.state.allPosts })
    } else { 
      this.setState({
        filteredPosts: this.state.allPosts.filter((post) => {
          return post.tags.toLowerCase().includes(tag.toLowerCase())
        })
      })
    }
  }

  render() {
    const filters = [
      "all",
      "architecture",
      "compression",
      "optimization",
      "regularization",
    ]

    const tags = ['all', 'ensemble', 'optimization', 'pruning', 'distillation', 'diffusion', 'generative', 'tuning', 'reinforcement', 'unsupervised', 'supervised', 'classification', 'regression', 'regularization', 'evolution', 'sparsity', 'latent', 'quantization', 'augmentation', 'federated', 'transfer', 'attention', 'bayesian', 'interpretability', 'clustering', 'embedding', 'efficient', 'segmentation', 'theory']

    return e(
      "div",
      { className: "feed wrapper" },
      e(
        "div",
        { className: "filters" },
        e(
          "nav",
          { className: "categories" },
          filters.map((category) => {
            return e(
              "span",
              {
                href: "#",
                key: category,
                className: category == this.state.category ? "active" : "",
                onClick: () => {
                  this.setState({ category: category })
                  this.setState({ tag: "all" })
                  this.filterCategory(category)
                },
              },
              category
            )
          })
        ),
        e(
          "nav",
          { className: "mobile-categories" },
          e("span", {}, "Recent Posts")
        )
      ),
      e("div", {className: "primary-col"}, 
        this.state.filteredPosts.map((post) => {
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
      e("div", {className: "secondary-col"},
        e("div", {className: "search"},
          e("h3", {className: "minion"}, "Search"),
          e("div", {className: "field-group"}, 
            e("div", {className: "icon"}, 
              e("svg", {viewBox: "0 0 512 512"}, 
                e("path", {fill: "currentColor", d: "M505 442.7L405.3 343c-4.5-4.5-10.6-7-17-7H372c27.6-35.3 44-79.7 44-128C416 93.1 322.9 0 208 0S0 93.1 0 208s93.1 208 208 208c48.3 0 92.7-16.4 128-44v16.3c0 6.4 2.5 12.5 7 17l99.7 99.7c9.4 9.4 24.6 9.4 33.9 0l28.3-28.3c9.4-9.4 9.4-24.6.1-34zM208 336c-70.7 0-128-57.2-128-128 0-70.7 57.2-128 128-128 70.7 0 128 57.2 128 128 0 70.7-57.2 128-128 128z"}, null)
              )
            ),
            e("input", {type: "text", placeholder: "Articles, Datasets, Research and more..."}, null)
          )
        ),
        e("div", {className: "sort"},
          e("h3", {className: "minion"}, "Sort"),
          e("div", {className: "options"}, 
            e("div", {className: "group"},
              e("span", {className: "active"}, "Top"),
              e("span", {}, "Recent"),
              e("span", {}, "Impactful"),
              e("span", {}, "Featured"),
            ),
            e("div", {className: "group"},
              e("span", {className: "active"}, "All Time"),
              e("span", {}, "Past Decade"),
              e("span", {}, "Past Year"),
              e("span", {}, "Past Month"),
            ),
          )
        ),
        e("div", {className: "tags"},
          e("h3", {className: "minion"}, "Tags"),
          tags.sort().map((tag) => {
            return e(
              "span",
              {
                key: tag,
                className: tag == this.state.tag ? "active" : "",
                onClick: () => {
                  this.setState({ tag: tag })
                  this.setState({ category: "all" })
                  this.filterTag(tag)
                },
              },
              tag
            )
          })
        )
      )
    )
  }
}

const domContainer = document.querySelector("#react-feed")
ReactDOM.render(e(NotebookFeed), domContainer)
