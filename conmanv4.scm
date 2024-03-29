(define-module (conmanv4)
#:use-module (conmanv4 env)  
#:use-module (conmanv4 utilities)
#:use-module (conmanv4 recs)
#:use-module (conmanv4 munger)
#:use-module (conmanv4 pubmed)
#:use-module (conmanv4 cemail)
#:use-module (srfi srfi-19)   ;; date time
#:use-module (srfi srfi-1)  ;;list searching; delete-duplicates in list 
#:use-module (ice-9 pretty-print)
#:export (main)
)

;;#! /bin/bash

;;source /home/admin/.guix-profile/etc/profile
;;export PATH=/home/admin/conmanv4/bin:${PATH:+:}$PATH
;;export GUILE_LOAD_PATH=/gnu/store/5yvzilh78996627i8avq532sl2c03i95-gnutls-3.6.15/share/guile/site/3.0:/home/admin/conmanv4:${GUILE_LOAD_PATH:+:}$GUILE_LOAD_PATH
;;/gnu/store/m5iprcg6pb5ch86r9agmqwd8v6kp7999-guile-3.0.5/bin/guile -e '(conmanv4)' -s /home/admin/conmanv4/conmanv4.scm blah

;;2024-01-30 use guile -e '(conmanv4)' -L . -s ./conmanv4.scm blah from project directory


(define (main args)
  ;; args: '( "script name" "past days to query" "Number of articles to pull")
  ;; 2023-10-01 revision requires single arg that is not used
  (let* ((start-time (current-time time-monotonic))
;;	 (a (get-summaries (cadr args) (caddr args)))
	 (a (get-summaries days-ago max-arts))
	 (dummy (map retrieve-article a))  ;;this does all the work; comment out last line for testing
	 (stop-time (current-time time-monotonic))
	 (elapsed-time (ceiling (/ (time-second (time-difference stop-time start-time)) 60)))
	 (stats-list (get-stats-list elapsed-time))
	 (dummy7 (send-report stats-list  emails-sent))
	 )
  ;; (pretty-print a)
    (pretty-print (string-append "Elapsed time: " (number->string  elapsed-time) " minutes." ))
   ;; #f
    ))
   

;;WORKFLOW

;;1 pubmed/get-summaries returns a list of (("37658855")  ("Jirangkul P"   "Lorsuwannarat N"   "Wanichjaroen N")) and
;;  also as side effect makes ref-records

;;2 retrieve-article
;;     -get the article from "https://pubmed.ncbi.nlm.nih.gov/" pmid "/"
;;     - fast: munger/get-author-records extracts authors from article; also extracts affiliations
;;
;;
;;
;;
;;
;;
