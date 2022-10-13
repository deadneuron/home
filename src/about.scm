(define about-template
  (lambda ()
    `(html
      ((head
        (title "About | Dead Neurons")
        (meta (@ (charset "utf-8")))
        (meta (@ (name "viewport") (content "width=device-width, initial-scale=1")))
        (link (@ (rel "icon") (href "/static/favicon.ico")))
        (link (@ (rel "stylesheet") (href "/static/about.css")))
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
              (h1 "Welcome")
              (p "My name is Tim and I'm a PhD student at Colorado State University. Dead Neurons is a website I started to share some of my neural network and machine learning research.")
            )
          )

          (div (@ (class "personal"))
            (div (@ (class "content"))
              (div (@ (class "wrapper"))
                (h1 "About Me")
                (p "I am a 30 year old computer scientist trying to find my way in this world. I live in Sacramento, California and I just married my best friend, Alyssa, this last year.")
                (p "I graduated from Chico State University with a B.S. in computer science. I worked as a web developer/software engineer for 5 years before deciding to go back to school to pursue an interest in machine learning and neural networks. I finished my M.S. and am happily pursuing my PhD!")
                (p "When I am not programming or working on my research, I am probably rock climbing or playing chess!")
              )
            )
            (div (@ (class "image"))
              (img (@ (src "/static/about-me-profile.jpg")))
            )
          )

          (div (@ (class "hero3"))
            (div (@ (class "overlay")) "")
            (div (@ (class "wrapper"))
              (h1 "I love to play chess")
              (p "...")
            )
          )

          (div (@ (class "gallery"))
            (div (@ (class "item"))
              (img (@ (src "/static/van-gogh-proposal.jpg"))))
            (div (@ (class "item"))
              (img (@ (src "/static/ceremony.jpg"))))
            (div (@ (class "item"))
              (img (@ (src "/static/stronk.jpg"))))
            (div (@ (class "item"))
              (img (@ (src "/static/saigon.jpg"))))
            (div (@ (class "item"))
              (img (@ (src "/static/sierra.jpg"))))
            (div (@ (class "item"))
              (img (@ (src "/static/rmnp.jpg"))))
            (div (@ (class "item"))
              (img (@ (src "/static/evilution.jpg"))))
          "" )


          

          ; (div (@ (class ""))
          ;   (div (@ (class "wrapper"))
          ;     (h1 "What's up with the name?")
          ;     (p "...")
          ;   )
          ; )

          ; (div (@ (class "professional"))
          ;   (div (@ (class "wrapper"))
          ;     (h1 "Education")
          ;     (p "I am working on my PhD. I've been programming for a long time. I consider myself a bit of a polyglot. I love languages.")
            
          ;     (div (@ (class "education"))
          ;       (div (@ (class "item"))
          ;         (div (@ (class "header"))
          ;           (h2 "Doctor of Philosophy in Computer Science")
          ;           (span "Expected May 2023"))
          ;         (p "Colorado State University")
          ;         (p "Dissertation: Neural Partitioning"))
          ;       (div (@ (class "item"))
          ;         (div (@ (class "header"))
          ;           (h2 "Master of Science in Computer Science")
          ;           (span "May 2021"))
          ;         (p "Colorado State University")
          ;         (p "Thesis: Prune and Tune Ensembles: Low-Cost Ensemble Learning With Sparse Independent Subnetworks"))
          ;       (div (@ (class "item"))
          ;         (div (@ (class "header"))
          ;           (h2 "Bachelor of Science in Computer Science")
          ;           (span "May 2015"))
          ;         (p "California State University, Chico")
          ;         (p "Capstone: Real Time Web Performance Analysis"))
          ;       (div (@ (class "item"))
          ;         (h2 "Relevant Coursework")
          ;         (p "Machine Learning, 3D User Interfaces, Artificial Intelligence, Object-Oriented Programming, Compiler Design, Software Engineering, Algorithms and Data Structures, Numerical & Parallel Programming, Computer Security, Linear Algebra for Data Science, Probability and Statistics")))
          ;   )
          ; )
          
          (footer 
            (div (@ (class "wrapper"))
              (div (@ (class "column"))
                (h2 "Site")
                (a (@ (href "")) "Hello")
                (a (@ (href "")) "Hello")
                (a (@ (href "")) "Hello")

              )
              (div (@ (class "column"))
                (h2 "Links")
                (a (@ (href "")) "Hello")
                (a (@ (href "")) "Hello")

              )
              (div (@ (class "column"))
                (h2 "Hello World")
              )
            )
          )

          (script "	mapboxgl.accessToken = 'pk.eyJ1IjoidG13aHRrciIsImEiOiJja2x2NzdpaW0wNXRnMndwOGszNTc3aWd5In0.LvJ2znCQ_1v9a86fxUhQ2A';
          var map = new mapboxgl.Map({
          container: 'map', // container id
          style: 'mapbox://styles/mapbox/streets-v11', // style URL
          center: [-121.4944, 38.5816], // starting position [lng, lat]
          zoom: 10 // starting zoom
          });"
          ))))))))
