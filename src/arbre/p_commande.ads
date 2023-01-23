with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Arbre; use P_Arbre;


package P_Commande is



    -- Définition des exceptions :


    -- Déclaration des fonction et Procédure :

--------------------------------------------------
    -- P_ls 
    --
    -- Sémantique : Affiche le contenu du dossier passé en paramètre 
    --              ou le contenu de répertoire courant si rien n'est passé en paramètre.
    --
    -- Paramètres : 
    --      F_Dossier : Entrée T_Arbre ; Dossier à afficher
    --
--------------------------------------------------
    procedure P_Ls (F_Dossier : in T_Arbre);

--------------------------------------------------
    -- P_mkdir
    --
    -- Sémantique : Crée un dossier 
    --
    -- Paramètres : 
    --      F_Dest : Entrée T_Arbre ; Dossier dans lequel créer le nouveau dossier
    --      F_Nom : Entrée Sting ; Nom du nouveau dossier.
    --
--------------------------------------------------
    procedure P_Mkdir (F_Dest : in T_Arbre ; F_Nom : in String);
    
    
--------------------------------------------------
    -- P_Touch
    --
    -- Sémantique : Crée un fichier 
    --
    -- Paramètres : 
    --      F_Dest : Entrée T_Arbre ; Dossier dans lequel créer le nouveau fichier
    --      F_Nom : Entrée Sting ; Nom du nouveau fichier.
    --
--------------------------------------------------
    procedure P_Touch (F_Dest : in T_Arbre ; F_Nom : in String);

--------------------------------------------------
    -- Fonction de test et débbugage :
--------------------------------------------------


end P_Commande;
