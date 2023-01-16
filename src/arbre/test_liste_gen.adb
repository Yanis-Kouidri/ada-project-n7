with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with P_liste_gen;

procedure test_liste_gen is

    -- Instantiation des packages :
    Package P_liste_entier is new P_liste_gen(Type_element => Integer); use P_liste_entier;
    Package P_liste_char is new P_liste_gen(Type_element => Character); use P_liste_char;

    -- Déclaration de types
    

    -- Déclaration de procédures et fonctions

    procedure afficher_char (element : in character) is
    begin
        put(element);
    end afficher_char;

    procedure afficher_entier(element : in Integer) is
    begin
        put(element);
    end afficher_entier;

    -- Instantiation des procedures génériques :
    procedure afficher is new p_liste_entier.pour_chaque(traiter => afficher_entier);
    procedure afficher is new p_liste_char.pour_chaque(traiter => afficher_char);

    procedure afficher_un is new p_liste_entier.pour_un(traiter => afficher_entier);
    procedure afficher_un is new p_liste_char.pour_un(traiter => afficher_char);
    
    
    -- Déclaration de variables
    ma_liste_entier, cible : P_liste_entier.T_liste_chainee;
    ma_liste_char, cible_char : P_liste_char.T_liste_chainee;

begin
    put_line("Bienvenue dans le programme de test du paquetage list_chainee");
    put_line("list_chainee implémante une liste chainée d'éléménts de type générique avec diverses opérations définies dans le fichier source");
    new_line;
    put_line("  ------------------");
    put_line(" Test liste d'entier : ");
    put_line("  ------------------");
    

    new_line;
    put_line("[Création d'une liste vide]");
    ma_liste_entier := creer_liste_vide;

    new_line;
    put_line("Test de la fonction est_vide");

    if est_vide(ma_liste_entier) then
        put_line("La liste est vide : Réussite");
    else
        put_line("Erreur");
    end if;
    new_line;

    put_line("[Test de la procedure inserer_en_tete avec la valeur 111]");
    inserer_en_tete(ma_liste_entier, 111);
    put_line("Résultat :");
    afficher(ma_liste_entier);

    put_line("[Test des procedures inserer_avant et inserer_apres avec la valeur 17]");
    inserer_avant(ma_liste_entier, 111, 17);
    inserer_apres(ma_liste_entier, 111, 17);
    put_line("Résultat :");
    afficher(ma_liste_entier);


    put_line("[Ajout de valeurs dans la liste]");
    inserer_en_tete(ma_liste_entier, 4);
    inserer_en_tete(ma_liste_entier, 94);
    inserer_en_tete(ma_liste_entier, 6);
    inserer_en_tete(ma_liste_entier, 29);
    afficher(ma_liste_entier);

    put_line("[Recherche de la valeur 6]");
    cible := rechercher(ma_liste_entier, 6);
    put_line("Element trouvé :");
    afficher_un(cible);
    new_line;

    put_line("[Suppression de l'élément 111]");
    enlever(ma_liste_entier, 111);
    put_line("Résultat :");
    afficher(ma_liste_entier);

    new_line;


    put_line("  ------------------");
    put_line(" Test liste de caractères : ");
    put_line("  ------------------");


    new_line;
    put_line("[Création d'une liste vide]");
    ma_liste_char := creer_liste_vide;

    new_line;
    put_line("Test de la fonction est_vide");
    if est_vide(ma_liste_char) then
        put_line("La liste est vide : Réussite");
    else
        put_line("Erreur");
    end if;
    new_line;

    put_line("[Test de la procedure inserer_en_tete avec le caracter 'c']");
    inserer_en_tete(ma_liste_char, 'c');
    put_line("Résultat :");
    afficher(ma_liste_char);

    put_line("[Test des procedures inserer_avant et inserer_apres avec le caractère 'P']");
    inserer_avant(ma_liste_char, 'c', 'P');
    inserer_apres(ma_liste_char, 'c', 'P');
    put_line("Résultat :");
    afficher(ma_liste_char);


    put_line("[Ajout de valeurs dans la liste]");
    inserer_en_tete(ma_liste_char, 'y');
    inserer_en_tete(ma_liste_char, 'a');
    inserer_en_tete(ma_liste_char, 'n');
    inserer_en_tete(ma_liste_char, 'i');
    afficher(ma_liste_char);

    put_line("[Recherche du caractère 'n']");
    cible_char := rechercher(ma_liste_char, 'n');
    put_line("Element trouvé :");
    afficher_un(cible_char);
    new_line;

    put_line("[Suppression du caractère 'c' ]");
    enlever(ma_liste_char, 'c');
    put_line("Résultat :");
    afficher(ma_liste_char);

end test_liste_gen; 
