with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Arbre; use P_Arbre;

procedure Test_Arbre is
    -- Déclaration de types
    

    -- Déclaration de procédures et fonctions
    
    
    -- Déclaration de variables
    Mon_Arbre, racine : T_Arbre;
    Test : String := "bin/sbin/src/build/";
    Test2 : String := "";
    Nom_dos : String := "/";


begin
    --Test_Decoupage(Test2, '/');
    Ajouter(Mon_Arbre, "/", True, null); 
--    Afficher_un(Mon_Arbre);

    Ajouter_Dans_Dos (Mon_Arbre, "fils_1", True); 

    Ajouter_Dans_Dos (Mon_Arbre, "fils_2", True); 

    Ajouter_Dans_Dos (Mon_Arbre, "fils_3", True); 

    Afficher_dos(Mon_Arbre);

--    Afficher_dos(Racine.all.Fils);


end Test_Arbre; 
