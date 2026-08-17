select title, partenaire, deadline
from opportunities
where lower(partenaire) like '%mastercard%' or lower(partenaire) like '%2ie%'
order by deadline;
