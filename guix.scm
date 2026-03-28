; SPDX-License-Identifier: PMPL-1.0-or-later
;; guix.scm — GNU Guix package definition for awesome-mcp-servers
;; Usage: guix shell -f guix.scm

(use-modules (guix packages)
             (guix build-system gnu)
             (guix licenses))

(package
  (name "awesome-mcp-servers")
  (version "0.1.0")
  (source #f)
  (build-system gnu-build-system)
  (synopsis "awesome-mcp-servers")
  (description "awesome-mcp-servers — part of the hyperpolymath ecosystem.")
  (home-page "https://github.com/hyperpolymath/awesome-mcp-servers")
  (license ((@@ (guix licenses) license) "PMPL-1.0-or-later"
             "https://github.com/hyperpolymath/palimpsest-license")))
