R11:
select nomEmploye, prenomEmploye
from Employes
where salaireEmploye >2000

R12:
select nomCamping
from Campings
where villeCamping='Palavas' and nbEtoilesCamping=5;

R13

select nomEmploye, prenomEmploye
from Employes E
join Campings C on E.idCamping=C.idCamping
where nomCamping='Les Flots Bleus'
order by  salaireEmploye ;

R14

select E.nomEmploye,E.prenomEmploye
from Employes E
join Employes E2 on E2.idEmploye=E.idEmployeChef #et pas E.idEmploye=E2.idEmployeChe
where E2.nomEmploye='Alizan' and E2.prenomEmploye='Gaspard';

R15
select nomClient, prenomClient, dateDebut, dateFin
from Clients C
join Locations L on C.idClient=L.idClient
join Bungalows B on L.idBungalow=B.idBungalow
join Campings Ca  on Ca.idCamping=B.idCamping
where nomCamping='Les Flots Bleus' and dateDebut<='14/07/2017' and dateFin>='14/07/2017';

R16
select nomClient, prenomClient
from Clients C
where idClient in (
	select idClient
from Locations L
join Bungalows B on L.idBungalow=B.idBungalow
join Campings Ca  on Ca.idCamping=B.idCamping
where nomCamping='Les Flots Bleus' and dateDebut<='31/07/2017' and dateFin>='01/07/2017');

R17

select nomClient, prenomClient
from Clients C
where idClient in ( select idClient
from Locations L 
join Bungalows B on L.idBungalow=B.idBungalow
join Campings Ca  on Ca.idCamping=B.idCamping
where villeClient=villeCamping);

select nomClient, prenomClient, villeCamping, villeClient,idClient
from Clients C
join Locations L on C.idClient=L.idClient
join Bungalows B on L.idBungalow=B.idBungalow
join Campings Ca  on Ca.idCamping=B.idCamping
where villeClient=villeCamping;

Select nomClient, prenomClient
from Client C
Where villeClient in (Select villeCamping
from Campings)

R18
select count(S.idservice)
from Services S
join Proposer P on P.idservice=S.idservice
join Bungalows B on P.idBungalow=B.idBungalow
where nomBungalow='Le Titanic'

R19

select max(salaireEmploye)
from Employes E
join Campings C on E.idCamping=C.idCamping
where nomCamping='Les Flots Bleus'

R20
select count(idLocation)
join Locations 
join Clients C on L.idClient=C.idClient
where nomClient='Zeblouse'



select count(Distinct Ca.idCamping)
from Campings Ca
join Bungalows B on Ca.idCamping=B.idCamping
join Locations L on B.idBungalow=L.idBungalow
join Clients C on L.idClient=C.idClient
where nomClient='Zeblouse'

R21
select nomBungalow
from Bungalows
where superficieBungalow in (select max(superficieBungalow)
from Bungalows)

R22
select nomEmploye, prenomEmploye
from Employes E 
	join Campings C on E.idCamping=C.idCamping 
where salaireEmploye in (select min(salaireEmploye) 
	from Employes E 
	join Campings C on E.idCamping=C.idCamping 
	where nomCamping='Les Flots Bleus') and nomCamping='Les Flots Bleus';

R23
select nomBungalow
from Bungalows
where idBungalow not in (select B.idBungalow from Bungalows B 
	join Proposer P on P.idBungalow=B.idBungalow
	join Services S on S.idservice=p.idservice)

R24
select nomEmploye, prenomEmploye
from Employes
where idEmploye in(select idEmploye
from Employes 
minus
Select idEmployeChef
from Employes)

R25
/* marche pas */
Select Distinct nomBungalow
from Bungalows 
where idBungalow not in(select idBungalow
						from Proposer P 
							join Services S on P.idservice=S.idservice
						where nomService='Climatisation') 

and idBungalow not in (select idBungalow
						from Proposer P 
							join Services S on P.idservice=S.idservice
						where nomService='Service TV'))
					  


join Proposer P on B.idBungalow=P.idBungalow
join Services S on P.idservice=S.idservice









Td3.

R30

select nomBungalow
from Bungalows B
where not exists (select *
					from Locations L 
					where B.idBungalow=L.idBungalow)


R31

select nomCamping
from Campings C
where not exists (select *
					from Employes E
					where C.idCamping=E.idCamping)

R32


select nomService
from Services S
where categorieService='Loisir' or not exists (select*
												from Proposer P
												join Bungalows B on P.idBungalow=B.idBungalow
												join Campings C on B.idCamping=C.idCamping
												where S.idservice=P.idservice and nomCamping='The White Majestic')



/*
select*
from Services S												
join Proposer P on S.IdService=P.idService
												join Bungalows B on P.idBungalow=B.idBungalow
												join Campings C on B.idCamping=C.idCamping
												where nomCamping='The White Majestic';*/

R33 

Marche mais pas comme il faut

select nomClient 
from Clients C
join Locations L on C.idClient=L.idClient
where not exists (select *
				from Locations L
				join Bungalows B on L.idBungalow=B.idBungalow
				where superficieBungalow<58 and C.idClient=L.idClient)


