(define code-template
  (lambda ()
    `(html
      ((head
        (title "Code | Dead Neurons")
        (meta (@ (charset "utf-8")))
        (meta (@ (name "viewport") (content "width=device-width, initial-scale=1")))
        (link (@ (rel "icon") (href "/static/favicon.ico")))
        (link (@ (rel "stylesheet") (href "/static/code.css")))
        (link (@ (rel "stylesheet") (href "https://fonts.googleapis.com/css?family=Fira+Mono:400,500,700|&display=swap")))
        (link (@ (rel "stylesheet") (href "https://api.mapbox.com/mapbox-gl-js/v2.1.1/mapbox-gl.css")))
        (script (@ (src "https://api.mapbox.com/mapbox-gl-js/v2.1.1/mapbox-gl.js")) ""))
      (body
        (div (@ (class "home"))
          (header
            (div (@ (class "wrapper"))
              (a (@ (href "/") (class "logo")) (img (@ (src "/static/logo.svg"))))
              (nav
                (a (@ (href "/about")) "About")
                (a (@ (href "/blog")) "Blog")
                (a (@ (href "/projects")) "Projects")
                (a (@ (href "/research")) "Research"))))

          (main
            (div (@ (class "hero"))
              (div (@ (class "overlay")) "")
                (div (@ (class "wrapper"))
                  (h1 "Code")
                  (p "Below are some repos connected to my research. I have a lot more on my github if interested.")))

            (div (@ (class "prune-and-tune-ensembles"))
              (div (@ (class "wrapper"))
                (div
                  (h1 "Prune and Tune Ensembles")
                  (p "Ensemble Learning is an effective method for improving generalization in machine learning. However, as state-of-the-art neural networks grow larger, the computational cost associated with training several independent networks becomes expensive. We introduce a fast, low-cost method for creating diverse ensembles of neural networks without needing to train multiple models from scratch. We do this by first training a single parent network. We then create child networks by cloning the parent and...")
                  (a (@ (href "/static/prune-and-tune-ensembles.pdf") (class "read-more")) "Read More"))))
            (div (@ (class "interpretable-diversity-analysis"))
              (div (@ (class "wrapper"))
                (div
                  (h1 "Interpretable Diversity Analysis")
                  (p "Diversity is an important consideration in the construction of robust neural network ensembles. A collection of well trained models will generalize better to unseen data if they are diverse in the patterns they respond to and the predictions they make. Encouraging diversity becomes especially important for low-cost ensemble methods, as members often share network structure or training epochs in order to avoid training several independent networks from scratch...")
                  (a (@ (href "/static/there-is-no-magic-subnetwork.pdf") (class "read-more")) "Read More"))))
            (div (@ (class "quantum-neuron-selection"))
              (div (@ (class "wrapper"))
                (div
                  (h1 "Quantum Neuron Selection")
                  (p "Gradient descent methods have long been the de facto standard for training deep neural networks. Millions of training samples are fed into models with billions of parameters, which are slowly updated over hundreds of epochs. Recently, it's been shown that large, randomly initialized, neural networks contain subnetworks that perform as well as fully trained models. This insight offers a promising avenue for...")
                  (a (@ (href "/static/quantum-neuron-selection.pdf") (class "read-more")) "Read More")))))

          (footer
            (div (@ (class "wrapper"))
              (div (@ (class "column"))
                (h2 "Site")
                (a (@ (href "/about")) "About")
                (a (@ (href "/art")) "Art")
                (a (@ (href "/music")) "Music")
                (a (@ (href "")) "Contact"))
              (div (@ (class "column"))
                (h2 "Links")
                (a (@ (href "")) "Hello")
                (a (@ (href "")) "Hello"))
              (div (@ (class "column"))
                (h2 "Hello World"))))))))))
