(define home-template
  (lambda ()
    `(html
      ((head
        (title "Dead Neurons")
        (meta (@ (charset "utf-8")))
        (meta (@ (name "viewport") (content "width=device-width, initial-scale=1")))
        (link (@ (rel "icon") (href "/static/favicon.ico")))
        (link (@ (rel "stylesheet") (href "/static/home.css")))
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
                (a (@ (href "/models")) "Models")
                (a (@ (href "/research")) "Research"))))

          (main
            (div (@ (class "hero"))
              (div (@ (class "overlay")) "")
                (div (@ (class "wrapper"))
                  (h1 "Learn How To Build Better Neural Networks")
                  (p "Welcome! My name is Tim Whitaker and I'm a researcher studying neural network optimization and analysis. Dead Neurons is my website where I explore and share cool research in machine learning.")))
            

              (div (@ (class "featured"))
                (blockquote "Recent Stuff")

                (div (@ (class "wrapper"))
                  (div (@ (class "post"))
                      (h2 "Prune and Tune Ensembles")
                      (small "01-01-2022")
                      (p "Ensemble Learning is an effective method for improving generalization in machine learning. However, as state-of-the-art neural networks grow larger, the computational cost associated with training several independent networks becomes expensive. We introduce a fast...")
                      (a (@ (href "#")) "Read More"))
                  (div (@ (class "post"))
                      (h2 "Low-Cost Ensemble Learning")
                      (small "01-01-2022")
                      (p "Ensemble learning has long been known to be a reliable and consistent way to improve generalization performance across a wide range of machine learning tasks. Instead of training and making predictions with a single model, ensembles use several...")
                      (a (@ (href "#")) "Read More"))
                  (div (@ (class "post"))
                      (h2 "Synaptic Stripping")
                      (small "01-01-2022")
                      (p "Rectified Linear Units (ReLU) have long been the default choice for activation functions in deep neural networks. While they demonstrate excellent empirical performance, ReLU activations can fall victim to the dead neuron problem. In these cases, weights end up being pushed into a state where the neuron outputs zero...")
                      (a (@ (href "#")) "Read More"))
                )
              )

            (div (@ (class "hero2"))
              (div (@ (class "overlay")) "")
              (div (@ (class "wrapper"))
                (h1 "A Research Scientist Who loves to code")
                (p "Don't ever, for any reason, do anything to anyone for any reason ever, no matter what, no matter where, or who, or who you are with, or where you are going, or where you've been... ever, for any reason whatsoever.")
              )
            )

            (div (@ (class "intro"))
              (div (@ (class "wrapper"))
                (div (@ (class "column-wrapper"))
                  (div (@ (class "column"))
                    (img (@ (src "/static/039-space-and-universe.svg")))
                    (h2 "Exploratory Data Analysis")
                    (p "Leverage agile frameworks to provide a robust synopsis for high level overviews. Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition. Organically grow the holistic world view of disruptive innovation via workplace diversity and empowerment.")
                  )
                  (div (@ (class "column"))
                    (img (@ (src "/static/039-lab-experiments.svg")))
                    (h2 "Neural Network Optimization")
                    (p "Bring to the table win-win survival strategies to ensure proactive domination. At the end of the day, going forward, a new normal that has evolved from generation X is on the runway heading towards a streamlined cloud solution. User generated content in real-time will have multiple touchpoints for offshoring.")
                  )
                  (div (@ (class "column"))
                    (img (@ (src "/static/039-genetic-engineering.svg")))
                    (h2 "Software Engineering")
                    (p "Capitalize on low hanging fruit to identify a ballpark value added activity to beta test. Override the digital divide with additional clickthroughs from DevOps. Nanotechnology immersion along the information highway will close the loop on focusing solely on the bottom line.")
                  )
                )
              )
            )


            (div (@ (class "contact"))
              (div (@ (class "wrapper"))
                (h2 "Contact")
                (div (@ (class "form-container"))
                  (input (@ (placeholder "Name")))
                  (input (@ (placeholder "Email")))
                  (textarea (@ (placeholder "Message")) "")
                  (a (@ (class "button") (href "#")) "Send Message")
                )
                (div (@ (class "map-container"))
                  (div (@ (id "map")) "")
                  (p "Sacramento, CA")
                )
              )
            )

            (div (@ (class "reference"))
              (p "P.S. I built this website using a static site generator I built in " (a (@ (href "#")) "scheme") ". All hero images are generated with neural networks via " (a (@ (href "#")) "midjourney") ".")
            )
          )


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
                (h2 "Hello World"))))

          
          (script (@ (src "/static/progressbar.min.js")) "")
          (script (@ (src "/static/howler.min.js")) "")
          (script (@ (src "/static/launchpad.js")) "")
          (script "	mapboxgl.accessToken = 'pk.eyJ1IjoidG13aHRrciIsImEiOiJja2x2NzdpaW0wNXRnMndwOGszNTc3aWd5In0.LvJ2znCQ_1v9a86fxUhQ2A';
          var map = new mapboxgl.Map({
          container: 'map', // container id
          style: 'mapbox://styles/mapbox/streets-v11', // style URL
          center: [-121.4944, 38.5816], // starting position [lng, lat]
          zoom: 10 // starting zoom
          });"
          )
                ))))))
