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
            Frere : T_Arbre;    -- Pointeur sur le prochain frère
            Fils : T_Arbre;     -- Pointeur sur le fils
            Contenu : Unbounded_String;   -- Contenu du fichier

        end record;

    -- Définition des exceptions :
    Null_Ptr_Exception : exception;


    -- Déclaration des fonctions et Procédures :

--------------------------------------------------
    -- Decoupage
    --
    -- Sémantique : Découper un chaine de caractères en fonction d'un caractère spécifique.
    --
    -- Paramètres : 
    --      F_Chaine : Entrée String ; Chaine de caractères à découper.
    --      F_Cible : Entrée Character ; Caractère qui va définir le découpage de la liste.
    --
    -- Retour :
    --      Type : P_Liste_Ustring.T_Liste_Chainee ; Liste chainée de unbounded string, 
    --      chaque T_Cellule de la liste chainée contient un mot découpé de F_Chaine.
    --
    -- Préconditions :
    --      Aucune
    --      
    -- Postconditions :
    --      La liste retournée contient un mot par cellule en fonction de F_Cible
    --
--------------------------------------------------
    function Decoupage (F_Chaine : in String ; F_Cible : in Character) return P_Liste_Ustring.T_Liste_Chainee;


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
    --
    -- Préconditions :
    --      Aucune
    --      
    -- Postconditions :
    --      Retourne le F_Arg_Nb iem élément de F_chaine
    --      
    --
--------------------------------------------------
    function Recup_Arg (F_Chaine : in String ; F_Arg_nb : in Natural) return String;


--------------------------------------------------
    -- Existe_Fils
    --
    -- Sémantique : Cherche dans un dossier si un fils existe en fonction de son nom.
    --              Ex : est ce que le dossier toto contient le fichier/dossier titi.
    --
    -- Paramètres : 
    --      F_Fils : Entrée T_Arbre ; Premier fils du dossier à fouiller
    --      F_Nom_Fils : Entrée String ; nom à rechercher dans le dossier
    --
    -- Retour :
    --      Type : Boolean ; vrai si le nom existe, faux sinon
    --
    -- Préconditions :
    --      Aucune
    --      
    -- Postconditions :
    --      Retourne vrai si le fils existe, retroune faux sinon
    --
--------------------------------------------------
    function Existe_Fils (F_Fils : in T_Arbre ; F_Nom_Fils : in String) return Boolean;


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
    --
    -- Postconditions :
    --      F_Endroit pointe vers un T_Fichier nommé F_Nom et ayant les bonne permission en fonciton de F_Est_Dossier
    --      Ainsi que F_Parent en tant que parent
    --
--------------------------------------------------
    procedure Ajouter (F_Endroit : in out T_Arbre ; F_Nom : in String ; F_Est_Dossier : in Boolean ; F_Parent : in T_Arbre);
    

--------------------------------------------------
    -- Afficher_Un
    --
    -- Sémantique : Affiche le nom du dossier/fichier passer en paramètre
    --
    -- Paramètres :
    --      F_Endroit : Entrée T_Arbre ; Pointeur sur T_Fichier à afficher.
    --
    -- Préconditions :
    --      F_Endroit /= null
    --      F_Endroit.all.Nom initialisé
    --      
    -- Postconditions :
    --      Affiche le nom du F_Fichier pointé
    --
--------------------------------------------------
    procedure Afficher_Un (F_Endroit : in T_Arbre); 


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
    --      
    -- Postconditions :
    --      Affiche l'ensemble des éléments du dossier F_Parent
    --
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
    --      
    -- Postconditions :
    --      F_Parent contient un nouveau T_Fichier nommé F_Nom
    --
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
    --      
    -- Postconditions :
    --      Affiche l'ensemble des frère de F_Frere.
    --
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
    --      
    -- Préconditions :
    --      F_Elem /= null
    --
    -- Postconditions :
    --      Retourne vrai si c'est un dossier, faux sinon
    --
--------------------------------------------------
    function Est_Dossier (F_Elem : in T_Arbre) return boolean;

    
--------------------------------------------------
    -- Descendre
    --
    -- Sémantique : Descend d'un dossier.
    --
    -- Paramètre :
    --      F_Courant : Entrée T_Arbre ; Dossier courant 
    --      F_Fils : Entrée String ; Nom du dossier fils présent dans le dossier courand dans lequel se déplacer
    --
    -- Retour :
    --      Type : T_Arbre; Dossier fils s'il existe, null sinon
    --      
    -- Préconditions :
    --      F_Courant non null
    --      F_Courant est un dossier
    --
    -- Postconditions :
    --      Retourne un pointeur sur F_Fils s'il existe, null sinon
    --
--------------------------------------------------
    function Descendre (F_Courant : in T_Arbre ; F_fils : in String) return T_Arbre;


