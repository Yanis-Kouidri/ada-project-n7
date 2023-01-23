with Ada.Integer_Text_IO, Ada.Text_IO ;
use Ada.Integer_Text_IO, Ada.Text_IO ;
with Ada.Unchecked_Deallocation ; 

package body P_Commande is 


    -- Instantiation des fonctions et procédures :





    -- Définition des fonctions et procédures :

----------------------------------------------------------------------
    procedure P_ls (F_Dossier : in T_Arbre) is
    begin
        if F_Dossier /= null then
            if F_Dossier.all.fils /= null then
                Afficher_dos(F_Dossier);
            else
                Put_Line("Dossier vide");
            end if;
        else
            Put_Line("Dossier non trouvé");
        end if;
            
    end P_ls;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_mkdir (F_Dest : in T_Arbre ; F_Nom : in String) is
    begin
        if F_Dest /= null then
            Ajouter_Dans_Dos (F_Dest, F_Nom, True);

        else
            Put_Line("Lieu de création introuvable");
        end if;
        
    end P_mkdir;
----------------------------------------------------------------------


----------------------------------------------------------------------
----------------------------------------------------------------------


----------------------------------------------------------------------
----------------------------------------------------------------------
        

end P_Commande ;
