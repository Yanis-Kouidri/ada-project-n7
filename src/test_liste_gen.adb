with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with P_liste_gen;

procedure Test_Liste_Gen is

    -- Instantiation des packages :
    Package P_liste_entier is new P_liste_gen(Type_Element => Integer); use P_liste_entier;
    Package P_liste_char is new P_liste_gen(Type_Element => Character); use P_liste_char;

    -- Déclaration de types
    

    -- Déclaration de procédures et fonctions

    procedure Afficher_Char (Element : in character) is
    begin
        put(Element);
    end Afficher_Char;

    procedure Afficher_entier(Element : in Integer) is
    begin
        put(Element);
    end Afficher_entier;

    -- Instantiation des procedures génériques :
    procedure Afficher is new p_liste_entier.pour_chaque(traiter => Afficher_entier);
    procedure Afficher is new p_liste_char.pour_chaque(traiter => Afficher_char);

    procedure Afficher_un is new p_liste_entier.pour_un(traiter => Afficher_entier);
    procedure Afficher_un is new p_liste_char.pour_un(traiter => Afficher_char);
    
    
    -- Déclaration de variables
    Ma_Liste_Entier, cible : P_liste_entier.T_liste_chainee;
    Ma_Liste_Char, cible_char : P_liste_char.T_liste_chainee;

begin
    Put_Line("Bienvenue dans le programme de test du paquetage list_chainee");
    Put_Line("list_chainee implémante une liste chainée d'éléménts de type générique avec diverses opérations définies dans le fichier source");
    New_Line;
    Put_Line("  ------------------");
    Put_Line(" Test liste d'entier : ");
    Put_Line("  ------------------");
    

    New_Line;
    Put_Line("[Création d'une liste vide]");
    Ma_Liste_Entier := Creer_Liste_Vide;

    New_Line;
    Put_Line("Test de la fonction Est_Vide");

    if Est_Vide(Ma_Liste_Entier) then
        Put_Line("La liste est vide : Réussite");
    else
        Put_Line("Erreur");
    end if;
    New_Line;

    Put_Line ("[Test de la procedure Inserer_En_Queue avec la valeur 111 puis 114]");
    Inserer_En_Queue (Ma_Liste_Entier, 111);
    Inserer_En_Queue (Ma_Liste_Entier, 114);
    Put_Line ("Résultat :");
    Afficher (Ma_Liste_Entier);

    Put_Line ("[Test des procedures Inserer_Avant et Inserer_Apres avec la valeur 17]");
    Inserer_Avant (Ma_Liste_Entier, 111, 17);
    Inserer_Apres (Ma_Liste_Entier, 111, 17);
    Put_Line ("Résultat :");
    Afficher(Ma_Liste_Entier);


    Put_Line ("[Ajout de valeurs dans la liste]");
    Inserer_En_Tete (Ma_Liste_Entier, 4);
    Inserer_En_Tete(Ma_Liste_Entier, 94);
    Inserer_En_Tete(Ma_Liste_Entier, 6);
    Inserer_En_Tete(Ma_Liste_Entier, 29);
    Afficher(Ma_Liste_Entier);

    Put_Line("[Ajout de valeurs au bout de la liste]");
    Inserer_En_Queue(Ma_Liste_Entier, 999);
    Afficher(Ma_Liste_Entier);

    Put_Line("[Recherche de la valeur 6]");
    cible := rechercher(Ma_Liste_Entier, 6);
    Put_Line("Element trouvé :");
    Afficher_un(cible);
    New_Line;

    Put_Line("[Suppression de l'élément 111]");
    enlever(Ma_Liste_Entier, 111);
    Put_Line("Résultat :");
    Afficher(Ma_Liste_Entier);

    New_Line;


    Put_Line("  ------------------");
    Put_Line(" Test liste de caractères : ");
    Put_Line("  ------------------");


    New_Line;
    Put_Line("[Création d'une liste vide]");
    Ma_Liste_Char := Creer_Liste_Vide;

    New_Line;
    Put_Line("Test de la fonction Est_Vide");
    if Est_Vide(Ma_Liste_Char) then
        Put_Line("La liste est vide : Réussite");
    else
        Put_Line("Erreur");
    end if;
    New_Line;

    Put_Line("[Test de la procedure Inserer_En_Tete avec le caracter 'c']");
    Inserer_En_Tete(Ma_Liste_Char, 'c');
    Put_Line("Résultat :");
    Afficher(Ma_Liste_Char);

    Put_Line("[Test des procedures Inserer_Avant et Inserer_Apres avec le caractère 'P']");
    Inserer_Avant(Ma_Liste_Char, 'c', 'P');
    Inserer_Apres(Ma_Liste_Char, 'c', 'P');
    Put_Line("Résultat :");
    Afficher(Ma_Liste_Char);


    Put_Line("[Ajout de valeurs dans la liste]");
    Inserer_En_Tete(Ma_Liste_Char, 'y');
    Inserer_En_Tete(Ma_Liste_Char, 'a');
    Inserer_En_Tete(Ma_Liste_Char, 'n');
    Inserer_En_Tete(Ma_Liste_Char, 'i');
    Afficher(Ma_Liste_Char);

    Put_Line("[Recherche du caractère 'n']");
    cible_char := rechercher(Ma_Liste_Char, 'n');
    Put_Line("Element trouvé :");
    Afficher_un(cible_char);
    New_Line;

    Put_Line("[Suppression du caractère 'c' ]");
    enlever(Ma_Liste_Char, 'c');
    Put_Line("Résultat :");
    Afficher(Ma_Liste_Char);

end Test_Liste_Gen; 