--------------------------------------------------
    -- Monter
    --
    -- Sémantique : Monte d'un dossier
    --
    -- Paramètre :
    --      F_Courant : Entrée T_Arbre; Dossier courant à partir duquel monter
    --
    -- Retour :
    --      Type : T_Arbre ; Dossier parent à F_courant
    --      
    -- Préconditions :
    --      F_courant non null
    --
    -- Postconditions :
    --      Retourn le parent de F_courant
    --
--------------------------------------------------
    function Monter (F_Courant : in T_Arbre) return T_Arbre;


--------------------------------------------------
    -- Supprimer_Frere
    --
    -- Sémantique : Supprime le prochain frère 
    --
    -- Paramètre :
    --      F_Cible : Entrée Sortie T_Arbre; fichier à qui on veut supprimer le frère
    --
    -- Préconditions :
    --      F_Cible n'est pas null
    --
    -- Postconditions :
    --      Le frère est supprimé et le nouveau frère de F_Cible est le frère du frère supprimé.
    --
--------------------------------------------------
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
    -- Préconditions :
    --      F_Cible non null
    --      F_Cible n'est pas un dossier avec du contenu
    --      
    -- Postconditions :
    --      Une copier de P_Cible nommé P_Nom est créé dans le même dossier
    --
--------------------------------------------------
    procedure Copier (P_Cible : in T_Arbre ; P_Nom : in String);
    

--------------------------------------------------
    -- Est_Dossier_Plein
    --
    -- Sémantique : Indique si un dossier à du contenu 
    --
    -- Paramètre :
    --      F_Dos : Entrée T_Arbre ; Dossier à déterminer
    --
    -- Retour :
    --      Type : Booléen ; Vrai si dossier avec du contenu, faux sinon
    --      
    -- Préconditions :
    --      F_Dos non null
    --
    -- Postconditions :
    --      Retourne vrai si c'est un dossier et qu'il à au moin un fils, faux sinon
    --
--------------------------------------------------
    function Est_Dossier_Plein (F_Dos : in T_Arbre) return Boolean;
    
    
--------------------------------------------------
    -- Afficher_Un_Detail
    --
    -- Sémantique : Affiche les détails sur une ligne d'un fichier/dossier (permission, taille et nom) 
    --
    -- Paramètre :
    --      F_Endroit : Entrée T_Arbre ; Dossier/fichier à afficher en détail
    --
    --      
    -- Préconditions :
    --      F_Endroit non null
    --
    -- Postconditions :
    --      Affiche une ligne de détail
    --
--------------------------------------------------
    procedure Afficher_Un_Detail (F_Endroit : in T_Arbre);


--------------------------------------------------
    -- Afficher_Detail
    --
    -- Sémantique : Affiche les détail d'un fichier et de tous ses frère 
    --
    -- Paramètre :
    --      F_Endroit : Entrée T_Arbre ; Premier frère a afficher
    --
    --      
    -- Préconditions :
    --      Aucune
    --
    -- Postconditions :
    --      Affiche les détails de tous les frères
    --
--------------------------------------------------
    procedure Afficher_Detail (F_Endroit : in T_Arbre);


--------------------------------------------------
    -- Put_Perm
    --
    -- Sémantique : Affiche les permissions à partir du tableau de permission 
    --
    -- Paramètre :
    --      P_Perm : Entrée T_Tab_Perm ; Tableau de permission à afficher
    --
    --      
    -- Préconditions :
    --      P_Perm initialisé
    --
    -- Postconditions :
    --      Affiche les 10 permissions
    --
--------------------------------------------------
    procedure Put_Perm (P_Perm : in T_Tab_Perm);


--------------------------------------------------
    -- Somme_Taille_Dos
    --
    -- Sémantique : Calcule la somme des tailles des fichiers d'un dossier  
    --              Fonctionne récursivement donc compte aussi les fichiers des dossier des dossier des dossier etc
    --
    -- Paramètre :
    --      F_Dossier : Entrée T_Arbre ; Dossier dont on veut sommer les fichiers
    --
    -- Retour :
    --      Type : Entier ; somme des tailles en octets 
    --      
    -- Préconditions :
    --      Aucune
    --
    -- Postconditions :
    --      Retourne la somme de l'ensemble des tailles de fichiers présent dans F_Dossier
    --
--------------------------------------------------
    function Somme_Taille_Dos (F_Dossier : in T_Arbre) return Integer;


--------------------------------------------------
    -- Fonction de test et débbugage :
--------------------------------------------------

--------------------------------------------------
    -- Test_Decoupage
    --
    -- Sémantique : Affiche le résultat de la fonction découpage
    --
    -- Paramètre :
    --      F_Chaine : Entrée String ; Chaine de caractères à découper.
    --      F_Cible : Entrée Character ; Caractère qui va définir le découpage de la liste.
    --      
    --      
    -- Préconditions :
    --      Aucune
    --
    -- Postconditions :
    --      Affiche chaque mot de la chaine de caractères découpé en fonction de F_Cible.
    --
--------------------------------------------------
    procedure Test_Decoupage (F_Chaine : in String ; F_Cible : in Character);


end P_Arbre;
