-- =========================================================
-- Ajoute le logo Mastercard Foundation sur toutes les
-- opportunités partenaires Mastercard Foundation.
-- =========================================================

update opportunities set logo_url = 'https://i.postimg.cc/CKK3wx68/Screenshot-2026-08-05-010742.png'
where partenaire = 'Mastercard Foundation';
