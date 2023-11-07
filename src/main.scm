(import (chicken io)
        (chicken file)
        (chicken file posix)
        (chicken irregex)
        (chicken string)
        (chicken format)
        (chicken sort))
(import shell)
(import sxml-serializer)
(import (srfi-1)
        (srfi-19))

;; Import home-template, about-template
(include "./templates/home.scm")
(include "./templates/about.scm")
(include "./templates/cv.scm")
(include "./templates/models.scm")
(include "./templates/notebooks.scm")
(include "./templates/post.scm")
(include "./templates/notebook.scm")
(include "./templates/research.scm")

;; Write html to the intended build file
(define write-html
  (lambda (directory html)
    (create-directory directory #t)
    (call-with-output-file (conc directory "/index.html") (lambda (port) (display (conc "<!DOCTYPE html>" html) port)))))

;; Parse org file for meta tags and content
(define parse-org-file
  (lambda (directory filename)
    (define text 
      (call-with-input-file 
        (conc directory filename) 
        (lambda (port) (read-string #f port))))
    (define match
      (irregex-search
        '(: "TITLE: " (=> title (*? any)) eol (*? any)
            "DESCRIPTION: " (=> description (*? any)) eol (*? any)
            "DATE: " (=> date (*? any)) eol (*? any)
            "HERO: " (=> hero (*? any)) eol) text))
    `((title ,(irregex-match-substring match 'title))
      (description ,(irregex-match-substring match 'description))
      (date ,(irregex-match-substring match 'date))
      (hero ,(irregex-match-substring match 'hero))
      (slug ,(string-chomp filename ".org"))
      (content ,(capture ,(conc "pandoc " directory filename " -f org -t html"))))))

; Parses notebook file. First cell should contain metadata. Using org style fields. Writes the notebook content to the build directory. Returns an object representing the notebook. The "\\n\"," regex handles raeding from the raw ipynb file, where the markdown text includes the newline character as well as a quote and comma.
(define parse-notebook-file
  (lambda (directory filename)
    (define text 
      (call-with-input-file 
        (conc directory filename) 
        (lambda (port) (read-string #f port))))
    (define match
      (irregex-search
        '(: "TITLE: " (=> title (*? any)) "\\n\"," (*? any)
            "CATEGORIES: " (=> categories (*? any)) "\\n\"," (*? any)
            "DESCRIPTION: " (=> description (*? any)) "\\n\"," (*? any)
            "DATE: " (=> date (*? any)) "\\n\"," (*? any)
            "HERO: " (=> hero (*? any)) "\"" eol) text))
    `((title ,(irregex-match-substring match 'title))
      (categories ,(irregex-match-substring match 'categories))
      (description ,(irregex-match-substring match 'description))
      (date ,(irregex-match-substring match 'date))
      (hero ,(irregex-match-substring match 'hero))
      (slug ,(string-chomp filename ".ipynb"))
      (content ,(capture ,(conc "jupyter nbconvert --TagRemovePreprocessor.remove_cell_tags='{\"metadata\"}' --no-prompt --to html --output 'content' --output-dir '../build/notebooks/" (string-chomp filename ".ipynb") "' " directory filename))))))

(define inject-iframe-resizer
  (lambda (directory filename) 
    (define html 
      (call-with-input-file (conc directory filename)
                            (lambda (port) (read-string #f port))))
    (call-with-output-file (conc directory filename)
      (lambda (port) 
        (display (inject-field "</head>" html "<script src='/static/iframeresizer.contentWindow.min.js'></script></head>") port))
    )
  )
)

(define inject-field
  (lambda (placeholder template value)
    (irregex-replace placeholder template value)))

;; Build a feed of all articles
(define build-feed
  (lambda (dir)
    (define posts 
      (map 
        (lambda (x) (parse-org-file dir x)) 
        (directory dir)))
    (sort! posts (lambda (a b)
      (date<?
        (string->date (cadr (assoc 'date a)) "~Y-~m-~d")
        (string->date (cadr (assoc 'date b)) "~Y-~m-~d"))))))

(define build-notebook-feed
  (lambda (dir)
    (define posts 
      (map 
        (lambda (x) (parse-notebook-file dir x)) 
        (directory dir)))
    (map 
      (lambda (post) 
        (inject-iframe-resizer 
          (conc "../build/notebooks/" (cadr (assoc 'slug post)) "/") "content.html"))
      posts)
    (sort! posts (lambda (a b)
      (date<?
        (string->date (cadr (assoc 'date a)) "~Y-~m-~d")
        (string->date (cadr (assoc 'date b)) "~Y-~m-~d"))))))


(define build-home
  (lambda (feed)
    (define html (serialize-sxml (home-template feed) indent: #f method: 'html'))
    (write-html "../build/" html)))

(define build-about
  (lambda ()
    (define html (serialize-sxml (about-template) indent: #f method: 'html'))
    (write-html "../build/about" html)))

(define build-cv
  (lambda ()
    (define html (serialize-sxml (cv-template) indent: #f method: 'html'))
    (write-html "../build/cv" html)))


(define build-models
  (lambda ()
    (define html (serialize-sxml (models-template) indent: #f method: 'html'))
    (write-html "../build/models" html)))

(define build-notebooks
  (lambda (feed)
    (define html (serialize-sxml (notebooks-template feed) indent: #f method: 'html'))
    (write-html "../build/notebooks" html)))

;; Build article pages
(define build-posts
  (lambda (feed dir)
    (map 
      (lambda (article) 
        (define title (cadr (assoc 'title article)))
        (define description (cadr (assoc 'description article)))
        (define hero (cadr (assoc 'hero article)))
        (define template (serialize-sxml (post-template title description hero) indent: #f method: 'html))
        (define html (inject-field "<ARTICLE-CONTENT />" template (cadr (assoc 'content article))))

        ; (define html (irregex-replace "<CONTEXT />" template (cadr (assoc 'content article))))
        (write-html (conc dir (cadr (assoc 'slug article))) html))
      feed)))


(define build-notebook-templates
  (lambda (feed dir)
    (map 
      (lambda (article) 
        (define title (cadr (assoc 'title article)))
        (define description (cadr (assoc 'description article)))
        (define hero (cadr (assoc 'hero article)))
        (define slug (cadr (assoc 'slug article)))
        (define content-html (conc "/notebooks/" slug "/content.html"))
        (define html (serialize-sxml (notebook-template title description hero content-html) indent: #f method: 'html))
        (write-html (conc dir (cadr (assoc 'slug article))) html))
      feed)))

(define build-research
  (lambda ()
    (define html (serialize-sxml (research-template) indent: #f method: 'html'))
    (write-html "../build/research" html)))

;; Run gulp and copy static files to build dir
(define build-static
  (lambda ()
    (run gulp)))

;; Our main loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Runs all our JS compilation and copies static assets
(build-static)

; Builds the static pages
(build-about)
(build-cv)
(build-models)
(build-research)

; Builds a list of notebook objects from ipynb files
(define notebook-feed (build-notebook-feed "notebooks/"))

; Builds notebooks index page
(build-notebooks notebook-feed)

;Builds each of the individual notebook templates
(build-notebook-templates notebook-feed "../build/notebooks/")

; Builds the home page and passes the 7 most recent notebooks
(build-home (take notebook-feed 6))


; (let 
;   ((notebook-feed (build-notebook-feed "notebooks/")))
;   (build-static)
;   (build-home)
;   (build-cv)
;   (build-models)
;   (build-research)
;   (build-notebooks notebook-feed)
;   (build-notebook-templates notebook-feed "../build/notebooks/"))

; (let 
;   ((notebooks (build-feed "articles/")))
;   (build-static)
;   (build-home)
;   (build-cv)
;   (build-models)
;   (build-research)
;   (build-notebooks notebooks)
;   (build-posts notebooks "../build/notebooks/"))