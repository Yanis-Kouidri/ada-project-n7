with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Assertions ; use Ada.Assertions;
with P_Arbre; use P_Arbre;
with P_Liste_Gen;

procedure Test_Arbre is
    -- Déclaration de types
    

    -- Déclaration de procédures et fonctions
    procedure Afficher_Ustring (Element : in Unbounded_String) is -- Pour afficher un liste de unbounded string
    begin
        Put_Line (To_String (Element));
    end Afficher_Ustring;

    procedure Afficher is new P_Arbre.P_Liste_Ustring.Pour_Chaque(Traiter => Afficher_Ustring);
    
    
    -- Déclaration de variables
    Mon_Arbre, Fich, Lecteur, Arbre_Test : T_Arbre;
    Chemin1 : String := "bin/sbin/src/build/";
    Commande : String := "ls -l -r ./Fichier";
    Vide : String := "";
    Racine : String := "/";
    Test_Bin : Boolean;
    Entier_test : Integer;

    Decoup : P_Arbre.P_Liste_Ustring.T_Liste_Chainee ; 
    Elem : Unbounded_String;


begin
----------------------------------------------------------------------
    Decoup := Decoupage (Chemin1, '/');

    Elem := P_Arbre.P_Liste_Ustring.Recuperer_nb (Decoup, 0);
    pragma Assert ((Elem = "bin"), "Erreur : Decoupage [1]");

    Elem := P_Arbre.P_Liste_Ustring.Recuperer_nb (Decoup, 1);
    pragma Assert ((Elem = "sbin"), "Erreur : Decoupage [2]");
    
    Elem := P_Arbre.P_Liste_Ustring.Recuperer_nb (Decoup, 2);
    pragma Assert ((Elem = "src"), "Erreur : Decoupage [3]");

    Elem := P_Arbre.P_Liste_Ustring.Recuperer_nb (Decoup, 3);
    pragma Assert ((Elem = "build"), "Erreur : Decoupage [4]");


    Decoup := Decoupage (Commande, ' ');

    Elem := P_Arbre.P_Liste_Ustring.Recuperer_nb (Decoup, 0);
    pragma Assert ((Elem = "ls"), "Erreur : Decoupage [5]");

    Elem := P_Arbre.P_Liste_Ustring.Recuperer_nb (Decoup, 1);
    pragma Assert ((Elem = "-l"), "Erreur : Decoupage [6]");
    
    Elem := P_Arbre.P_Liste_Ustring.Recuperer_nb (Decoup, 2);
    pragma Assert ((Elem = "-r"), "Erreur : Decoupage [7]");

    Elem := P_Arbre.P_Liste_Ustring.Recuperer_nb (Decoup, 3);
    pragma Assert ((Elem = "./Fichier"), "Erreur : Decoupage [8]");

----------------------------------------------------------------------

    Elem := To_Unbounded_String (Recup_Arg (Commande, 0));
    pragma Assert ((Elem = "ls"), "Erreur : Recup_Arg [1]");
    
    Elem := To_Unbounded_String (Recup_Arg (Commande, 1));
    pragma Assert ((Elem = "-l"), "Erreur : Recup_Arg [2]");
    
    Elem := To_Unbounded_String (Recup_Arg (Commande, 2));
    pragma Assert ((Elem = "-r"), "Erreur : Recup_Arg [3]");
    
    Elem := To_Unbounded_String (Recup_Arg (Commande, 3));
    pragma Assert ((Elem = "./Fichier"), "Erreur : Recup_Arg [3]");

----------------------------------------------------------------------


    Ajouter(Mon_Arbre, "/", True, null); 
    pragma assert ((Mon_Arbre /= null), "Erreur : Ajouter [1]");
    pragma assert ((Mon_Arbre.all.Nom = "/"), "Erreur : Ajouter [2]");
    pragma assert ((Mon_Arbre.all.Fils = null), "Erreur : Ajouter [3]");
    pragma assert ((Mon_Arbre.all.Frere = null), "Erreur : Ajouter [4]");
    pragma assert ((Mon_Arbre.all.Parent = null), "Erreur : Ajouter [5]");

----------------------------------------------------------------------
    Test_bin := Existe_Fils (Mon_Arbre.all.Fils, "truc");

    pragma assert ((not Test_Bin), "Erreur : Existe_Fils [1]");
----------------------------------------------------------------------
    
    Ajouter_Dans_Dos (Mon_Arbre, "truc", false);

    pragma assert ((Mon_Arbre.all.Fils /= null), "Erreur : Ajouter_Dans_Dos [1]");
    pragma assert ((Mon_Arbre.all.Fils.all.Nom = "truc"), "Erreur : Ajouter_Dans_Dos [2]");

    Ajouter_Dans_Dos (Mon_Arbre, "machin", false);

    pragma assert ((Mon_Arbre.all.Fils.all.Frere /= null), "Erreur : Ajouter_Dans_Dos [3]");
    pragma assert ((Mon_Arbre.all.Fils.all.Frere.all.Nom = "machin"), "Erreur : Ajouter_Dans_Dos [4]");
