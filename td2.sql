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

/*
select nomBungalow 
from Bungalows B
where B.idBungalow=(
		SELECT Distinct P.idBungalow
		from Proposer P
		WHERE NOT EXISTS ​
			 	(SELECT idservice FROM Services 
			 MINUS ​
				SELECT P.idservice  FROM Proposer P WHERE P.idBungalow =  B.idBungalow)​)
*/
select nomBungalow
from Bungalows B
where not EXISTS (select se.idService from Services se
					minus
				  select S.idservice from services S
					join proposer p on s.idservice=p.idservice
					where p.idbungalow=B.idbungalow)

select nomBungalow
from Bungalows B
where not EXISTS (select se.idService from Services se
					minus
				  select p.idservice 
				  from proposer p 
				  where p.idbungalow=B.idbungalow)


R71




SELECT nomBungalow 
FROM Bungalows B
	join proposer p on b.idBungalow=p.idBungalow
	join services s on p.idservice=s.idservice
where categorieService='Luxe'
GROUP BY b.idBungalow, nomBungalow
HAVING COUNT(*) = (SELECT COUNT(*) FROM Services where categorieService='Luxe') ;


select nomBungalow
from Bungalows B
where not exists (		select idservice 
						from services
						where categorieService='Luxe'
					minus
						select p.idservice
						from proposer p
						where  p.idbungalow=B.idbungalow )

R72

select nomBungalow
from Bungalows B 
where not exists (select S.idservice 
					from services S 
					join proposer p on S.idservice=p.idService
					join Bungalows Bi on p.idBungalow=Bi.idBungalow
					where nomBungalow='La Poubelle'

					minus 

				select p.idservice 
					from proposer p
					where p.idbungalow=b.idbungalow
					)

R73
select nomClient 
from Clients c
where not exists (select villeCamping
					from Campings
				minus
				  select villeCamping
				  from Campings C
				  join Bungalows B on C.idCamping=B.idCamping
				  join Locations L on B.idBungalow=L.idBungalow
				  where c.idClient=L.idClient)

R74

select nomClient
from Clients C
where not exists (select Bu.idBungalow
					from Bungalows Bu
					 join Locations L on Bu.idBungalow=L.idBungalow
					 join Clients Cl on Cl.idClient=L.idClient
					  where nomClient='Zeblouse'
				minus

				 select B.idBungalow
				 from Bungalows B
 					 join Locations L on B.idBungalow=L.idBungalow
					 join Clients Cl on Cl.idClient=L.idClient
				 		where c.idClient=Cl.idClient )

R75 /* A refaire */
SELECT nomClient, prenomClient
FROM Clients c1 
WHERE NOT EXISTS (SELECT idCamping                   
					FROM Bungalows b                        
					JOIN Locations l ON l.idBungalow = b.idBungalow                        
					JOIN Clients c ON c.idClient = l.idClient                   
					WHERE nomClient = 'Zeblouse' AND prenomClient = 'Agathe'                  
				MINUS                   
					SELECT idCamping                   
					FROM Bungalows b                        
					JOIN Locations l ON l.idBungalow = b.idBungalow                   
					WHERE l.idClient = c1.idClient)
					AND NOT EXISTS (
						SELECT idCamping                 
						FROM Bungalows b                      
						JOIN Locations l ON l.idBungalow = b.idBungalow                 
						WHERE l.idClient = c1.idClient                
					MINUS                 
						SELECT idCamping                 
						FROM Bungalows b                      
						JOIN Locations l ON l.idBungalow = b.idBungalow                      
						JOIN Clients c ON c.idClient = l.idClient                 
						WHERE nomClient = 'Zeblouse' AND prenomClient = 'Agathe'); 

R81, /*%marche pas*/
select idClient, nomClient, prenomClient
from Clients c
where not exists (select idCamping
				  from Campings 
				  where villeCamping='Palavas'
				  minus
				  SELECT idCamping
				  FROM Campings ca
				  join Bungalows B on ca.idCamping=B.idCamping
				  join Locations L on B.idBungalow=L.idBungalow
				  where L.idClient=c.idClient)

R82,
select Distinct nomService
from services s
join proposer p on s.idservice=p.idservice
join Bungalows b on p.idBungalow=b.idBungalow
join Campings c on b.idCamping=c.idCamping
where nomCamping='Les Flots Bleus' and
superficieBungalow =(select max(superficieBungalow)
	from Bungalows bu
	join Campings ca on bu.idCamping=ca.idCamping
	where nomCamping='Les Flots Bleus')

