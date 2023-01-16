WITH Ada.Integer_Text_IO, Ada.Text_IO ;
USE Ada.Integer_Text_IO, Ada.Text_IO ;
with Ada.Unchecked_Deallocation ; 
with Ada.Strings.Unbounded;

PACKAGE BODY arbre IS

    Procedure free is new Ada.Unchecked_Deallocation(T_fichier, T_arbre) ;


    Procedure decoupage( P_chaine : in string) is
        premier : unbounded_string;
        precedent, suivant : Integer := 0;

    begin
        precedent := P_chaine'First - 1;
        for i in P_chaine'range loop
            if P_chaine(i) = '/' then
                suivant := i;
                premier := To_Unbounded_string((P_chaine( precedent + 1..suivant-1 )));
                put_line(To_string(premier));
                precedent := suivant;
            end if;
        end loop;

    end decoupage;


END arbre ;
