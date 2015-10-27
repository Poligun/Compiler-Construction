module yuhan.project2.Pr2Yuhan
{
    /* Whitespace & comment that are ignored */
    space [ \t\r\n]
    | "//".*
y    | "/*"([^*]|"*"[^/]|\r?\n)*"*/"
    ;

    token Identifier | [a-zA-Z$_][a-zA-Z0-9$_]*;
    token Integer    | [0-9]+;

    token String
    | \"([^\\\"\r\n]|⟨Escape⟩)*\"
    | \'([^\\\'\r\n]|⟨Escape⟩)*\'
    ;

    token fragment HexDigit | [0-9a-fA-F];
    token fragment Escape | \\([\'\"\\nt]|(\r?\n)|(x⟨HexDigit⟩⟨HexDigit⟩));
    
    main sort Program
    | ⟦ ⟨StatementList⟩ ⟧
    ;

    sort StatementList
    | ⟦⟧
    | ⟦ ⟨Statement⟩ ⟨StatementList⟩ ⟧
    ;

    sort Statement
    | ⟦ var ⟨NameTypePairList⟩ ; ⟧
    | ⟦ function ⟨Identifier⟩ ⟨FunctionBody⟩ ⟧
    | ⟦ interface ⟨Identifier⟩ { ⟨InterfaceMemberList⟩ } ⟧
    | ⟦ ⟨Expression⟩ ; ⟧
    | ⟦ ; ⟧
    | ⟦ { ⟨StatementList⟩ } ⟧
    | ⟦ if ( ⟨Expression⟩ ) ⟨Statement⟩ else ⟨Statement⟩ ⟧
    | ⟦ if ( ⟨Expression⟩ ) ⟨Statement⟩ ⟧
    | ⟦ while ( ⟨Expression⟩ ) ⟨Statement⟩ ⟧
    | ⟦ return ⟨Expression⟩ ; ⟧
    | ⟦ return ; ⟧
    ;

    sort NameTypePair
    | ⟦ ⟨Identifier⟩ : ⟨Type⟩ ⟧
    ;

    sort NameTypePairList
    | ⟦⟧ @1
    | ⟦ ⟨NameTypePair⟩ ⟧ @2
    | ⟦ ⟨NameTypePair⟩ , ⟨NameTypePairList⟩ ⟧ @2
    ;
    
    sort Type
    | ⟦ boolean ⟧
    | ⟦ number ⟧
    | ⟦ string ⟧
    | ⟦ void ⟧
    | ⟦ ⟨Identifier⟩ ⟧
    | ⟦ ( ⟨TypeList⟩ ) => ⟨Type⟩ ⟧
    | ⟦ { ⟨NameTypePairList⟩ } ⟧
    ;

    sort TypeList
    | ⟦⟧ @1
    | ⟦ ⟨Type⟩ ⟧ @2
    | ⟦ ⟨Type⟩ , ⟨TypeList @2⟩ ⟧ @2
    ;

    sort InterfaceMember
    | ⟦ ⟨NameTypePair⟩ ; ⟧
    | ⟦ ⟨Identifier⟩ ⟨FunctionBody⟩ ; ⟧
    ;

    sort InterfaceMemberList
    | ⟦⟧
    | ⟦ ⟨InterfaceMember⟩ ⟨InterfaceMemberList⟩ ⟧
    ;

    sort FunctionBody
    | ⟦ ⟨CallSignature⟩ { ⟨StatementList⟩ } ⟧
    ;

    sort CallSignature
    | ⟦ ( ⟨NameTypePairList⟩ ) : ⟨Type⟩ ⟧
    ;

    sort AnonymousFunction
    | ⟦ function ⟨FunctionBody⟩ ⟧
    ;

    sort Object
    | ⟦ { ⟨NameValuePairList⟩ } ⟧
    ;

    sort NameValuePair
    | ⟦ ⟨Identifier⟩ : ⟨Expression @2⟩ ⟧
    | ⟦ ⟨String⟩ : ⟨Expression @2⟩ ⟧
    ;

    sort NameValuePairList
    | ⟦⟧
    | ⟦ ⟨NameValuePair⟩ ⟧
    | ⟦ ⟨NameValuePair⟩ , ⟨NameValuePairList⟩ ⟧
    ;
    
    sort ExpressionList
    | ⟦⟧ @1
    | ⟦ ⟨Expression @2⟩ ⟧ @2
    | ⟦ ⟨Expression @2⟩ , ⟨ExpressionList @2⟩ ⟧ @2
    ;

    sort Expression
    // Primitives have the highest precedence
    | ⟦ ⟨AnonymousFunction⟩ ⟧ @19
    | ⟦ ⟨Identifier⟩ ⟧ @19
    | ⟦ ⟨Integer⟩ ⟧ @19
    | ⟦ ⟨String⟩ ⟧ @19
    | ⟦ ⟨Object⟩ ⟧ @19
    | sugar ⟦ ( ⟨Expression #⟩ ) ⟧ @19 → #
    // Function call and Member access
    | ⟦ ⟨Expression @18⟩ ( ⟨ExpressionList⟩ ) ⟧ @18
    | ⟦ ⟨Expression @18⟩ . ⟨Identifier⟩ ⟧ @18
    // Unary Operators
    | ⟦ ! ⟨Expression @15⟩ ⟧ @15
    | ⟦ ~ ⟨Expression @15⟩ ⟧ @15
    | ⟦ - ⟨Expression @15⟩ ⟧ @15
    | ⟦ + ⟨Expression @15⟩ ⟧ @15
    // Arithmetic Operators
    | ⟦ ⟨Expression @14⟩ * ⟨Expression @15⟩ ⟧ @14
    | ⟦ ⟨Expression @14⟩ / ⟨Expression @15⟩ ⟧ @14
    | ⟦ ⟨Expression @14⟩ % ⟨Expression @15⟩ ⟧ @14
    // Arithmetic Operators
    | ⟦ ⟨Expression @13⟩ + ⟨Expression @14⟩ ⟧ @13
    | ⟦ ⟨Expression @13⟩ - ⟨Expression @14⟩ ⟧ @13
    // Relational Operators
    | ⟦ ⟨Expression @11⟩ <  ⟨Expression @12⟩ ⟧ @11
    | ⟦ ⟨Expression @11⟩ >  ⟨Expression @12⟩ ⟧ @11
    | ⟦ ⟨Expression @11⟩ <= ⟨Expression @12⟩ ⟧ @11
    | ⟦ ⟨Expression @11⟩ >= ⟨Expression @12⟩ ⟧ @11
    | ⟦ ⟨Expression @10⟩ == ⟨Expression @11⟩ ⟧ @10
    | ⟦ ⟨Expression @10⟩ != ⟨Expression @11⟩ ⟧ @10
    // Bitwise Operators
    | ⟦ ⟨Expression @9⟩ & ⟨Expression @10⟩ ⟧ @9
    | ⟦ ⟨Expression @8⟩ ^ ⟨Expression @9⟩ ⟧ @8
    | ⟦ ⟨Expression @7⟩ | ⟨Expression @8⟩ ⟧ @7
    // Logical Operators
    | ⟦ ⟨Expression @6⟩ && ⟨Expression @7⟩ ⟧ @6
    | ⟦ ⟨Expression @5⟩ || ⟨Expression @6⟩ ⟧ @5
    // Ternary Operator
    | ⟦ ⟨Expression @5⟩ ? ⟨Expression @2⟩ : ⟨Expression @2⟩ ⟧ @4
    // Assignment Operators
    | ⟦ ⟨Expression @4⟩ =  ⟨Expression @3⟩ ⟧ @3
    | ⟦ ⟨Expression @4⟩ += ⟨Expression @3⟩ ⟧ @3
    | ⟦ ⟨Expression @4⟩ -= ⟨Expression @3⟩ ⟧ @3
    | ⟦ ⟨Expression @4⟩ *= ⟨Expression @3⟩ ⟧ @3
    | ⟦ ⟨Expression @4⟩ /= ⟨Expression @3⟩ ⟧ @3
    | ⟦ ⟨Expression @4⟩ &= ⟨Expression @3⟩ ⟧ @3
    | ⟦ ⟨Expression @4⟩ ^= ⟨Expression @3⟩ ⟧ @3
    | ⟦ ⟨Expression @4⟩ |= ⟨Expression @3⟩ ⟧ @3
    // Comma Operator
    | ⟦ ⟨Expression @1⟩ , ⟨Expression @2⟩ ⟧ @1
    ;

    // Function declarations are treated as variable declarations
    sort DecType
    | ⟦Variable⟧
    | ⟦Interface⟧
    ;

    sort Declaration
    | ⟦ ⟨Identifier⟩ ⟨DecType⟩ ⟧
    ;

    sort DeclarationList
    | ⟦⟧
    | ⟦ ⟨Declaration⟩ ⟨DeclarationList⟩ ⟧
    ;

    attribute ↑decs(DeclarationList);

    sort Statement | ↑decs;
    ⟦ var ⟨NameTypePairList ↑decs(#decs1)⟩ ; ⟧ ↑decs(#decs1);
    ⟦ function ⟨Identifier #1⟩ ⟨FunctionBody⟩ ⟧
      ↑decs(⟦ ⟨Declaration ⟦ #1 ⟨DecType ⟦Variable⟧⟩ ⟧⟩ ⟨DeclarationList ⟦⟧⟩ ⟧);
}
