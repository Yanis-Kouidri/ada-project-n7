with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

PACKAGE arbre IS

    C_Max_nom : constant Integer := 50; --Taille maximale d'un nom de fichier/dossier
    
    TYPE T_fichier;
    TYPE T_tab_perm is array(1..10) of Character;

    TYPE T_arbre is ACCESS T_fichier; -- Pointeur sur fichier ou dossier
    TYPE T_fichier is 
        RECORD

            Nom : String(1..C_Max_nom); -- Nom du fichier/dossier
            Taille : Integer;           -- Taille du fichier/dossier
            Permission : T_tab_perm;    -- Permissions du fichier/dossier

            Parent : T_arbre;   -- Pointeur sur le parent
            Frere : T_arbre;    -- Pointeur sur un frère
            Fils : T_arbre;     -- Pointeur sur le fils
            Contenu : Unbounded_string;

        END RECORD;

    Function creation(F_nom : in String ; est_dossier : in boolean) return T_arbre;
    -- Sémantique: Créer un nouveau fichier ou dossier 
    -- Paramètres : aucun
    -- type-retour : T_arbre
    -- pré-condition : aucune
    -- post-condtion : nouveau T_fichier ajouté à l'arbre
    -- exception : aucune

    Procedure ajout( arbre : in out T_arbre); 
    -- Sémantique : 
    -- Paramètres : arbre : in out type T_arbre
    -- Pré-condition : aucune
    -- Post-condition : 
    -- exception : aucune


--    Procedure recheche();
--    Procedure supprimer();
--    Procedure modifier();


END arbre;
