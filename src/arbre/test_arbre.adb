with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Arbre; use P_Arbre;

procedure Test_Arbre is
    -- Déclaration de types
    

    -- Déclaration de procédures et fonctions
    
    
    -- Déclaration de variables
    Mon_Arbre : T_Arbre;
    Test : String := "bin/sbin/src/build/";
    Test2 : String := "";
    Nom_dos : String := "Racine";


begin
    Test_Decoupage(Test2, '/');
    Ajouter(Mon_Arbre, Nom_Dos, True, null); 


end Test_Arbre; 
