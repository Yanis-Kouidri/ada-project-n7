with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Liste_gen;

package P_Arbre is


    package P_Liste_Ustring is new P_Liste_Gen(Type_Element => Unbounded_String); use P_Liste_Ustring;


    type T_Fichier;
    type T_Tab_Perm is array(1..10) of Character;

    type T_Arbre is ACCESS T_Fichier; -- Pointeur sur fichier ou dossier
    type T_Fichier is 
        RECORD

            Nom : Unbounded_String; -- Nom du fichier/dossier
            Taille : Integer;           -- Taille du fichier/dossier
            Permission : T_Tab_Perm;    -- Permissions du fichier/dossier

            Parent : T_Arbre;   -- Pointeur sur le parent
            Frere : T_Arbre;    -- Pointeur sur un frère
            Fils : T_Arbre;     -- Pointeur sur le fils
            Contenu : Unbounded_String;

        END RECORD;

    -- Définition des exceptions :
    Null_Ptr_Exception : exception;


    -- Déclaration des fonction et Procédure :

--------------------------------------------------
    -- Decoupage
    --
    -- Sémantique : Découper un Chaine de caractère en fonction d'un caractère spécifique.
    --
    -- Paramètres : 
    --      F_Chaine : Entrée String ; Chaine de caractères à découper.
    --      F_Cible : Entrée Character ; Caractère qui va définir le découpage de la liste.
    --
    -- Retour :
    --      Type : P_Liste_Ustring.T_Liste_Chainee ; Liste chainée de unbounded string, chaque T_Cellule de la liste chainée contient un mot découpé de F_Chaine.
--------------------------------------------------
    function Decoupage (F_Chaine : in String ; F_Cible : in Character) return P_Liste_Ustring.T_Liste_Chainee;

--------------------------------------------------
    -- Existe
    --
    -- Sémantique : Vérifie si un chemin existe dans l'Arbre en fonction d'un point d'entrée dans l'Arbre et d'une liste chainéé
    --
    -- Paramètres : 
    --      F_Chemin : Entrée P_Liste_Ustring.T_Liste_Chainee ; Liste chainée indiquant le chemin a tester
    --      F_Entree : Entrée T_Arbre ; Point d'entrée dans l'Arbre où le chemin sera tester.
    --
    -- Retour :
    --      Type : Boolean ; vrai si le chemin existe, faux sinon
--------------------------------------------------
    function Existe (F_Chemin : in P_Liste_Ustring.T_Liste_Chainee ; F_Entree : in T_Arbre) return Boolean;

--------------------------------------------------
    -- Ajouter
    --
    -- Sémantique : Ajoute un dossier ou un fichier à l'arbre. 
    --
    -- Paramètres : 
    --      F_Endroit : Entrée Pointeur sur T_Arbre , Là où l'on souhaite ajouter un dossier/fichier à l'arbre
    --      F_Nom : Nom du nouveau fichier/dossier.
    --      F_Est_Dossier : Entrée Booléen ; Défini s'il s'agit d'un dossier où d'un fichier.
    --      F_Parent : Entrée Pointeur sur T_Arbre ; Parent du fichier/dossier. Null si racine
    --
    -- Retour :
    --      Type : Booléen ; vrai si le chemin existe, faux sinon
    --
    -- Préconditions :
    --      F_Endroit = null;
    --      F_Nom non vide;
--------------------------------------------------
    procedure Ajouter (F_Endroit : in out T_Arbre ; F_Nom : in String ; F_Est_Dossier : in Boolean ; F_Parent : in T_Arbre);
    
    procedure Afficher_Un (F_Endroit : in T_Arbre); 

    procedure Afficher_dos (F_Parent : in T_Arbre);

    procedure Ajouter_Dans_Dos (F_Parent : in T_Arbre ; F_Nom : in String ; F_Est_Dossier : in Boolean );
    
    procedure Afficher_Frere (F_Frere: in T_Arbre);
    
--------------------------------------------------
    -- Fonction de test et débbugage :
--------------------------------------------------
    procedure Test_Decoupage (F_Chaine : in String ; F_Cible : in Character);

--    Procedure recheche();
--    Procedure supprimer();
--    Procedure modifier();


end P_Arbre;
