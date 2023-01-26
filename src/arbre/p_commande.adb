with Ada.Integer_Text_IO, Ada.Text_IO ;
use Ada.Integer_Text_IO, Ada.Text_IO ;
with Ada.Unchecked_Deallocation ; 

package body P_Commande is 


    -- Instantiation des fonctions et procédures :
    procedure Free is new Ada.Unchecked_Deallocation(T_Fichier, T_Arbre) ; -- Pour libérer de la mém    oire




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
        if P_Chemin = ".." then
            Dest := Monter (P_Courant);
            if Dest /= null then
                P_Courant := Dest;
            else
                Put_Line("Racine atteinte");
            end if;

        else
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
        end if;


    end P_Cd;
----------------------------------------------------------------------
        

----------------------------------------------------------------------
    procedure P_Pwd (P_Courant : in T_Arbre) is
    begin
        if P_courant /= null then

            P_Pwd (P_Courant.all.Parent);
            Put (To_String (P_Courant.all.Nom) & "/");
        end if;

    end P_Pwd;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_Rm (P_Courant : in T_Arbre ; P_A_Supp : in String) is
        Cible, temp, test_doss : T_Arbre := null;
        Valide : Boolean := False;

    begin
        -- On vérifie s'il existe :
        if Existe_Fils (P_Courant.all.Fils, P_A_Supp) then
            test_doss := Descendre (P_Courant, P_A_Supp);

            if Est_Dossier (test_doss) then
                if test_doss.all.fils = null then
                    Valide := true;
                else
                    Valide := false;
                    Put_Line("Le dossier doit être vide");
                end if;

            else
                Valide := true;
            end if;
        else
            Valide := false;
            Put_Line("Le fichier/dossier n'existe pas");
        end if;


        if Valide then

            Cible := P_Courant.all.Fils;

            -- Cas où le fichier a supp est le premier frère
            if P_Courant.all.Fils.all.Nom = P_A_Supp then
                P_Courant.all.Fils := Cible.all.Frere;
                Free(Cible);
            else
                while Cible.all.Frere.all.nom /= P_A_Supp loop
                    Cible := Cible.all.Frere;

                end loop; 
                temp := cible.all.Frere;
                Cible.all.frere := Cible.all.frere.all.frere;
                Free (temp);
            end if;

        end if;

    end P_Rm;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_Cp (P_Courant : in T_Arbre ; P_A_Copier, P_Nouv_Nom : in String) is
        A_Copier : T_Arbre := null;
    begin

        -- Je vérifie si le fichier existe
        if Existe_Fils (P_Courant.all.Fils, P_A_Copier) then

            -- Je récupère un pointeur sur mon fichier à copier
            A_Copier := Descendre (P_Courant, P_A_Copier);

            if Est_Dossier_Plein (A_Copier) then
                    Put_Line ("Impossible de copier un dossier non vide");
            else
                -- Je copie.
                Copier (A_Copier, P_Nouv_Nom);
            end if;
                


        else
            Put_Line("Le fichier n'existe pas");
        end if;

    end P_Cp;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_Cat (P_Dossier : in T_Arbre ; P_Fichier : in String) is
        Fichier : T_Arbre := null;
    begin
        Fichier := Descendre (P_Dossier, P_Fichier);
        if Fichier /= null then

            if not Est_Dossier(Fichier) then
                Put_Line (To_String (Fichier.all.Contenu));

            else
                raise Pas_Un_Fichier_Erreur;
            end if;
        else
            raise Fichier_Inexistant_Erreur;
        end if;

    end P_Cat;
----------------------------------------------------------------------


    
----------------------------------------------------------------------
    procedure P_Vi (P_Courant : in T_Arbre ; P_Fichier : in String) is
        Fichier : T_Arbre := null;
        Nouv_contenu : Unbounded_String;

    begin
        Fichier := Descendre (P_Courant, P_Fichier);

        if Fichier /= null then

            if not Est_Dossier (Fichier) then
                Nouv_contenu := To_Unbounded_String (Get_Line);
                Fichier.all.Contenu := Fichier.all.Contenu & Nouv_contenu;
                Fichier.all.Taille := Length (Fichier.all.Contenu);

            else 
                raise Pas_Un_Fichier_Erreur;

            end if;

        else
            raise Fichier_Inexistant_Erreur;

        end if;

    end P_Vi;
----------------------------------------------------------------------

end P_Commande ;
