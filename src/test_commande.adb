with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Assertions ; use Ada.Assertions;
with P_Arbre; use P_Arbre;
with P_Commande; use P_Commande;
with P_Liste_Gen;

procedure Test_Commande is
    -- Déclaration de types
    

    -- Déclaration de procédures et fonctions
    
    
    -- Déclaration de variables
    Arbre_Test : T_Arbre := null;


begin
----------------------------------------------------------------------
    Ajouter (Arbre_Test, "Racine", true, null);

    P_Mkdir (Arbre_Test, "nouv");
     
    pragma assert (Arbre_Test.all.Fils /= null, "Erreur : P_Mkdir [1]");
    pragma assert (Arbre_Test.all.Fils.all.Nom = "nouv", "Erreur : P_Mkdir [2]");
    pragma assert (Est_Dossier (Arbre_Test.all.Fils) , "Erreur : P_Mkdir [3]");

    P_Mkdir (Arbre_Test, "nouv2");

    pragma assert (Arbre_Test.all.Fils.all.Frere /= null, "Erreur : P_Mkdir [4]");
    pragma assert (Arbre_Test.all.Fils.all.Frere.all.Nom = "nouv2", "Erreur : P_Mkdir [5]");
    pragma assert (Est_Dossier (Arbre_Test.all.Fils.all.Frere) , "Erreur : P_Mkdir [6]");

----------------------------------------------------------------------

    Arbre_Test := null;
    Ajouter (Arbre_Test, "Racine", true, null);
    
    P_Touch (Arbre_Test, "fich1");

    pragma assert (Arbre_Test.all.Fils /= null, "Erreur : P_Touch [1]");
    pragma assert (Arbre_Test.all.Fils.all.Nom = "fich1", "Erreur : P_Touch [2]");
    pragma assert (not Est_Dossier (Arbre_Test.all.Fils) , "Erreur : P_Touch [3]");

    P_Touch (Arbre_Test, "fich2");

    pragma assert (Arbre_Test.all.Fils.all.Frere /= null, "Erreur : P_Touch [4]");
    pragma assert (Arbre_Test.all.Fils.all.Frere.all.Nom = "fich2", "Erreur : P_Touch [5]");
    pragma assert (not Est_Dossier (Arbre_Test.all.Fils.all.Frere) , "Erreur : P_Touch [6]");

----------------------------------------------------------------------

    Arbre_Test := null;

    Ajouter (Arbre_Test, "Racine", true, null);

    P_Mkdir (Arbre_Test, "dos");

    P_Cd (Arbre_Test, "dos");

    pragma assert (Arbre_Test /= null, "Erreur : P_Cd [1]");
    pragma assert (Arbre_Test.all.Nom = "dos", "Erreur : P_Cd [2]");

    P_Cd (Arbre_Test, "..");

    pragma assert (Arbre_Test /= null, "Erreur : P_Cd [3]");
    pragma assert (Arbre_Test.all.Nom = "Racine", "Erreur : P_Cd [4]");
----------------------------------------------------------------------

    Arbre_Test := null;

    Ajouter (Arbre_Test, "Racine", true, null);

    P_Mkdir (Arbre_Test, "dos");

    P_Rm (Arbre_Test, "dos");
    pragma assert (Arbre_Test.all.Fils = null, "Erreur : P_Rm [1]");


    P_Touch (Arbre_Test, "fich1");

    P_Rm (Arbre_Test, "fich1");
    pragma assert (Arbre_Test.all.Fils = null, "Erreur : P_Rm [2]");

    P_Touch (Arbre_Test, "fich1");
    P_Touch (Arbre_Test, "fich2");

    P_Rm (Arbre_Test, "fich1");


    pragma assert (Arbre_Test.all.Fils /= null, "Erreur : P_Rm [3]");
    pragma assert (Arbre_Test.all.Fils.all.Nom = "fich2", "Erreur : P_Rm [4]");
----------------------------------------------------------------------
    Arbre_Test := null;

    Ajouter (Arbre_Test, "Racine", true, null);

    P_Mkdir (Arbre_Test, "dos");

    P_Cp (Arbre_Test, "dos", "cp_dos");

    pragma assert (Arbre_Test.all.Fils.all.Frere /= null, "Erreur : P_Cp [1]");
    pragma assert (Arbre_Test.all.Fils.all.Frere.all.Nom = "cp_dos", "Erreur : P_Cp [2]");
----------------------------------------------------------------------

    Arbre_Test := null;

    Ajouter (Arbre_Test, "Racine", true, null);

    P_Touch (Arbre_Test, "bonjur");

    P_Mv (Arbre_Test, "bonjur", "bonjour");

    pragma assert (Arbre_Test.all.Fils /= null, "Erreur : P_Mv [1]");
    pragma assert (Arbre_Test.all.Fils.all.Nom = "bonjour", "Erreur : P_Mv [2]");
----------------------------------------------------------------------
    Arbre_Test := null;

    Ajouter (Arbre_Test, "Racine", true, null);
    P_Mkdir (Arbre_Test, "dos");

    P_Touch (Arbre_Test.all.Fils, "fich1");
    P_Touch (Arbre_Test.all.Fils, "fich2");

    Arbre_Test.all.Fils.all.Fils.all.Taille := 795;
    Arbre_Test.all.Fils.all.Fils.all.Frere.all.Taille := 1935;

    P_Tar (Arbre_Test, "dos"); 

    pragma assert (Arbre_Test.all.Fils.all.Frere /= null, "Erreur : P_Tar [1]");
    pragma assert (Arbre_Test.all.Fils.all.Frere.all.Nom = "dos.tar", "Erreur : P_Tar [2]");
    pragma assert (Arbre_Test.all.Fils.all.Frere.all.Taille = (795+1935), "Erreur : P_Tar [3]");
----------------------------------------------------------------------
    


end Test_Commande; 

