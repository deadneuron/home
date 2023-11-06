(define home-template
  (lambda (feed)
    `(html
      ((head
        (title "Dead Neurons")
        (meta (@ (charset "utf-8")))
        (meta (@ (name "viewport") (content "width=device-width, initial-scale=1")))
        (link (@ (rel "icon") (href "/static/favicon.ico")))
        (link (@ (rel "stylesheet") (href "/static/style.css")))
        (link (@ (rel "stylesheet") (href "/static/home.css")))
        (link (@ (rel "preconnect") (href "https://fonts.googleapis.com")))
        (link (@ (rel "preconnect") (href "https://fonts.gstatic.com")))
        (link (@ (rel "stylesheet") (href "https://fonts.googleapis.com/css2?family=Open+Sans:wght@500;700&display=block")))
        (link (@ (rel "stylesheet") (href "https://api.mapbox.com/mapbox-gl-js/v2.1.1/mapbox-gl.css")))
        (script (@ (src "https://api.mapbox.com/mapbox-gl-js/v2.1.1/mapbox-gl.js")) ""))
      (body
        (div (@ (class "home"))
          (header
            (div (@ (class "wrapper"))
              (a (@ (href "/") (class "logo")) (img (@ (src "/static/logo.svg"))))
              (nav
                (a (@ (href "/cv")) "CV")
                (a (@ (href "/research")) "Publications")
                (a (@ (href "/models")) "Models")
                (a (@ (href "/notebooks")) "Notebooks"))))

          (main
            (div (@ (class "hero"))
              (div (@ (class "overlay")) "")
                (div (@ (class "wrapper"))
                ; Ideas: Open Minded Research Science, Grey Matter Colorful Thoughts, Mind Sculptor, Brainstorming the ..., Mad Science
                  (h1 "Machine Learning" (br) "Research For Science")
                  (p "Welcome! My name is Tim Whitaker and Wits End is my personal website, a repository for my neural network research, and an outlet for digging deeper into artificial intelligence.")))

            (div (@ (class "notebooks wrapper"))
              (div (@ (class "filters"))
                (nav (@ (class "categories"))
                  (a (@ (href "#.") (class "active")) "All")
                  (a (@ (href "#architecture")) "Architecture")
                  (a (@ (href "#compression")) "Compression")
                  (a (@ (href "#evolution")) "Evolution")
                  (a (@ (href "#optimization")) "Optimization")
                  (a (@ (href "#regularization")) "Regularization"))

                (nav (@ (class "mobile-categories"))
                  (h1 "Recent Posts")
                )
              )
              (div (@ (class "primary-col"))
                ,(map (lambda (post) 
                  `(div (@ (class ,(conc "post " (cadr (assoc 'categories post)))))
                      (small ,(cadr (assoc 'date post)))
                      (h1 ,(cadr (assoc 'title post)))
                      (p ,(cadr (assoc 'description post)))
                      (a (@ (href ,(conc "/notebooks/" (cadr (assoc 'slug post))))) "Read More")))
                (take feed 2)))

              (div (@ (class "secondary-col"))
                ,(map (lambda (post)
                  `(div (@ (class ,(conc "post " (cadr (assoc 'categories post)))))
                      (small ,(cadr (assoc 'date post)))
                      (h1 ,(cadr (assoc 'title post)))
                      (a (@ (href ,(conc "/notebooks/" (cadr (assoc 'slug post))))) "Read More")))
                (drop feed 2)))
                )


            (div (@ (class "featured-paper subnetwork-ensembles"))
              (div (@ (class "wrapper"))
                (div
                  (h1 "Subnetwork Ensembles")
                  ; (p "We are deeply engaged in the exploration of new machine learning applications. Artificial Intelligence could be the most important technological development for humanity over the next decade. It is our duty to explore how we can best use it to make the world a better place.")
                  (p "My PhD research explores this idea of breaking up trained deep neural networks into multiple sparse subnetworks that can be trained, modified, and evaluated independently. Generating ensembles in this manner is an incredibly efficient way to improve the generalization performance and parametric utilization of large networks while minimizing computational cost. This work has a natural connection to the topological structures we find in biological brains and it's a beautiful framework for exploring network optimization. I'm currently working on my dissertation, but I'm very excited to share what I have so far...")
                  (a (@ (href "#") (class "read-more")) "Read More"))))


            ; (div (@ (class "merch"))
            ;   (div (@ (class "wrapper"))
            ;     (h1 "Merch")
            ;     (div (@ (class "column-wrapper"))
            ;       (div (@ (class "column"))
            ;         (div (@ (class "icon"))
            ;           (img (@ (src "https://cdn.midjourney.com/0813bef9-9b47-4758-861c-dc2f81542d52/0_0.png"))))
            ;         (h2 "Model Optimization")
            ;         (p "$25.00"))

            ;       (div (@ (class "column"))
            ;         (div (@ (class "icon"))
            ;           (img (@ (src "https://cdn.midjourney.com/7ba0cef6-1eef-460b-9399-238fa948ba9a/0_0.png"))))
            ;         (h2 "Data Analysis")
            ;         (p "$25.00"))

            ;       (div (@ (class "column"))
            ;         (div (@ (class "icon"))
            ;         (img (@ (src "https://cdn.midjourney.com/d37e6729-7896-492f-b49b-6805f9847748/0_2.png"))))
            ;         (h2 "Software Engineering")
            ;         (p "$25.00")))))
                                
              ; (div (@ (class "primary-col"))
              ;   (div (@ (class "paper interpretable-diversity-analysis"))
              ;       (div
              ;         (h1 "Knowledge Distillation: Teaching Small Models to Perform Like Large Ones")
              ;         (p "Knowledge Distillation is a model compression technique in machine learning where a smaller, simpler student model is trained to replicate the behavior of a larger, more complex teacher model. The fundamental principle underlying this technique is the transference of 'knowledge' from the teacher model to the student model...")
              ;         (a (@ (href "#") (class "read-more")) "Read More")))
              ;   (div (@ (class "paper synaptic-stripping"))
              ;       (div
              ;         (h1 "Sparsity in Practice: Leveraging Sparse Representations for Efficient Neural Networks")
              ;         (p "A deep dive into the concept of sparsity in neural networks, providing practical advice on designing and training sparse models for improved efficiency. The resultant networks not only reduce the memory footprint and computational requirements but often also improve generalization by reducing overfitting...")
              ;         (a (@ (href "#") (class "read-more")) "Read More")))
              ; )
              
              ; (div (@ (class "secondary-col"))
              ;   (div (@ (class "paper sparse-mutation-decomposition"))
              ;       (div
              ;         (h1 "A Deep Dive into Activation Functions")
              ;         (a (@ (href "#") (class "read-more")) "Read More")))
                
              ;   (div (@ (class "paper synaptic-stripping"))
              ;       (div
              ;         (h1 "Binary and Ternary Networks: The Future of Ultra-Efficient Machine Learning")
              ;         (a (@ (href "#") (class "read-more")) "Read More")))
                
              ;   (div (@ (class "paper low-cost-ensembles"))
              ;       (div
              ;         (h1 "Batch Normalization: A Key to Faster and More Stable Training")
              ;         (a (@ (href "#") (class "read-more")) "Read More")))

              ;   (div (@ (class "paper stochastic-masking"))
              ;       (div
              ;         (h1 "Adaptive Learning Rates: The Power of Optimizers in Neural Networks")
              ;         (a (@ (href "#") (class "read-more")) "Read More")))

              ;   (div (@ (class "paper quantum-neuron-selection"))
              ;       (div
              ;         (h1 "Exploring the Benefits of Quantization in Neural Networks")
              ;         (a (@ (href "#") (class "read-more")) "Read More")))))

          (div (@ (class "contact") (id "contact"))
            (div (@ (class "wrapper"))
              (h1 "Get In Touch")
              (div (@ (class "form-container"))
                (form (@ (netlify "1"))
                  (input (@ (placeholder "Name") (name "name") (type "text")))
                  (input (@ (placeholder "Email" (name "email") (type "email"))))
                  (textarea (@ (placeholder "Message") (name "message")) "")
                  (button (@ (type "submit")) "Send Message")))
              (div (@ (class "map-container"))
                (div (@ (id "map")) ""))))


          (div (@ (class "reference"))
            (p "Hero images generated with neural networks via " (a (@ (href "https://midjourney.com")) "midjourney") ".")))

          (footer
            (div (@ (class "wrapper"))
              (div (@ (class "column"))
                (h2 "Site")
                (a (@ (href "/about")) "About")
                (a (@ (href "/models")) "Models")
                (a (@ (href "/notebooks")) "Notebooks")
                (a (@ (href "/research")) "Research"))
              (div (@ (class "column"))
                (h2 "Links")
                (a (@ (href "https://arxiv-sanity-lite.com")) "Arxiv Sanity")
                (a (@ (href "https://paperswithcode.com")) "Papers With Code")
                (a (@ (href "https://news.ycombinator.com")) "Hacker News")
                (a (@ (href "https://www.youtube.com/c/pbsspacetime")) "Space Time"))
              (div (@ (class "column"))
                (h2 "Self")
                (a (@ (href "#")) "CV")
                (a (@ (href "https://github.com/tjwhitaker")) "Github")
                (a (@ (href "https://lichess.org/@/tjwhitaker")) "Lichess")
                (a (@ (href "https://orcid.org/0000-0003-3792-3901")) "Orcid"))))

            (script "	mapboxgl.accessToken = 'pk.eyJ1IjoidG13aHRrciIsImEiOiJja2x2NzdpaW0wNXRnMndwOGszNTc3aWd5In0.LvJ2znCQ_1v9a86fxUhQ2A';
            var map = new mapboxgl.Map({
            container: 'map', // container id
            style: 'mapbox://styles/mapbox/streets-v12', // style URL
            center: [ -105.08338969999998, 40.57471313740658],
            zoom: 11 // starting zoom
            });")
            
            (script "
                var category = location.hash.substr(1);
                var notebooks = document.getElementsByClassName(category);

                for (var post in notebooks) {
                  post.backgroundColor = 'red';
                }

                function filterCategory(category) {
                  var category = location.hash.substr(1);
                  var notebooks = document.getElementsByClass(category);

                  for (var post in notebooks) {
                    post.backgroundColor = 'red';
                  }
                }
              "
            )
            ))))))
