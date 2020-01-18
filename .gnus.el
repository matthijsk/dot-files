(setq gnus-select-method '(nntp "news.gmane.io"))


;; Summary buffer
(setq gnus-summary-mode-line-format "Gnus: %G [%A] %Z")

(add-hook 'gnus-summary-mode-hook #'hl-line-mode)

(add-hook 'gnus-summary-mode-hook
          (lambda ()
            "Set custom options for specific groups."
            (cond ((string-match-p "gwene.nl.nos.nosnieuws" gnus-newsgroup-name)
                   (setq-local gnus-summary-line-format "%*%U%R %-20&user-date;| %S\n")
                   ;; Fill NOS Nieuws articles, as these are basically unfilled html.
                   (setq-local gnus-treat-fill-article t))
                  ((string-match-p "gwene.com.emacslife.planet" gnus-newsgroup-name)
                   (setq-local gnus-treat-fill-article t)))))
