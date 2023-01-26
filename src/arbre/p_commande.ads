with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Arbre; use P_Arbre;


package P_Commande is



    -- Définition des exceptions :
    Pas_Un_Fichier_Erreur : exception;
    Fichier_Inexistant_Erreur : exception;
    Dos_Vide_Erreur : exception;
    Dos_Non_Trouve_Erreur : exception;


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
    -- Sémantique : Crée un dossier 
    --
    -- Paramètres : 
    --      P_Dest : Entrée T_Arbre ; Dossier dans lequel créer le nouveau dossier
    --      P_Nom : Entrée Sting ; Nom du nouveau dossier.
    --
--------------------------------------------------
    procedure P_Mkdir (P_Dest : in T_Arbre ; P_Nom : in String);
    
    
--------------------------------------------------
    -- P_Touch
    --
    -- Sémantique : Crée un fichier 
    --
    -- Paramètres : 
    --      P_Dest : Entrée T_Arbre ; Dossier dans lequel créer le nouveau fichier
    --      P_Nom : Entrée Sting ; Nom du nouveau fichier.
    --
--------------------------------------------------
    procedure P_Touch (P_Dest : in T_Arbre ; P_Nom : in String);

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
    --      P_Dossier : Entrée T_Arbre ; Dossier du fichier à modifier.
    --      P_Fichier : Entrée String ; Nom du fichier à modifier
    --      
    --
--------------------------------------------------
    procedure P_Vi (P_Courant : in T_Arbre ; P_Fichier : in String);

--------------------------------------------------
    -- Fonction de test et débbugage :
--------------------------------------------------


end P_Commande;
