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
