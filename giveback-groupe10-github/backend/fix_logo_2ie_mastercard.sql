alter table opportunities add column if not exists logo_url_2 text;

update opportunities
set logo_url = 'https://i.postimg.cc/CKK3wx68/Screenshot-2026-08-05-010742.png',
    logo_url_2 = 'https://i.postimg.cc/fTZY3tjb/LOGO-2i-E-GOOD.webp',
    partenaire = 'Mastercard Foundation × 2iE'
where partenaire = '2iE';
