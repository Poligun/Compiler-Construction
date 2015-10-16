module yuhan.project2.Pr2Yuhan
{
    /* Whitespace & comment that are ignored */
    space [ \t\r\n]
    | "//".*
    | "/*"([^*]|"*"[^/]|⟨NewLine⟩)*"*/"
    ;

    token fragment NewLine | \n | \r\n;
    token fragment HexDigit | [0-9a-fA-F];
    token fragment Escape | \\([\'\"\\nt]|(\r?\n)|(x[a-fA-F0-9][a-fA-F0-9]));

    main sort Program
    | ⟦⟨StatementSequence⟩⟧
    ;

    sort Expression
    /* Primitives have the highest precedence */
    | ⟦⟨Identifier⟩⟧ @19
    | ⟦⟨Integer⟩⟧ @19
    | ⟦⟨String⟩⟧ @19
    | ⟦⟨Object⟩⟧ @19
    | ⟦⟨AnonymousFunction⟩⟧ @19
    | ⟦(⟨Expression⟩)⟧ @19
    /* Function call and Member access */
    | ⟦⟨Expression @18⟩(⟨ExpressionSequence⟩)⟧ @18
    | ⟦⟨Expression @18⟩.⟨Expression @19⟩⟧ @18
    /* Unary Operators */
    | ⟦!⟨Expression @15⟩⟧ @15
    | ⟦~⟨Expression @15⟩⟧ @15
    | ⟦-⟨Expression @15⟩⟧ @15
    | ⟦+⟨Expression @15⟩⟧ @15
    /* */
    | ⟦⟨Expression @14⟩*⟨Expression @15⟩⟧ @14
    | ⟦⟨Expression @14⟩/⟨Expression @15⟩⟧ @14
    | ⟦⟨Expression @14⟩%⟨Expression @15⟩⟧ @14
    /* */
    | ⟦⟨Expression @13⟩+⟨Expression @14⟩⟧ @13
    | ⟦⟨Expression @13⟩-⟨Expression @14⟩⟧ @13
    /* Relational Operators */
    | ⟦⟨Expression @11⟩<⟨Expression @12⟩⟧ @11
    | ⟦⟨Expression @11⟩>⟨Expression @12⟩⟧ @11
    | ⟦⟨Expression @11⟩<=⟨Expression @12⟩⟧ @11
    | ⟦⟨Expression @11⟩>=⟨Expression @12⟩⟧ @11
    | ⟦⟨Expression @10⟩==⟨Expression @11⟩⟧ @10
    | ⟦⟨Expression @10⟩!=⟨Expression @11⟩⟧ @10
    /* Bitwise Operators */
    | ⟦⟨Expression @9⟩&⟨Expression @10⟩⟧ @9
    | ⟦⟨Expression @8⟩^⟨Expression @9⟩⟧ @8
    | ⟦⟨Expression @7⟩|⟨Expression @8⟩⟧ @7
    /* */
    | ⟦⟨Expression @6⟩&&⟨Expression @7⟩⟧ @6
    | ⟦⟨Expression @5⟩||⟨Expression @6⟩⟧ @5
    /* Ternary Operator */
    | ⟦⟨Expression @5⟩?⟨Expression⟩:⟨Expression @4⟩⟧ @4
    /* Assignment Operators */
    | ⟦⟨Expression @4⟩=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩+=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩-=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩*=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩/=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩&=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩^=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩|=⟨Expression @3⟩⟧ @3
    /* Comma Operator */
    | ⟦⟨Expression @1⟩,⟨Expression @2⟩⟧ @1
    ;

    sort ExpressionSequence
    | ⟦⟧ @1
    | ⟦⟨⟦⟨Expression⟩⟧ @3
    | ⟦⟨⟦⟨Expression⟩,⟨ExpressionSequence @2⟩⟧ @2
    ;

    sort AnonymousFunction
    | ⟦function⟨CallSignature⟩{⟨StatementSequence⟩}⟧
    ;

    sort Object
    | ⟦null⟧
    | ⟦{NameValuePairSequence}⟧
    ;

    sort NameValuePair
    | ⟦⟨Identifier⟩:⟨Expression @2⟩⟧
    | ⟦⟨String⟩:⟨Expression @2⟩⟧
    ;

    sort NameValuePairSequence
    | ⟦⟧
    | ⟦⟨NameValuePair⟩⟧
    | ⟦⟨NameValuePair⟩,⟨NameValuePairSequence⟩⟧
    ;

    sort Type
    | ⟦boolean⟧
    | ⟦number⟧
    | ⟦string⟧
    | ⟦void⟧
    | ⟦⟨Identifier⟩⟧
    | ⟦(⟨TypeSequence⟩)=>⟨Type⟩⟧
    | ⟦{⟨NameTypePairSequence⟩}⟧
    ;

    sort TypeSequence
    | ⟦⟧ @1
    | ⟦⟨Type⟩⟧ @3
    | ⟦⟨Type⟩,⟨TypeSeq @2⟩⟧ @2
    ;

    sort NameTypePair
    | ⟦⟨Identifier⟩:⟨Type⟩⟧
    ;

    sort NameTypePairSequence
    | ⟦⟧
    | ⟦⟨NameTypePair⟩⟧
    | ⟦⟨NameTypePair⟩,⟨NameTypePairSequence⟩⟧
    ;

    sort Statement
    | ⟦⟨InterfaceDeclaration⟩⟧
    | ⟦⟨FunctionDeclaration⟩⟧
    | ⟦⟨Expression⟩;⟧
    | ⟦;⟧
    | ⟦{⟨StatementSequence⟩}⟧
    | ⟦var⟨VariableDeclarationSequence⟩;⟧
    | ⟦if(⟨Expression⟩)⟨Statement⟩else⟨Statement⟩⟧
    | ⟦if(⟨Expression⟩)⟨Statement⟩⟧
    | ⟦while(⟨Expression⟩)⟨Statement⟩⟧
    | ⟦return⟨Expression⟩;⟧
    | ⟦return;⟧
    ;

    sort StatementSequence
    | ⟦⟧
    | ⟦⟨Statement⟩⟨StatementSequence⟩⟧
    ;

    sort VariableDeclarationSequence
    | ⟦⟨Identifier⟩:⟨Type⟩⟧
    | ⟦⟨Identifier⟩:⟨Type⟩,⟨VariableDeclarationSequence⟩⟧
    ;

    sort InterfaceDeclaration
    | ⟦⟨Interface⟩⟨Identifier⟩{⟨InterfaceMemberSequence⟩}⟧
    ;

    sort InterfaceMember
    | ⟦⟨Identifier⟩:⟨Type⟩;⟧
    | ⟦⟨Identifier⟩⟨CallSignature⟩{⟨StatementSequence⟩};⟧
    ;

    sort InterfaceMemberSequence
    | ⟦⟧
    | ⟦⟨InterfaceMember⟩⟨InterfaceMemberSequence⟩⟧
    ;

    sort FunctionDeclaration
    | ⟦function⟨Identifier⟩⟨CallSignature⟩{⟨StatementSequence⟩}⟧
    ;

    sort CallSignature
    | ⟦(⟨ArgumentSequence⟩):⟨Type⟩⟧
    ;

    sort ArgumentSequence
    | ⟦⟧ @1
    | ⟦⟨Identifier⟩:⟨Type⟩⟧ @3
    | ⟦⟨Identifier⟩:⟨Type⟩,⟨ArgumentSequence @2⟩⟧ @2
    ;
}
