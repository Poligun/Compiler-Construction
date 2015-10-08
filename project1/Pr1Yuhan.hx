module yuhan.project1.Pr1Yuhan
{
    space [ \t\f\r\n] | nested "/*" "*/" | "//".*;

    token Identifier | [a-zA-Z$_][a-zA-Z0-9$_]*;
    token Integer    | [0-9]+;
    token String     | \'\';

    token fragment Escape | \\[]

    token SingleLineComment | //.*$;
    token MultiLineComment  | /\*[.\n\r]*\*/;

    sort E
    | ⟦⟨Identifier⟩⟧ @15 | ⟦⟨Integer⟩⟧ @15 | ⟦⟨String⟩⟧ @15 | ⟦⟨E⟩⟧ @15
    | ⟦⟨E @14⟩.⟨E @15⟩⟧ @14
    //Missing
    | ⟦!⟨E @12⟩⟧ @12 | ⟦~⟨E @12⟩⟧ @12 | ⟦-⟨E @12⟩⟧ @12 | ⟦+⟨E @12⟩⟧ @12
    | ⟦⟨E @11⟩*⟨E @12⟩⟧ @11 | ⟦⟨E @11⟩/⟨E @12⟩⟧ @11 | ⟦⟨E @11⟩%⟨E @12⟩⟧ @11
    | ⟦⟨E @10⟩+⟨E @11⟩⟧ @10 | ⟦⟨E @10⟩-⟨E @11⟩⟧ @10
    | ⟦⟨E @9⟩<⟨E @10⟩⟧ @9 | ⟦⟨E @9⟩>⟨E @10⟩⟧ @9 | ⟦⟨E @9⟩<=⟨E @10⟩⟧ @9 | ⟦⟨E @9⟩>=⟨E @10⟩⟧ @9
    | ⟦⟨E @8⟩==⟨E @9⟩⟧ @8 | ⟦⟨E @8⟩!=⟨E @9⟩⟧ @8
    | ⟦⟨E @7⟩&⟨E @8⟩⟧ @7
    | ⟦⟨E @6⟩^⟨E @7⟩⟧ @6
    | ⟦⟨E @5⟩|⟨E @6⟩⟧ @5
    | ⟦⟨E @4⟩&&⟨E @5⟩⟧ @4
    | ⟦⟨E @3⟩||⟨E @4⟩⟧ @3
    | ⟦⟨E @3⟩?⟨E⟩:⟨E @2⟩⟧ @2 //Here ternary operator is right associative
    | ⟦⟨E @2⟩=⟨E @1⟩⟧ @1 | ⟦⟨E @2⟩+=⟨E @1⟩⟧ @1 // Missing
    ;
}
