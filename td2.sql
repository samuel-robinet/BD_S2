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
Select nomBungalow
from Bungalows B
join Proposer P on B.idBungalow=P.idBungalow
join Services S on P.idservice=S.idservice
where idservice not in(select idService 
	='Climatisation'