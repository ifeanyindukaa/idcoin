;; title: idcoin
;; version: 1.0.0
;; summary: SIP-010 compliant fungible token representing IdCoin.
;; description: A simple fungible token implementation for IdCoin on the Stacks blockchain.

(define-fungible-token idcoin)

;; constants
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INSUFFICIENT-BALANCE (err u101))

;; data vars
(define-data-var total-supply uint u0)
(define-data-var token-name (string-utf8 32) u"IdCoin")
(define-data-var token-symbol (string-utf8 8) u"ID")
(define-data-var token-decimals uint u6)

;; public functions

(define-public (transfer (amount uint) (sender principal) (recipient principal))
    (begin
        (asserts! (is-eq tx-sender sender) ERR-NOT-AUTHORIZED)
        (try! (ft-transfer? idcoin amount sender recipient))
        (ok true)))

(define-public (mint (amount uint) (recipient principal))
    (begin
        ;; NOTE: For simplicity this example does not restrict who can mint.
        ;; In a production token, you should restrict minting to an admin
        ;; or governance mechanism.
        (try! (ft-mint? idcoin amount recipient))
        (var-set total-supply (+ (var-get total-supply) amount))
        (ok true)))

;; read only functions

(define-read-only (get-name)
    (ok (var-get token-name)))

(define-read-only (get-symbol)
    (ok (var-get token-symbol)))

(define-read-only (get-decimals)
    (ok (var-get token-decimals)))

(define-read-only (get-total-supply)
    (ok (var-get total-supply)))

(define-read-only (get-balance (owner principal))
    (ok (ft-get-balance idcoin owner)))

;; private functions
