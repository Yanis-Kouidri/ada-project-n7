with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with liste_doublement_chainee; use liste_doublement_chainee;

procedure test_liste is
    -- Déclaration de types
    

    -- Déclaration de procédures et fonctions
    
    
    -- Déclaration de variables

    ma_liste : T_liste;
begin
    ma_liste := creation;

    put_line("[Test de création de liste :]");
    if ma_liste = null then
        put_line("OK");
    else
        put_line("KO");
    end if;

    put_line("[Test de l'ajout de la valeur 6 à la liste :]");
    ajout(ma_liste, 6);
    if ma_liste.all.element = 6 then
        put_line("OK");
    else
        put_line("KO");
    end if;

    put_line("[Test de l'ajout de la valeur 7 à la liste :]");
    ajout(ma_liste, 7);
    if ma_liste.all.element = 7 then
        put_line("OK");
    else
        put_line("KO");
    end if;

    ajout(ma_liste, 8);
    ma_liste := ma_liste.all.precedent;
    

    put_line("[Test de suppression d'une valeur au milieu de la liste :]");
    suppression(ma_liste);
    if ma_liste.all.element = 6 then
        put_line("OK");
    else
        put_line("KO");
    end if;

    put_line("[Test de suppression d'une valeur en tete de la liste :]");
    suppression(ma_liste);
    if ma_liste.all.element = 8 then
        put_line("OK");
    else
        put_line("KO");
    end if;

    ajout(ma_liste, 9);
    ajout(ma_liste, 10);
    put_line("[Test de suppression d'une valeur en fin de la liste :]");
    suppression(ma_liste);
    if ma_liste.all.element = 9 then
        put_line("OK");
    else
        put_line("KO");
    end if;

    put_line("[Test de suppression de la seule valeur restante de la liste :]");
    suppression(ma_liste);
    suppression(ma_liste);
    if ma_liste = null then
        put_line("OK");
    else
        put_line("KO");
    end if;


    ajout(ma_liste, 6);
    ajout(ma_liste, 4);
    ajout(ma_liste, 9);
    ajout(ma_liste, 1);
    ajout(ma_liste, 11);
    ajout(ma_liste, 15);
    ajout(ma_liste, 11);
    ajout(ma_liste, 2);
    ajout(ma_liste, 0);

    
    put_line("Affichage de la liste :");
    affichage(ma_liste);

    recherche(ma_liste, 6);

    put_line("[Test de recherche de la valeur 6 :]");
    if ma_liste.all.element = 6 then
        put_line("OK");
    else
        put_line("KO");
    end if;

    put_line("[Test de recherche de la valeur 1 :]");
    recherche(ma_liste, 1);
    if ma_liste.all.element = 1 then
        put_line("OK");
    else
        put_line("KO");
    end if;

    put_line("[Test de recherche de la valeur 66 qui n'existe pas :]");
    recherche(ma_liste, 66);
    if ma_liste.all.element = 1 then
        put_line("OK");
    else
        put_line("KO");
    end if;



end test_liste; 
