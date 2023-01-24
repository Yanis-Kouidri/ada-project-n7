with Ada.Integer_Text_IO, Ada.Text_IO ;
use Ada.Integer_Text_IO, Ada.Text_IO ;
with Ada.Unchecked_Deallocation ; 

package body P_Commande is 


    -- Instantiation des fonctions et procédures :





    -- Définition des fonctions et procédures :

----------------------------------------------------------------------
    procedure P_Ls (P_Dossier : in T_Arbre) is
    begin
        if P_Dossier /= null then
            if P_Dossier.all.fils /= null then
                Afficher_dos(P_Dossier);
            else
                Put_Line("Dossier vide");
            end if;
        else
            Put_Line("Dossier non trouvé");
        end if;
            
    end P_ls;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_Mkdir (P_Dest : in T_Arbre ; P_Nom : in String) is
    begin
        if P_Dest /= null then
            Ajouter_Dans_Dos (P_Dest, P_Nom, True);

        else
            Put_Line("Lieu de création introuvable");
        end if;
        
    end P_mkdir;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_Touch (P_Dest : in T_Arbre ; P_Nom : in String) is
    begin
        if P_Dest /= null then
            Ajouter_Dans_Dos (P_Dest, P_Nom, False);

        else
            Put_Line("Lieu de création introuvable");
        end if;
    end P_Touch;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_Cd (P_Courant : in out T_Arbre ; P_Chemin : in String) is 
        Dest : T_Arbre := null;
    begin
        Dest := Descendre (P_Courant, P_Chemin);
        if Dest /= null then

            if Est_Dossier (Dest) then
                P_Courant := Dest;
            else
                Put_Line ("La destination n'est pas un dossier");
            end if;

        else
            Put_Line("La destination n'existe pas");
        end if;


    end P_Cd;
----------------------------------------------------------------------
        

end P_Commande ;
