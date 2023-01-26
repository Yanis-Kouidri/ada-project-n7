with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Liste_gen;

package P_Arbre is


    package P_Liste_Ustring is new P_Liste_Gen(Type_Element => Unbounded_String); 
    use P_Liste_Ustring;


    type T_Fichier;
    type T_Tab_Perm is array(1..10) of Character;

    type T_Arbre is access T_Fichier; -- Pointeur sur fichier ou dossier
    type T_Fichier is 
        record

            Nom : Unbounded_String; -- Nom du fichier/dossier
            Taille : Integer;           -- Taille du fichier/dossier
            Permission : T_Tab_Perm;    -- Permissions du fichier/dossier

            Parent : T_Arbre;   -- Pointeur sur le parent
            Frere : T_Arbre;    -- Pointeur sur un frère
            Fils : T_Arbre;     -- Pointeur sur le fils
            Contenu : Unbounded_String;

        end record;

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


-------------------------------------------------
    -- Recup_Commande
    --
    -- Sémantique : A partir d'une commande complète, renvoie uniquement le premier mot
    --              Ex : A partir de "ls -l -r -a" renvoie : "ls".
    --
    -- Paramètres : 
    --      F_Chaine : Entrée String ; Chaine de caractères à découper.
    --
    -- Retour :
    --      Type : String ; Premier mot de la chaine de caractère passée en paramètre.
--------------------------------------------------
    function Recup_Commande (F_Chaine : in String) return String;


-------------------------------------------------
    -- Recup_Arg
    --
    -- Sémantique : A partir d'une commande complète, renvoie uniquement l'argument numéro F_Arg_nb
    --              Ex : A partir de "ls -l -r -a" et 2 renvoie : "-r".
    --              Ex : A partir de "ls -l -r -a" et 1 renvoie : "-l".
    --
    -- Paramètres : 
    --      F_Chaine : Entrée String ; Chaine de caractères à découper.
    --      F_Arg_Nb : Entrée Entier ; Numéro de l'argument à récupérer.
    --
    -- Retour :
    --      Type : String ; Argument demandé
--------------------------------------------------
    function Recup_Arg (F_Chaine : in String ; F_Arg_nb : in Integer) return String;

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
    -- Existe_Fils
    --
    -- Sémantique : Cherche dans un dossier si un fils existe en fonction de son nom.
    --              Ex : est ce que le dossier toto contient le fichier/dossier titi.
    --
    -- Paramètres : 
    --      F_Fils : Entrée T_Arbre ; Premier fils du dossier à fouiller
    --      F_Entree : Entrée String ; nom à recherche dans le dossier
    --
    -- Retour :
    --      Type : Boolean ; vrai si le nom existe, faux sinon
--------------------------------------------------
    function Existe_Fils (F_Fils : in T_Arbre ; F_Nom_Fils : in String) return Boolean;


--------------------------------------------------
    -- Ajouter
    --
    -- Sémantique : Ajoute un dossier ou un fichier à l'arbre. 
    --
    -- Paramètres : 
    --      F_endroit : Entrée Pointeur sur T_Arbre , Là où l'on souhaite ajouter un dossier/fichier à l'arbre
    --      F_Nom : Nom du nouveau fichier/dossier.
    --      F_Est_Dossier : Entrée Booléen ; Défini s'il s'agit d'un dossier où d'un fichier.
    --      F_Parent : Entrée Pointeur sur T_Arbre ; Parent du fichier/dossier. Null si racine
    --
    -- Retour :
    --      Type : Booléen ; vrai si le chemin existe, faux sinon
    --
    -- Préconditions :
    --      F_endroit = null;
    --      F_Nom non vide;
--------------------------------------------------
    procedure Ajouter (F_endroit : in out T_Arbre ; F_Nom : in String ; F_Est_Dossier : in Boolean ; F_Parent : in T_Arbre);
    

