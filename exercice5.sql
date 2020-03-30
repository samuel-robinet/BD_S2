R70
SELECT nomBungalow, B.idBungalow FROM Bungalows B
JOIN Proposer P ON B.idBungalow=P.idBungalow
GROUP BY nomBungalow, B.idBungalow
HAVING COUNT(*) = (SELECT COUNT(*) FROM Services) ;


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

/*
Select NomClient, count(l.idLocation)
from Clients c
join locations l on c.idClient=l.idClient
group by c.idClient, nomClient 
*/

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


Les vues :
	DROP VIEW
	TEST :
	CREATE VIEW TousLesClients(nom, prenom) AS
	SELECT nomClient, prenomClient
	FROM Clients; 

R1;
CREATE VIEW BUNGALOWSLFB(idBungalow, nomBungalow, superficieBungalow) as
select idBungalow, nomBungalow, superficieBungalow
from bungalows b 
JOIN Campings C ON b.idcamping=C.idCamping
where nomCamping='Les Flots Bleus'

Select count(idBungalow)
from BUNGALOWSLFB

R2;
CREATE VIEW LOCATIONSLFB (idLocation, idClient, nomClient, prenomClient, idBungalow, nomBungalow) 
select idLocation, c.idClient, nomClient, prenomClient, b.idBungalow, nomBungalow
from Locations l
join Bungalows b on l.idBungalow=b.idBungalow
join Clients c on l.idClient=c.idClient
JOIN Campings C ON b.idcamping=C.idCamping
where nomCamping='Les Flots Bleus'

select count(idLocation)
from LOCATIONSLFB
