with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Arbre; use P_Arbre;
with P_Commande; use P_Commande;

procedure main_sgf is
    -- Déclaration de types
    

    -- Déclaration de procédures et fonctions
    
    
    -- Déclaration de variables
    Racine : T_Arbre;


begin
    Ajouter(Racine, "/", True, null);

    Ajouter_Dans_Dos (Racine, "test_1", True);

    P_ls(Racine);

end main_sgf; 
