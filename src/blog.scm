(define blog-template
  (lambda (feed)
    `(html
      ((head
        (title "Blog | Dead Neurons")
        (meta (@ (charset "utf-8")))
        (meta (@ (name "viewport") (content "width=device-width, initial-scale=1")))
        (link (@ (rel "icon") (href "/static/favicon.ico")))
        (link (@ (rel "stylesheet") (href "/static/blog.css")))
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
                  (h1 "Blog")
                  (p "Busy writing papers for my PhD. Blog posts coming soon!")))

            ; (div (@ (class "feed"))
            ;   ,(map (lambda (post) 
            ;     `(div (@ (class "post"))
            ;       (div (@ (class "wrapper"))
            ;         (div (@ (class "header"))
            ;           (h1 ,(cadr (assoc 'title post)))
            ;           (small ,(cadr (assoc 'date post))))
            ;         (p ,(cadr (assoc 'description post)))
            ;         (a (@ (href ,(conc "/blog/" (cadr (assoc 'slug post))))) "Read More"))))
            ;   feed))
              
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
                (h2 "Hello World"))))))))))