/*
select *
from Clients C
join Locations L on C.idClient=L.idClient
				join Bungalows B on L.idBungalow=B.idBungalow
				where superficieBungalow<58 */
R34
/* Marche pas */
select nomClient
from Clients C
where villeClient='Montpellier'
and not exists (select *
				from Bungalows B
				join Proposer P on B.idBungalow=P.idBungalow
				join Locations L on B.idBungalow=L.idBungalow
				where C.idClient=L.idBungalow 
				and not exists( select *
							from Services S
							where P.idservice=S.idService))

R40
select distinct c.idClient, c.nomClient, c.prenomClient
from Clients C
join Locations L on C.idClient=L.idClient
join Bungalows B on L.idBungalow=B.idBungalow
join Campings Ca on Ca.idCamping=B.idCamping
where C.villeClient=Ca.villeCamping

R41
select nomEmploye
from Employes E
where not exists (select*
							from Campings C
							where E.idCamping=C.idCamping)
R42
select count(B.idBungalow) as "NB Bungalows"
from Bungalows B
join Locations L on B.idBungalow=L.idBungalow
join Clients C on L.idClient=C.idClient
where nomClient='Zeblouse' and prenomClient='Agathe'

R43
/* Marche pas */
select nomClient, prenomClient
from Clients 
minus
select nomClient, prenomClient
from Clients C 
join Locations L on L.idClient=C.idClient
join Bungalows B on L.idBungalow=B.idBungalow
join Campings CA on B.idCamping=CA.idCamping
where nomCamping='Les Flots Bleus'


TD4

R5A
select categorieService, count(idservice)
from Services 
group by categorieService

R5B
select villeClient
from Clients
group by villeClient
having count(villeClient)>=3

R50
select nomClient, prenomClient, count(idLocation) as "Nb Location"
from Clients C
join Locations L on C.idClient=L.idClient
group by C.idClient, nomClient, prenomClient
order BY  count(idLocation) DESC

R51
select nomCamping, AVG(salaireEmploye)
from Campings C
join Employes E on C.idCamping=E.idCamping
group by C.idCamping, nomCamping

R52
select nomCamping
from Campings C
join Employes E on C.idCamping=E.idCamping
group by C.idCamping, nomCamping
having count(idEmploye)>3

R53
select nomCamping
from Campings C
join Employes E on C.idCamping=E.idCamping
group by C.idCamping, nomCamping
having AVG(SalaireEmploye)>1400

R54
select nomCamping
from Campings C
Join Bungalows B on C.idCamping=B.idCamping
where superficieBungalow<65
group by C.idCamping, nomCamping
order by count(superficieBungalow)

R55
/* Aussi en comptant et not exist */
select nomCamping
from Campings C
join Employes E on C.idCamping=E.idCamping
group by C.idCamping, nomCamping
having min(salaireEmploye)>=1000



R56
Select nomBungalow
from Bungalows B 
join Proposer P on B.idBungalow=P.idBungalow
group by B.idBungalow, nomBungalow
having count(P.idservice) = (select count(idservice) 
							from Bungalows B 
							join Proposer P on B.idBungalow=P.idBungalow
							where nomBungalow='Le Royal')

R57
/* Left permet d'avoir les 0*/
select nomBungalow, count(idservice) as "Nb Services"
from Bungalows B 
Left join Proposer P on B.idBungalow=P.idBungalow
group by B.idBungalow, nomBungalow
order by count(idservice) DESC


R58
/*Marche pas*/
select nomBungalow, nomCamping
from Bungalows B
join Campings C on  b.idCamping=C.idCamping
join Locations L on B.idBungalow=L.idBungalow
where dateDebut<='30/06/2017' and dateFin>='01/06/2017'
group by B.idBungalow, nomBungalow, nomCamping
having count(idLocation)>2

R59
select nomBungalow
from Bungalows B
join Proposer P on B.idBungalow=P.idBungalow
group by B.idBungalow, nomBungalow
having count(p.idservice)= (select max(count(idService))
							from Bungalows B
							join Proposer P on B.idBungalow=P.idBungalow
							group by B.idBungaloW)
select nomBungalow
from Bungalows B
join Proposer P on B.idBungalow=P.idBungalow
group by B.idBungalow, nomBungalow
having count(p.idservice)= (select max(count(idService))
							from Proposer 
							group by idBungaloW)


R70
SELECT nomBungalow, B.idBungalow FROM Bungalows B
JOIN Proposer P ON B.idBungalow=P.idBungalow
GROUP BY nomBungalow, B.idBungalow
HAVING COUNT(*) = (SELECT COUNT(*) FROM Services) ;


select nomBungalow from Bungalows B
where B.idBungalow=(
SELECT   Distinct P.idBungalow
from Proposer P
WHERE NOT EXISTS ​
 	(SELECT A.idservice FROM Services A 
 MINUS ​
	SELECT V.idservice  FROM Proposer V WHERE V.idBungalow =  P.idBungalow)​)

R71

select nomBungalow 
from Bungalows B
where B.nomBungalow=(select)



SELECT nomBungalow FROM Bungalows B
JOIN Proposer P ON B.idBungalow=P.idBungalow
GROUP BY nomBungalow
HAVING COUNT(*) = (SELECT COUNT(*) FROM Services where categorieService='Luxe') ;