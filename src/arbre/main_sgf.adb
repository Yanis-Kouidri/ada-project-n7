with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with P_Arbre; use P_Arbre;
with P_Commande; use P_Commande;
with Ada.Characters.Latin_1 ; use Ada.Characters.Latin_1 ;
with P_Liste_gen;

procedure main_sgf is


    -- Déclaration de types
    type T_Commandes is (ls, ll, cd, cp, rm, vi, mv, tar, cat, pwd, quit, clear, mkdir, touch);
    

    -- Déclaration de procédures et fonctions
    
    
    -- Déclaration de variables
    -- Liste_Vide_Erreur : exception;

    Racine, Rep_Courant : T_Arbre;
    Commande_Brute : Unbounded_String;
    Commande_Traitee : P_Arbre.P_Liste_Ustring.T_Liste_Chainee ; 
    Commande_Simple : Unbounded_String;
    Quitter : Boolean := False;


begin
    -- Initialisation de l'arbre
    Ajouter(Racine, "", True, null);
    Rep_Courant := Racine;
    
    while not Quitter loop
        
        Put (ESC & "[92m" & "ykouidri@ada-project" & ESC & "[0m" & ":");
        P_Pwd (Rep_Courant);
        Put (" > "); -- Le prompt


        -- Récupération de la commande tapée par l'utilisateur :
        Commande_Brute := To_Unbounded_String (Get_Line);

        if Commande_Brute /= Null_Unbounded_String then 

            -- Récupération du premier mot de la commande tapée par l'utilisateur :
            Commande_Simple := To_Unbounded_String (Recup_Arg (To_String (Commande_Brute), 0));

            begin    
                case T_Commandes'Value (To_String (Commande_Simple)) is 

                    when ls => P_Ls (Rep_Courant);
                    
                    when ll => P_Ll (Rep_Courant);

                    when mkdir => 
                        -- put_line("Nom :");
                        -- put_line (Recup_Arg (To_String (Commande_Brute), 1));
                        
                        P_Mkdir (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));

                    when touch => P_Touch (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));

                    when cd => P_Cd (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));

                    when pwd => 
                        P_Pwd (Rep_Courant);
                        New_Line;
                    when rm =>
                        P_Rm(Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));
                        
                    when cp => P_Cp (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1),
                                                  Recup_Arg (To_String (Commande_Brute), 2));

                    when vi => P_Vi (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));

                    when cat => P_Cat (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));

                    when clear => Put (ASCII.ESC & "[2J");

                    when mv => P_Mv (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1),
                                                  Recup_Arg (To_String (Commande_Brute), 2));

                    when tar => P_tar (Rep_Courant, Recup_Arg (To_String (Commande_Brute), 1));

                    when quit => Quitter := true;

                end case;

            exception 

                when P_Liste_Ustring.Liste_Vide_Erreur => Put_Line ("Argument manquant");

                when Pas_Un_Fichier_Erreur => Put_Line ("Impossible : l'élément spécifié est un dossier");

                when Pas_Un_Dossier_Erreur => Put_Line ("Impossible : l'élément spécifié est un fichier");
                
                when Dos_Vide_Erreur => Put_Line ("Dossier vide");

                when Dos_Non_Vide_Erreur => Put_Line ("Le dossier doit être vide");

                when Fichier_Non_Trouve_Erreur => Put_Line ("Le fichier/dossier spécifié n'existe pas");

                when Racine_Atteinte_Erreur => Put_Line ("Racine atteinte");

                when Fich_Deja_Existant_Erreur => Put_Line ("Nom de fichier/dossier déjà existant");

                when Constraint_Error => Put_Line ("Commande inconnue");
            end;

        end if;

    end loop;
    

end main_sgf; 
