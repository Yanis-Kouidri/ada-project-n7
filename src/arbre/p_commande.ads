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
    procedure P_ls (F_Dossier : in T_Arbre);

--------------------------------------------------
    -- Existe
    --
    -- Sémantique : 
    --
    -- Paramètres : 
    --      F_
    --      F_
    --
    -- Retour :
    --      Type : 
--------------------------------------------------
    procedure P_mkdir (F_Dossier : in T_Arbre);
    
    
--------------------------------------------------
    -- Fonction de test et débbugage :
--------------------------------------------------


end P_Commande;