--------------------------------------------------
    -- Afficher_Un
    --
    -- Sémantique : Affiche le nom du dossier/fichier passer en paramètre
    --
    -- Paramètres :
    --      F_endroit : Entrée T_Arbre ; Pointeur sur T_Fichier à afficher.
    --
    -- Préconditions :
    --      F_endroit /= null
    --      F_endroit.all.Nom initialisé
--------------------------------------------------
    procedure Afficher_Un (F_endroit : in T_Arbre); 

--------------------------------------------------
    -- Afficher_dos
    --
    -- Sémantique : Afficher le contenu d'un dossier passer en paramètre.
    --      Par contenu j'entends le nom de l'ensemble des dossier/fichier que contient le dossier.
    --
    -- Paramètres :
    --      F_Parent : Entrée T_Arbre ; Pointeur sur T_Fichier à afficher.
    --
    -- Préconditions : 
    --      F_Parent =/ null
    --      F_Parent.all.Fils /= null
--------------------------------------------------
    procedure Afficher_dos (F_Parent : in T_Arbre);


--------------------------------------------------
    -- Ajouter_Dans_Dos
    --
    -- Sémantique : Ajoute un fichier/dossier dans un dossier passé en paramètre
    --
    -- Paramètres :
    --      F_Parent : Entrée T_Arbre ; Dossier parent dans lequel ajouter un nouveau T_Arbre
    --      F_Nom : Entrée String ; Nom du nouveau fichier/dossier
    --      F_Est_Dossier : Entrée booléen ; nature du fichier/dossier à ajouter
    --
    -- Préconditions :
    --      F_Parent est un dossier.
    --      F_Nom non vide
--------------------------------------------------
    procedure Ajouter_Dans_Dos (F_Parent : in T_Arbre ; F_Nom : in String ; F_Est_Dossier : in Boolean );

    
--------------------------------------------------
    -- Afficher_Frere
    --
    -- Sémantique : Affiche tous les frères d'un fichier/dossier
    --
    -- Paramètre :
    --      F_Frere : Entrée T_Arbre ; Premier des frères à afficher
    --
    -- Préconditions :
    --      Aucune
--------------------------------------------------
    procedure Afficher_Frere (F_Frere: in T_Arbre);
    

--------------------------------------------------
    -- Est_Dossier
    --
    -- Sémantique : Indique si un élément de l'arbre est un dossier ou non
    --              Si ce n'est pas un dossier c'est donc un fichier. 
    --
    -- Paramètre :
    --      F_Elem : Entrée T_Arbre ; élément de l'arbre à déterminer
    --
    -- Retour :
    --      Type : booléen ; Vrai si c'est un dossier, faux si c'est un fichier
--------------------------------------------------
    function Est_Dossier (F_Elem : in T_Arbre) return boolean;

    
    function Descendre (F_Courant : in T_Arbre ; F_fils : in String) return T_Arbre;

    function Monter (F_Courant : in T_Arbre) return T_Arbre;

    procedure Supprimer (F_Cible : in out T_Arbre);
    
    procedure Supprimer_Frere (F_Cible : in T_Arbre);
    
--------------------------------------------------
    -- Copier
    --
    -- Sémantique : Copier un fichier en créant un frère avec un nouveau nom
    --
    -- Paramètre :
    --      P_Cible : Entrée T_Arbre ; Fichier à copier
    --      P_Nom : Entrée String ; Nom du nouveau fichier
    --
--------------------------------------------------
    procedure Copier (P_Cible : in T_Arbre ; P_Nom : in String);
    
    function Est_Dossier_Plein (F_Dos : in T_Arbre) return Boolean;
--------------------------------------------------
    -- Fonction de test et débbugage :
--------------------------------------------------

--------------------------------------------------
    -- Test_Decoupage
    --
    -- Sémantique : Affiche le résultat de la fonction découpage
--------------------------------------------------
    procedure Test_Decoupage (F_Chaine : in String ; F_Cible : in Character);

--    Procedure recheche();
--    Procedure supprimer();
--    Procedure modifier();


end P_Arbre;
