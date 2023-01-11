with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

PACKAGE arbre IS

    C_Max_nom : constant Integer := 50; --Taille maximale d'un nom de fichier/dossier
    
    TYPE T_fichier;
    TYPE T_tab_perm is array(1..10) of Character;

    TYPE T_arbre is ACCESS T_fichier; -- Pointeur sur fichier ou dossier
    TYPE T_noeud is 
        RECORD

            Nom : String(1..C_Max_nom); -- Nom du fichier/dossier
            Taille : Integer;           -- Taille du fichier/dossier
            Permission : T_tab_perm;    -- Permissions du fichier/dossier

            Parent : T_arbre;   -- Pointeur sur le parent
            Fils : T_arbre;     -- Pointeur sur le fils
            Frere : T_arbre;    -- Pointeur sur un frère
            Contenu : Unbounded_string;

        END RECORD;

    Function creation return T_arbre;
    -- Sémantique: Créer un arbre vide
    -- Paramètres : aucun
    -- type-retour : T_arbre
    -- pré-condition : aucune
    -- post-condtion : arbre crée vide
    -- exception : aucune

    Procedure ajout( liste : in out T_arbre); 
    -- Sémantique : Ajouter un noeud dans la liste chainée et faire pointer le liste vers ce nouveau noeud.
    -- Paramètres : liste : in out type T_liste
    -- Pré-condition : aucune
    -- Post-condition : liste pointe sur le nouveau noeud
    -- exception : aucune


    Procedure recheche();
    Procedure supprimer();
    Procedure modifier();


END arbre;