----------------------------------------------------------------------

    Test_bin := Existe_Fils (Mon_Arbre.all.Fils, "truc");
    pragma assert (Test_bin, "Erreur : Existe_Fils [2]");

    Test_bin := Existe_Fils (Mon_Arbre.all.Fils, "machin");
    pragma assert (Test_bin, "Erreur : Existe_Fils [3]");

    Test_bin := Existe_Fils (Mon_Arbre.all.Fils, "zehin");
    pragma assert (not Test_bin, "Erreur : Existe_Fils [4]");
----------------------------------------------------------------------

    Ajouter_Dans_Dos (Mon_Arbre, "Dos1", true);

    Test_bin := Est_Dossier (Mon_Arbre);
    pragma assert (Test_Bin, "Erreur : Est_Dossier [1]");

    Test_bin := Est_Dossier (Mon_Arbre.all.Fils);
    pragma assert ( not Test_Bin, "Erreur : Est_Dossier [2]");

    Ajouter (Fich, "un_fich", False, null);
    Test_bin := Est_Dossier (Fich);
    pragma assert ( not Test_bin, "Erreur : Est_Dossier [3]");

----------------------------------------------------------------------
    Lecteur := Descendre (Mon_Arbre, "machin");
    pragma assert (Lecteur /= null, "Erreur : Descendre [1]");
    pragma assert (Lecteur.all.Nom = "machin", "Erreur : Descendre [2]");

    Lecteur := Descendre (Mon_Arbre, "macn");
    pragma assert (Lecteur = null, "Erreur : Descendre [3]");
----------------------------------------------------------------------


    Lecteur := Descendre (Mon_Arbre, "machin");
    Lecteur := Monter (Lecteur);

    pragma assert ((Lecteur /= null), "Erreur : Monter [1]");
    pragma assert ((Lecteur.all.Nom = "/"), "Erreur : Monter [2]");
----------------------------------------------------------------------

    Ajouter (Arbre_Test, "f1", false, null);
    Ajouter (Arbre_Test.all.Frere, "f2", false, null);

    Supprimer_Frere (Arbre_Test);

    pragma assert ((Arbre_Test.all.Frere = null), "Erreur : Supprimer_Frere [1]");

    Ajouter (Arbre_Test.all.Frere, "f2", false, null);
    Ajouter (Arbre_Test.all.Frere.all.Frere, "f3", false, null);
    Ajouter (Arbre_Test.all.Frere.all.Frere.all.Frere, "f4", false, null);

    Supprimer_Frere (Arbre_Test);

    pragma assert ((Arbre_Test.all.Frere /= null), "Erreur : Supprimer_Frere [2]");
    pragma assert ((Arbre_Test.all.Frere.all.Nom = "f3"), "Erreur : Supprimer_Frere [3]");
----------------------------------------------------------------------
    
    Arbre_Test := null;


    Ajouter (Arbre_Test, "f1", false, null);
    Ajouter (Arbre_Test.all.Frere, "f2", false, null);

    Copier (Arbre_Test, "nouv");

    pragma assert ((Arbre_Test.all.Frere.all.Frere.all.Nom = "nouv"), "Erreur : Copier [1]");
----------------------------------------------------------------------

    Arbre_Test := null;
    Ajouter (Arbre_Test, "dos", true, null);

    test_bin := Est_Dossier_Plein(Arbre_Test);

    pragma assert (not test_bin, "Erreur : Est_Dossier_Plein [1]");

    Ajouter (Arbre_Test.all.fils, "fils", true, null);
    test_bin := Est_Dossier_Plein(Arbre_Test);

    pragma assert (test_bin, "Erreur : Est_Dossier_Plein [2]");
----------------------------------------------------------------------


    Arbre_Test := null;
    Ajouter (Arbre_Test, "dos", true, null);

    Entier_test := Somme_Taille_Dos (Arbre_Test);
    pragma assert (Entier_test = 0, "Erreur : Somme_Taille_Dos [1]");

    Ajouter (Arbre_Test.all.Fils, "f1", False, Arbre_Test);
    Arbre_Test.all.Fils.all.Taille := 88;

    Entier_test := Somme_Taille_Dos (Arbre_Test);
    pragma assert (Entier_test = 88, "Erreur : Somme_Taille_Dos [2]");

    Ajouter (Arbre_Test.all.Fils.all.Frere, "f2", False, Arbre_Test);
    Arbre_Test.all.Fils.all.Frere.all.Taille := 7481;


    Entier_test := Somme_Taille_Dos (Arbre_Test);
    pragma assert (Entier_test = (88 + 7481), "Erreur : Somme_Taille_Dos [3]");

end Test_Arbre; 