R83,
pour chaque bungalow, indiquer le nombre de locations qui ont eu lieu en juin 2017
select nomBungalow, count(idLocation) as Nb_de_Location
from bungalows B
LEFT OUTER JOIN locations l on l.idBungalow = b.idBungalow
and dateFin>='01/06/2017' and dateDebut<='30/06/2017'
group by b.idBungalow, nomBungalow 
order by count(idLocation) DESC


SELECT nomBungalow, COUNT(*) AS "nb locations"  
FROM Bungalows b      
JOIN Locations l ON l.idBungalow = b.idBungalow  
WHERE dateDebut <= '30/06/2017'  AND dateFin >= '01/06/2017'  
GROUP BY b.idBungalow, nomBungalow 
UNION  
SELECT nomBungalow, 0 AS "nb locations"  
FROM Bungalows b  
WHERE NOT EXISTS (SELECT *                    
					FROM Locations l                    
					WHERE dateDebut <= '30/06/2017'                    
					AND dateFin >= '01/06/2017'                    
					AND l.idBungalow = b.idBungalow) 
ORDER BY "nb locations" DESC; 

R84,
les villes dans lesquelles il y a plusieurs campings. 
select villeCamping
from campings c
group by villeCamping
having count(*)>1

R85,
le nom des clients qui ont réalisé le même nombre 
de locations que le client Agathe Zeblouse (il n’y a qu’un seul client qui se nomme Agathe Zeblouse)

Select NomClient, count(l.idLocation)
from Clients c
join locations l on c.idClient=l.idClient
group by c.idClient, nomClient

Select nomClient
from Clients c
join locations l on c.idClient=l.idClient
having count(l.idLocation)=(Select count(l.idLocation)
							from Clients cl
							join locations l on cl.idClient=l.idClient
							where nomClient='Zeblouse'
							group by cl.idClient, nomClient)
group by c.idClient, nomClient

SELECT nomClient 
FROM Clients c      
JOIN Locations l ON c.idClient = l.idClient 
GROUP BY c.idClient, nomClient 
HAVING COUNT(*) = (SELECT COUNT(*)                    
					FROM Locations l                         
					JOIN Clients c ON l.idClient = c.idClient                    
					WHERE nomClient = 'Zeblouse'                    
					AND prenomClient = 'Agathe'); 
R86,
le nom des services qui sont proposés dans moins de cinq bungalows. 

select nomService
from Services s
join proposer p on s.idservice=p.idservice
group by s.idservice, nomService 
having count(p.idbungalow)<5

SELECT nomService 
FROM Services s      
LEFT OUTER JOIN Proposer p ON p.idService = s.idService 
GROUP BY s.idService, nomService 
HAVING COUNT(idBungalow) < 5; 

R87, 
le nom du camping qui a le plus d’employés. 

select nomCamping
from campings c
join employes e on c.idCamping=e.idcamping
group by c.idCamping, nomCamping
having count(idEmploye)=(SELECT MAX(COUNT(*))                   
						FROM Employes                    
						GROUP BY idCamping);

R88, refaire
SELECT nomBungalow 
FROM Bungalows b      
JOIN Proposer p ON b.idBungalow = p.idBungalow      
JOIN Services s ON p.idService = s.idService 
GROUP BY b.idBungalow, nomBungalow 
HAVING COUNT(DISTINCT categorieService) = (SELECT COUNT(DISTINCT categorieService)                                           
											 FROM Services); 

R89, refaire
SELECT nomBungalow 
FROM Bungalows b1 
WHERE NOT EXISTS (SELECT idService                   
				FROM Bungalows b                       
				JOIN Proposer p ON b.idBungalow = p.idBungalow                   
				WHERE nomBungalow = 'La Suite Régalienne'                  
				MINUS                   
				SELECT idService                   
				FROM Proposer p                   
				WHERE p.idBungalow = b1.idBungalow) AND NOT EXISTS (SELECT idService                 
																	FROM Proposer p                 
																	WHERE p.idBungalow = b1.idBungalow               
																	 MINUS                 
																	SELECT idService                 
																	FROM Bungalows b                      
																	JOIN Proposer p ON b.idBungalow = p.idBungalow                
																	WHERE nomBungalow = 'La Suite Régalienne'); 
R70,
select nomBungalow
from Bungalows B

where not exists(select idService
				from Services S

				minus
				select idService
				from Services S
				join Proposer P on p.idService=s.idService
				where B.idbungalow=P.idbungalow
				)