module yuhan.project2.Pr2Yuhan
{
    /* Whitespace & comment that are ignored */
    space [ \t\r\n]
    | "//".*
    | "/*"([^*]|"*"[^/]|\r?\n)*"*/"
    ;

    /* If this separator weren't defined but embedded instead,
     * hacs wouldn't be able to recognized statements like
     * 'x = {};'
     */
    token Separator | ";";

    // Reserved words
    token Var | "var";
    token Function | "function";
    token Interface | "interface";

    token If     | "if";
    token Else   | "else";
    token Return | "return";

    token While | "while";

    token Null      | "null";
    token Undefined | "undefined";

    token BooleanType | boolean;
    token NumberType  | number;
    token StringType  | string;
    token VoidType    | void;

    token Identifier | [a-zA-Z$_][a-zA-Z0-9$_]*;
    token Integer    | [0-9]+;

    token String
    | \"([^\\\"\r\n]|⟨Escape⟩)*\"
    | \'([^\\\'\r\n]|⟨Escape⟩)*\'
    ;

    token fragment HexDigit | [0-9a-fA-F];
    token fragment Escape | \\([\'\"\\nt]|(\r?\n)|(x⟨HexDigit⟩⟨HexDigit⟩));
    
    main sort Program
    | ⟦⟨StatementSequence⟩⟧
    ;

    sort Expression
    // Primitives have the highest precedence
    | ⟦⟨AnonymousFunction⟩⟧ @19
    | ⟦⟨Identifier⟩⟧ @19
    | ⟦⟨Integer⟩⟧ @19
    | ⟦⟨String⟩⟧ @19
    | ⟦⟨Object⟩⟧ @19
    | ⟦⟨Undefined⟩⟧ @19
    | sugar ⟦(⟨Expression #⟩)⟧ @19 → #
    // Function call and Member access
    | ⟦⟨Expression @18⟩(⟨ExpressionSequence⟩)⟧ @18
    | ⟦⟨Expression @18⟩.⟨Expression @19⟩⟧ @18
    // Unary Operators
    | ⟦!⟨Expression @15⟩⟧ @15
    | ⟦~⟨Expression @15⟩⟧ @15
    | ⟦-⟨Expression @15⟩⟧ @15
    | ⟦+⟨Expression @15⟩⟧ @15
    // Arithmetic Operators
    | ⟦⟨Expression @14⟩*⟨Expression @15⟩⟧ @14
    | ⟦⟨Expression @14⟩/⟨Expression @15⟩⟧ @14
    | ⟦⟨Expression @14⟩%⟨Expression @15⟩⟧ @14
    // Arithmetic Operators
    | ⟦⟨Expression @13⟩+⟨Expression @14⟩⟧ @13
    | ⟦⟨Expression @13⟩-⟨Expression @14⟩⟧ @13
    // Relational Operators
    | ⟦⟨Expression @11⟩<⟨Expression @12⟩⟧ @11
    | ⟦⟨Expression @11⟩>⟨Expression @12⟩⟧ @11
    | ⟦⟨Expression @11⟩<=⟨Expression @12⟩⟧ @11
    | ⟦⟨Expression @11⟩>=⟨Expression @12⟩⟧ @11
    | ⟦⟨Expression @10⟩==⟨Expression @11⟩⟧ @10
    | ⟦⟨Expression @10⟩!=⟨Expression @11⟩⟧ @10
    // Bitwise Operators
    | ⟦⟨Expression @9⟩&⟨Expression @10⟩⟧ @9
    | ⟦⟨Expression @8⟩^⟨Expression @9⟩⟧ @8
    | ⟦⟨Expression @7⟩|⟨Expression @8⟩⟧ @7
    // Logical Operators
    | ⟦⟨Expression @6⟩&&⟨Expression @7⟩⟧ @6
    | ⟦⟨Expression @5⟩||⟨Expression @6⟩⟧ @5
    // Ternary Operator
    | ⟦⟨Expression @5⟩?⟨Expression⟩:⟨Expression @4⟩⟧ @4
    // Assignment Operators
    | ⟦⟨Expression @4⟩=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩+=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩-=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩*=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩/=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩&=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩^=⟨Expression @3⟩⟧ @3
    | ⟦⟨Expression @4⟩|=⟨Expression @3⟩⟧ @3
    // Comma Operator
    | ⟦⟨Expression @1⟩,⟨Expression @2⟩⟧ @1
    ;
    
    sort ExpressionSequence
    | ⟦⟧ @1
    | ⟦⟨Expression @2⟩⟧ @2
    | ⟦⟨Expression @2⟩,⟨ExpressionSequence @2⟩⟧ @2
    ;

    sort Object
    | ⟦⟨Null⟩⟧
    | ⟦{⟨NameValuePairSequence⟩}⟧
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
    | ⟦⟨BooleanType⟩⟧
    | ⟦⟨NumberType⟩⟧
    | ⟦⟨StringType⟩⟧
    | ⟦⟨VoidType⟩⟧
    | ⟦⟨Identifier⟩⟧
    | ⟦(⟨TypeSequence⟩)=>⟨Type⟩⟧
    | ⟦{⟨NameTypePairSequence⟩}⟧
    ;

    sort TypeSequence
    | ⟦⟧ @1
    | ⟦⟨Type⟩⟧ @2
    | ⟦⟨Type⟩,⟨TypeSequence @2⟩⟧ @2
    ;

    sort NameTypePair
    | ⟦⟨Identifier⟩:⟨Type⟩⟧
    ;

    sort NameTypePairSequence
    | ⟦⟧ @1
    | ⟦⟨NameTypePair⟩⟧ @2
    | ⟦⟨NameTypePair⟩,⟨NameTypePairSequence⟩⟧ @2
    ;

    sort InterfaceMember
    | ⟦⟨Identifier⟩:⟨Type⟩⟨Separator⟩⟧
    | ⟦⟨Identifier⟩⟨CallSignature⟩{⟨StatementSequence⟩}⟨Separator⟩⟧
    ;

    sort InterfaceMemberSequence
    | ⟦⟧
    | ⟦⟨InterfaceMember⟩⟨InterfaceMemberSequence⟩⟧
    ;

    sort AnonymousFunction
    | ⟦⟨Function⟩⟨CallSignature⟩{⟨StatementSequence⟩}⟧
    ;

    sort CallSignature
    | ⟦(⟨NameTypePairSequence⟩):⟨Type⟩⟧
    ;

    sort Statement
    | ⟦⟨Var⟩⟨NameTypePairSequence⟩⟨Separator⟩⟧
    | ⟦⟨Function⟩⟨Identifier⟩⟨CallSignature⟩{⟨StatementSequence⟩}⟧
    | ⟦⟨Interface⟩⟨Identifier⟩{⟨InterfaceMemberSequence⟩}⟧
    | ⟦⟨Expression⟩⟨Separator⟩⟧
    | ⟦⟨Separator⟩⟧
    | ⟦{⟨StatementSequence⟩}⟧
    | ⟦⟨If⟩(⟨Expression⟩)⟨Statement⟩⟨Else⟩⟨Statement⟩⟧
    | ⟦⟨If⟩(⟨Expression⟩)⟨Statement⟩⟧
    | ⟦⟨While⟩(⟨Expression⟩)⟨Statement⟩⟧
    | ⟦⟨Return⟩⟨Expression⟩⟨Separator⟩⟧
    | ⟦⟨Return⟩⟨Separator⟩⟧
    ;

    sort StatementSequence
    | ⟦⟧
    | ⟦⟨Statement⟩⟨StatementSequence⟩⟧
    ;
}
