(require 'ox-extra)
(setq doc-view-continuous t)
(ox-extras-activate '(ignore-headlines))

	;; Org-mode
(add-hook 'org-mode-hook
					(lambda () (add-to-list 'org-latex-packages-alist '("" "minted"))))
(with-eval-after-load 'ox-latex
	(add-to-list 'org-latex-classes
		'("puc"
			"\\documentclass{pucthesis}"
			("\\chapter{%s}" . "\\chapter*{%s}")
			("\\section{%s}" . "\\section*{%s}")
			("\\subsection{%s}" . "\\subsection*{%s}")
			("\\subsubsection{%s}" . "\\subsubsection*{%s}")
			("\\paragraph{%s}" . "\\paragraph*{%s}")
			;;("\\subparagraph{%s}" . "\\subparagraph*{%s}")
			))
	(defun org-latex-format-headline-simple-keywords-function
			(todo todo-type priority text tags info)
		(concat
			(cond ((string= todo "TODO")(and todo (format "%s " todo)))
						((string= todo "DONE")(and todo (format "%s " todo)))
						((string= todo "REVIEW")(and todo (format "%s " todo)))
						)
			(and priority (format "\\#%c " priority))
			text
			(and tags
					(format ":%s:"
									(mapconcat (lambda (tag) (org-latex-plain-text tag info))
															tags ":")))))

	(setq org-latex-format-headline-function 'org-latex-format-headline-simple-keywords-function)
	)
