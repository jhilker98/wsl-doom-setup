(setq doom-theme 'doom-gruvbox
      doom-font (font-spec :family "Jhiosevka NF" :size 14)
      doom-variable-pitch-font (font-spec :family "Jhiosevka Sans" :size 14))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

;(custom-set-faces!
;  '(font-lock-comment-face :slant italic))

(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
;(set-face-attribute 'default nil :background "#1d2021")

(setq display-line-numbers-type 'relative)

;(after! doom-dashboard
;  (setq +doom-dashboard-banner-file "~/.config/doom/doom-banner.png"))

(setq +doom-dashboard-banner-file "~/.config/doom/doom-banner.png")
;(setq fancy-splash-image "~/.config/doom/doom-banner.png")

(after! persp-mode
  (vertico-posframe-mode 1))

(after! hydra
  (hydra-posframe-mode 1))

(setq org-directory "~/Dropbox/org/")

(after! org
  (setq org-todo-keywords '((sequence "TODO(t)" "INPR(i)" "HOLD(h)" "|" "DONE(d)" "CANC(c)"))
        org-todo-keyword-faces '(("TODO" . (:foreground "#cc241d" :underline t)))
        org-agenda-files '("gtd/inbox.org" "gtd/orgzly.org" "gtd/todo.org" "gtd/gcal.org")
        org-agenda-start-day nil ;; today
        org-ellipsis "▾"))

(defun jh/org-ui-hook ()
  (variable-pitch-mode 1)
  (setq display-line-numbers nil)
  (setq display-line-numbers-type 'nil)
  (set-face-attribute 'org-block nil :inherit 'fixed-pitch))

(add-hook! 'org-mode-hook #'jh/org-ui-hook)

(after! org-agenda
  (org-super-agenda-mode))

(add-hook! 'org-mode-hook #'org-recur-mode)

(add-hook! 'org-agenda-mode-hook #'org-recur-agenda-mode)

(setq org-agenda-custom-commands
'(("d" "Dashboard"
    ((agenda "" ((org-agenda-span 'day)
                (org-agenda-time-grid '((today require-timed remove-match)()() "" "——————————"))
                (org-agenda-current-time-string "◄———————————————— Now")
                (org-agenda-remove-tags t)
                (org-agenda-compact-blocks t)))))))

(after! org-roam
  (setq org-roam-directory "~/Dropbox/roam/"
        org-roam-db-location "~/.org-roam.db"
        org-roam-completion-everywhere t)
  (cl-defmethod org-roam-node-namespace ((node org-roam-node))
    "Return the currently set namespace for the NODE."
    (let ((namespace (cdr (assoc-string "NAMESPACE" (org-roam-node-properties node)))))
      (if (string= namespace (file-name-base (org-roam-node-file node)))
          "" ; or return the current title, e.g. (org-roam-node-title node)
        (format "%s" namespace))))

  (setq org-roam-node-display-template (concat "${namespace:15} ${title:*}" (propertize "${doom-tags:50}" 'face 'org-tag))))

(after! ox-hugo
  (setq org-hugo-base-dir "~/Projects/sites/jhilker.gitlab.io"
        org-hugo-auto-set-lastmod t
        org-hugo-front-matter-format "yaml"
        org-hugo-suppress-lastmod-period 86400
        org-hugo-section "blog"))

(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)

(after! elfeed
  (setq elfeed-search-filter "@2-weeks-ago +unread"))

(after! elfeed-org
  (setq rmh-elfeed-org-files '("~/Dropbox/org/elfeed.org")))

(add-hook! 'elfeed-search-mode-hook 'elfeed-update)

(pretty-hydra-define jh/elfeed-search-hydra (:title "Elfeed Filters" :quit-key "q" :color teal)
  ("Category"
   (("d" (elfeed-search-set-filter "@2-weeks-ago +unread") "Default")
    ("n" (elfeed-search-set-filter "@2-weeks-ago +unread +news") "News")
    ("c" (elfeed-search-set-filter "@2-weeks-ago +unread +campaign") "Campaigns")
    ("f" (elfeed-search-set-filter "@2-weeks-ago +unread +forum") "Forums")
    ("p" (elfeed-search-set-filter "+podcast") "Podcasts")
    ("R" (elfeed-search-set-filter "@2-weeks-ago +unread +reddit") "Reddit")
    ("b" (elfeed-search-set-filter "@2-weeks-ago +unread +blog") "Blogs"))))

(map! :leader
      (:desc "Find file in project" ":" #'projectile-find-file)
      (:desc "M-x" "SPC" #'execute-extended-command))


