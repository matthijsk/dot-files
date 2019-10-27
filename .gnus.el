(setq gnus-select-method '(nntp "news.gmane.org"))


;; Summary buffer
(setq gnus-summary-mode-line-format "Gnus: %G [%A] %Z")

(defconst my-gnus-summary-line-format gnus-summary-line-format "Backup for `gnus-summary-line-format'")
(setq gnus-summary-mode-hook nil)

(add-hook 'gnus-summary-mode-hook #'hl-line-mode)

(add-hook 'gnus-summary-mode-hook
          (lambda ()
            "Fill NOS Nieuws articles, as these are basically unfilled html."
            (if (string-match-p "gwene.nl.nos.nosnieuws" gnus-newsgroup-name)
                (setq gnus-treat-fill-article t)
              (setq gnus-treat-fill-article nil))))
