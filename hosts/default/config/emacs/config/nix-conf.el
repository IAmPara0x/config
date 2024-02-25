(use-package lsp-nix
  :ensure lsp-mode
  :after (lsp-mode)
  :demand t
  :custom
  (lsp-nix-nil-formatter ["nixpkgs-fmt"]))

(use-package nix-mode
  :hook ((nix-mode . lsp-deferred)
	 (nix-mode . company-mode))
  :ensure t)
