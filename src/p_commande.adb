with Ada.Unchecked_Deallocation ; 
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body P_Commande is 


    -- Instantiation des fonctions et procédures :
    procedure Free is new Ada.Unchecked_Deallocation(T_Fichier, T_Arbre) ; -- Pour libérer de la mém    oire




    -- Définition des fonctions et procédures :

----------------------------------------------------------------------
    procedure P_Ls (P_Dossier : in T_Arbre) is
    begin
        if P_Dossier /= null then

            if P_Dossier.all.Fils /= null then
                Afficher_Dos (P_Dossier);

            else
                raise Dos_Vide_Erreur;

            end if;
            
        else
            raise Fichier_Non_Trouve_Erreur;

        end if;
            
    end P_ls;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_Ll (P_Dossier : in T_Arbre) is
    begin
        if P_Dossier /= null then
            if P_Dossier.all.Fils /= null then
                Put_Line("[Droits]      [Taille]  [Nom]");
                Afficher_Detail (P_Dossier.all.Fils);
            else
                raise Dos_Vide_Erreur;
            end if;
        else
            raise Fichier_Non_Trouve_Erreur;
        end if;


    end P_Ll;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_Mkdir (P_Courant : in T_Arbre ; P_Nom : in String) is
    begin
        if not Existe_Fils (P_Courant.all.Fils, P_Nom) then
            Ajouter_Dans_Dos (P_Courant, P_Nom, True);
        else
            raise Fich_Deja_Existant_Erreur;
        end if;
        
    end P_mkdir;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_Touch (P_Courant : in T_Arbre ; P_Nom : in String) is
    begin
        if not Existe_Fils (P_Courant.all.Fils, P_Nom) then
            Ajouter_Dans_Dos (P_Courant, P_Nom, False);
        else
            raise Fich_Deja_Existant_Erreur;
        end if;

    end P_Touch;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_Cd (P_Courant : in out T_Arbre ; P_Chemin : in String) is 
        Dest : T_Arbre := null;
    begin
        -- Cas particulier :
        if P_Chemin = ".." then
            Dest := Monter (P_Courant);
            if Dest /= null then
                P_Courant := Dest;
            else
                raise Racine_Atteinte_Erreur;
            end if;

        -- Cas général :
        else
            Dest := Descendre (P_Courant, P_Chemin);
            if Dest /= null then

                if Est_Dossier (Dest) then
                    P_Courant := Dest;
                else
                    raise Pas_Un_Dossier_Erreur;
                end if;

            else
                raise Fichier_Non_Trouve_Erreur;
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
        Cible, Temp, A_Supp : T_Arbre := null;

    begin
        A_Supp := Descendre (P_Courant, P_A_Supp);

        -- On vérifie s'il existe :
        if A_Supp = null then
            raise Fichier_Non_Trouve_Erreur;
        end if;

        -- On vérifie s'il est vide
        if Est_Dossier_Plein (A_Supp) then
            raise Dos_Non_Vide_Erreur;
        end if;

        Cible := P_Courant.all.Fils;

        -- Cas où le fichier a supp est le premier frère
        if P_Courant.all.Fils.all.Nom = P_A_Supp then
            P_Courant.all.Fils := Cible.all.Frere;
            Free (Cible);
        else
            while Cible.all.Frere.all.nom /= P_A_Supp loop
                Cible := Cible.all.Frere;

            end loop; 
            Temp := Cible.all.Frere;
            Cible.all.Frere := Cible.all.Frere.all.Frere;
            Free (Temp);
        end if;

    end P_Rm;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_Cp (P_Courant : in T_Arbre ; P_A_Copier, P_Nouv_Nom : in String) is
        A_Copier : T_Arbre := null;
    begin
        if Existe_Fils (P_Courant.all.Fils, P_Nouv_Nom) then
            raise Fich_Deja_Existant_Erreur;
        end if;

        -- Je vérifie si le fichier existe
        if Existe_Fils (P_Courant.all.Fils, P_A_Copier) then

            -- Je récupère un pointeur sur mon fichier à copier
            A_Copier := Descendre (P_Courant, P_A_Copier);

            if Est_Dossier_Plein (A_Copier) then
                raise Dos_Non_Vide_Erreur;
            else
                -- Je copie.
                Copier (A_Copier, P_Nouv_Nom);
            end if;

        else
            raise Fichier_Non_Trouve_Erreur;
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
            raise Fichier_Non_Trouve_Erreur;
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
            raise Fichier_Non_Trouve_Erreur;

        end if;

    end P_Vi;
----------------------------------------------------------------------



----------------------------------------------------------------------
    procedure P_Mv (P_Courant : in T_Arbre ; P_A_Modif, P_Nouv_Nom : in String) is 
        Fichier : T_Arbre := null;
    begin
        Fichier := Descendre (P_Courant, P_A_Modif);

        if Fichier /= null then
            Fichier.all.Nom := To_Unbounded_String (P_Nouv_Nom);
        else
            raise Fichier_Non_Trouve_Erreur;
        end if;

    end P_Mv;
----------------------------------------------------------------------


----------------------------------------------------------------------
    procedure P_Tar (P_Courant : in T_Arbre ; P_Dossier : in String) is
        Somme_Taille : integer := 0; --Somme des tailles
        A_Archiver, Archive : T_Arbre := null;
    begin
        A_Archiver := Descendre (P_Courant, P_Dossier);
        Archive := Descendre (P_Courant, P_Dossier & ".tar");

        if A_Archiver = null then
            raise Fichier_Non_Trouve_Erreur;
        end if;

        if not Est_Dossier (A_Archiver) then
            raise Pas_Un_Dossier_Erreur;
        end if;

        if Archive /= null then
            raise Fich_Deja_Existant_Erreur;
        end if;

        Somme_Taille := Somme_Taille_Dos (A_Archiver);
        Ajouter_Dans_Dos (P_Courant, P_Dossier & ".tar", false);

        Archive := Descendre (P_Courant, P_Dossier & ".tar");
        Archive.all.Taille := Somme_Taille;


    end P_Tar;
----------------------------------------------------------------------

end P_Commande ;
