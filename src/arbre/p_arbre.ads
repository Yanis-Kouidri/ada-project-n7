with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Liste_gen;

package P_Arbre is

    C_Max_Nom : constant Integer := 50; --Taille maximale d'un nom de fichier/dossier
    

    package P_Liste_Ustring is new P_Liste_Gen(Type_Element => Unbounded_String); use P_liste_Ustring;


    type T_Fichier;
    type T_Tab_Perm is array(1..10) of Character;

    type T_Arbre is ACCESS T_Fichier; -- Pointeur sur fichier ou dossier
    type T_Fichier is 
        RECORD

            Nom : String(1..C_Max_Nom); -- Nom du fichier/dossier
            Taille : Integer;           -- Taille du fichier/dossier
            Permission : T_Tab_Perm;    -- Permissions du fichier/dossier

            Parent : T_arbre;   -- Pointeur sur le parent
            Frere : T_arbre;    -- Pointeur sur un frère
            Fils : T_arbre;     -- Pointeur sur le fils
            Contenu : Unbounded_string;

        END RECORD;

--    Function creation(F_nom : in String ; est_dossier : in boolean) return T_arbre;
    -- Sémantique: Créer un nouveau fichier ou dossier 
    -- Paramètres : aucun
    -- type-retour : T_arbre
    -- pré-condition : aucune
    -- post-condtion : nouveau T_fichier ajouté à l'arbre
    -- exception : aucune

 --   Procedure Ajouter( arbre : in out T_arbre); 
    -- Sémantique : 
    -- Paramètres : arbre : in out type T_arbre
    -- Pré-condition : aucune
    -- Post-condition : 
    -- exception : aucune

--------------------------------------------------
    -- Decoupage
    --
    -- Sémantique : Découper un chaine de caractère en fonction d'un caractère spécifique.
--------------------------------------------------

    Function Decoupage (F_chaine : in String ; F_cible : in Character) return P_liste_ustring.T_liste_chainee;


--    Procedure recheche();
--    Procedure supprimer();
--    Procedure modifier();


end P_Arbre;
