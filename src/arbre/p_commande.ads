with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Arbre; use P_Arbre;


package P_Commande is



    -- Définition des exceptions :
    Pas_Un_Fichier_Erreur : exception;
    Pas_Un_Dossier_Erreur : exception;
    Dos_Vide_Erreur : exception;
    Dos_Non_Vide_Erreur : exception;
    Fichier_Non_Trouve_Erreur : exception;
    Racine_Atteinte_Erreur : exception;
    Fich_Deja_Existant_Erreur : exception;


    -- Déclaration des fonction et Procédure :

--------------------------------------------------
    -- P_Ls 
    --
    -- Sémantique : Affiche le contenu du dossier courant 
    --
    -- Paramètre : 
    --      P_Dossier : Entrée T_Arbre ; Dossier à afficher
    --
--------------------------------------------------
    procedure P_Ls (P_Dossier : in T_Arbre);

--------------------------------------------------
    -- P_Ll 
    --
    -- Sémantique : Affiche le contenu détaillé du dossier courant
    --
    -- Paramètre : 
    --      P_Dossier : Entrée T_Arbre ; Dossier à afficher
    --
--------------------------------------------------
    procedure P_Ll (P_Dossier : in T_Arbre);

--------------------------------------------------
    -- P_Mkdir
    --
    -- Sémantique : Crée un dossier dans le repertoire passé en paramètre. 
    --
    -- Paramètres : 
    --      P_Courant : Entrée T_Arbre ; Dossier dans lequel créer le nouveau dossier
    --      P_Nom : Entrée Sting ; Nom du nouveau dossier.
    --
    -- Préconditions :
    --      P_Courant existe (/= null).
    --      P_Courant est un dossier.
    --
    -- Postcondition :
    --      Un dossier ayant pour nom P_Nom existe dans le dossier P_Courant.
--------------------------------------------------
    procedure P_Mkdir (P_Courant : in T_Arbre ; P_Nom : in String);
    
    
--------------------------------------------------
    -- P_Touch
    --
    -- Sémantique : Crée un fichier 
    --
    -- Paramètres : 
    --      P_Courant : Entrée T_Arbre ; Dossier dans lequel créer le nouveau fichier.
    --      P_Nom : Entrée Sting ; Nom du nouveau fichier.
    --
    -- Préconditions :
    --      P_Courant existe (/= null).
    --      P_Courant est un dossier.
    --
    -- Postcondition :
    --      Un fichier ayant pour nom P_Nom existe dans le dossier P_Courant.
--------------------------------------------------
    procedure P_Touch (P_Courant : in T_Arbre ; P_Nom : in String);

--------------------------------------------------
    -- P_Cd
    --
    -- Sémantique : Change de répertoire
    --
    -- Paramètres : 
    --      P_Dest : Entrée T_Arbre ; Dossier dans lequel je me déplace.
    --      P_Courant : Entrée Sortie T_Arbre ; Nouveau répertoire courant.
    --
--------------------------------------------------
    procedure P_Cd (P_Courant : in out T_Arbre ; P_Chemin : in String);
    
--------------------------------------------------
    -- P_Pwd
    --
    -- Sémantique : Affiche le chemin répertoire courant
    --
    -- Paramètres : 
    --      P_Courant : Entrée T_Arbre ; Répertoire courant.
    --
--------------------------------------------------
    procedure P_Pwd (P_Courant : in T_Arbre);
    
--------------------------------------------------
    -- P_Rm
    --
    -- Sémantique : Supprimer un fichier ou un dossier vide
    --
    -- Paramètres : 
    --      P_Courant : Entrée T_Arbre ; Répertoire courant.
    --      P_A_Supp : Entrée String ; Nom du répertoire à supprimer
    --
--------------------------------------------------
    procedure P_Rm (P_Courant : in T_Arbre ; P_A_Supp : in String);

--------------------------------------------------
    -- P_Cp
    --
    -- Sémantique : Copier un fichier
    --
    -- Paramètres : 
    --      P_Courant : Entrée T_Arbre ; Répertoire courant.
    --      P_A_Copier : Entrée String ; Nom du fichier à copier
    --      P_Nouv_Nom : Entrée String ; Nom de la nouvelle copie
    --
    --
--------------------------------------------------
    procedure P_Cp (P_Courant : in T_Arbre ; P_A_Copier, P_Nouv_Nom : in String);

--------------------------------------------------
    -- P_Cat
    --
    -- Sémantique : Affiche le contenu d'un fichier.
    --
    -- Paramètres : 
    --      P_Dossier : Entrée T_Arbre ; Dossier du fichier à afficher.
    --      P_Fichier : Entrée String ; Nom du fichier à afficher
    --      
    --
--------------------------------------------------
    procedure P_Cat (P_Dossier : in T_Arbre ; P_Fichier : in String);

--------------------------------------------------
    -- P_Vi
    --
    -- Sémantique : Modifie le contenu d'un fichier
    --
    -- Paramètres : 
    --      P_Courant : Entrée T_Arbre ; Dossier du fichier à modifier.
    --      P_Fichier : Entrée String ; Nom du fichier à modifier
    --      
    --
--------------------------------------------------
    procedure P_Vi (P_Courant : in T_Arbre ; P_Fichier : in String);

--------------------------------------------------
    -- P_Mv
    --
    -- Sémantique : Renomme un élément (dossier ou fichier)
    --
    -- Paramètres : 
    --      P_Courant : Entrée T_Arbre ; Dossier du fichier à renommer.
    --      P_A_Modif : Entrée String ; Nom du fichier à renommer.
    --      P_Nouv_Nom : Entrée String ; Nouveau nom du fichier.
    --      
    --
--------------------------------------------------
    procedure P_Mv (P_Courant : in T_Arbre ; P_A_Modif, P_Nouv_Nom : in String);

--------------------------------------------------
    -- P_Tar
    --
    -- Sémantique : Crée une archive (fichier d'extention .tar) a partir d'un dossier existant
    --              L'archive à pour taille la somme des tailles des fichiers du dossier à archiver.
    --
    -- Paramètres : 
    --      P_Courant : Entrée T_Arbre ; Dossier contenant le dossier à archiver
    --      P_Dossier : Entrée String ; Nom du dossier à archiver.
    --      
    -- Préconditions :
    --      P_Courant existe (/= null).
    --      P_Courant est un dossier.
    --
    -- Postconditions :
    --      Un fichier d'extention .tar est créé.
    --      Sa taille est la somme des tailles des fichiers du dossier à archiver.
--------------------------------------------------
    procedure P_Tar (P_Courant : in T_Arbre ; P_Dossier : in String);


--------------------------------------------------
    -- Fonction de test et débbugage :
--------------------------------------------------


end P_Commande;
