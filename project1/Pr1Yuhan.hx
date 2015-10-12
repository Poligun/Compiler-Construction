module yuhan.project1.Pr1Yuhan
{
    space [ \t\f\r\n] | "/*"([^*]|\*[^/]|\n|\r\n)*"*/"  | "//".*;

    token BooleanType | boolean;
    token NumberType  | number;
    token StringType  | string;
    token VoidType    | void;

    token Var       | var;
    token If        | if;
    token Else      | else;
    token While     | while;
    token Return    | return;
    token Interface | interface;
    token Function  | function;

    token Separator  | ";";

    token Identifier | [a-zA-Z$_][a-zA-Z0-9$_]*;
    token Integer    | [0-9]+;

    token String
    | \"([^\\\"]|⟨StringEscape⟩)*\"
    | \'([^\\\']|⟨StringEscape⟩)*\'
    ;

    token fragment StringEscape
    | \\([\'\"\\nt]|(\r?\n)|(x[a-fA-F0-9][a-fA-F0-9])); 

    /*
    main sort Program
    | ⟦⟨StatementSeq⟩⟧
    ;
    */ //Currently disabled to comform to project 1 requirement.

    main sort Program
    | ⟦⟨DecSeq⟩⟨Statement⟩⟧ @2
    | ⟦⟨Program @1⟩⟨Statement⟩⟧ @1
    | ⟦⟨Program @1⟩⟨IntDec⟩⟧ @1
    | ⟦⟨Program @1⟩⟨FuncDec⟩⟧ @1
    ;

    sort E
    /* | ⟦⟨AnonFunc⟩⟧ @19 */ //Currently disabled to comform to project 1 requirement.
    | ⟦⟨Identifier⟩⟧ @19 | ⟦⟨Integer⟩⟧ @19 | ⟦⟨String⟩⟧ @19 | ⟦⟨Object⟩⟧ @19 | ⟦(⟨E⟩)⟧ @19
    | ⟦⟨E @18⟩(⟨ExpSeq⟩)⟧ @18 | ⟦⟨E @18⟩.⟨E @19⟩⟧ @18
    | ⟦!⟨E @15⟩⟧ @15 | ⟦~⟨E @15⟩⟧ @15 | ⟦-⟨E @15⟩⟧ @15 | ⟦+⟨E @15⟩⟧ @15
    | ⟦⟨E @14⟩*⟨E @15⟩⟧ @14 | ⟦⟨E @14⟩/⟨E @15⟩⟧ @14 | ⟦⟨E @14⟩%⟨E @15⟩⟧ @14
    | ⟦⟨E @13⟩+⟨E @14⟩⟧ @13 | ⟦⟨E @13⟩-⟨E @14⟩⟧ @13
    | ⟦⟨E @11⟩<⟨E @12⟩⟧ @11 | ⟦⟨E @11⟩>⟨E @12⟩⟧ @11 | ⟦⟨E @11⟩<=⟨E @12⟩⟧ @11 | ⟦⟨E @11⟩>=⟨E @12⟩⟧ @11
    | ⟦⟨E @10⟩==⟨E @11⟩⟧ @10 | ⟦⟨E @10⟩!=⟨E @11⟩⟧ @10
    | ⟦⟨E @9⟩&⟨E @10⟩⟧ @9
    | ⟦⟨E @8⟩^⟨E @9⟩⟧ @8
    | ⟦⟨E @7⟩|⟨E @8⟩⟧ @7
    | ⟦⟨E @6⟩&&⟨E @7⟩⟧ @6
    | ⟦⟨E @5⟩||⟨E @6⟩⟧ @5
    | ⟦⟨E @5⟩?⟨E⟩:⟨E @4⟩⟧ @4 //Here ternary operator is right associative
    | ⟦⟨E @4⟩=⟨E @3⟩⟧ @3 | ⟦⟨E @4⟩+=⟨E @3⟩⟧ @3 | ⟦⟨E @4⟩-=⟨E @3⟩⟧ @3 | ⟦⟨E @4⟩*=⟨E @3⟩⟧ @3 | ⟦⟨E @4⟩/=⟨E @3⟩⟧ @3
    | ⟦⟨E @4⟩&=⟨E @3⟩⟧ @3 | ⟦⟨E @4⟩^=⟨E @3⟩⟧ @3 | ⟦⟨E @4⟩|=⟨E @3⟩⟧ @3
    | ⟦⟨E @1⟩,⟨E @2⟩⟧ @1 //Comma Sequence has the lowest precedence
    ;

    sort ExpSeq
    | ⟦⟨ExpSeq @2⟩,⟨E⟩⟧ @2 | ⟦⟨E⟩⟧ @3 | ⟦⟧ @1
    ;

    sort Object
    | ⟦{⟨NVPairSeq⟩}⟧
    ;

    sort NameValuePair
    | ⟦⟨Identifier⟩:⟨E @4⟩⟧
    | ⟦⟨String⟩:⟨E @4⟩⟧
    ;

    sort NVPairSeq
    | ⟦⟨NameValuePair⟩,⟨NVPairSeq⟩⟧ | ⟦⟨NameValuePair⟩⟧ | ⟦⟧
    ;

    sort T
    | ⟦⟨BooleanType⟩⟧ | ⟦⟨NumberType⟩⟧ | ⟦⟨StringType⟩⟧ | ⟦⟨VoidType⟩⟧
    | ⟦⟨Identifier⟩⟧
    | ⟦(⟨TypeSeq⟩)=>⟨T⟩⟧
    | ⟦{⟨NTPairSeq⟩}⟧
    ;

    sort TypeSeq
    | ⟦⟨TypeSeq @2⟩,⟨T⟩⟧ @2 | ⟦⟨T⟩⟧ @3 | ⟦⟧ @1
    ;

    sort NameTypePair
    | ⟦⟨Identifier⟩:⟨T⟩⟧
    ;

    sort NTPairSeq
    | ⟦⟨NTPairSeq @2⟩,⟨NameTypePair⟩⟧ @2 | ⟦⟨NameTypePair⟩⟧ @3 | ⟦⟧ @1
    ;

    sort Statement
    /* | ⟦⟨IntDec⟩⟧ | ⟦⟨FuncDec⟩⟧ */ //Currently disabled to comform to project 1 requirement.
    | ⟦⟨E⟩⟨Separator⟩⟧
    | ⟦⟨Separator⟩⟧
    | ⟦{⟨StatementSeq⟩}⟧
    | ⟦⟨Var⟩⟨VarDecSeq⟩⟨Separator⟩⟧
    | ⟦⟨If⟩(⟨E⟩)⟨Statement⟩⟨Else⟩⟨Statement⟩⟧
    | ⟦⟨If⟩(⟨E⟩)⟨Statement⟩⟧
    | ⟦⟨While⟩(⟨E⟩)⟨Statement⟩⟧
    | ⟦⟨Return⟩⟨E⟩⟨Separator⟩⟧
    | ⟦⟨Return⟩⟨Separator⟩⟧
    ;

    sort StatementSeq
    | ⟦⟨StatementSeq @1⟩⟨Statement⟩⟧ @1 | ⟦⟧ @2
    ;

    sort VarDecSeq //Variable Declaration Sequence
    | ⟦⟨VarDecSeq @2⟩,⟨Identifier⟩:⟨T⟩⟧ @1 | ⟦⟨Identifier⟩:⟨T⟩⟧ @2
    ;

    sort DecSeq
    | ⟦⟧ @2
    | ⟦⟨DecSeq @1⟩⟨IntDec⟩⟧ @1
    | ⟦⟨DecSeq @1⟩⟨FuncDec⟩⟧ @1
    ;

    sort IntDec
    | ⟦⟨Interface⟩⟨Identifier⟩{⟨MemberSeq⟩}⟧
    ;

    sort MemberSeq
    | ⟦⟨MemberSeq @1⟩⟨Member⟩⟧ @1 | ⟦⟧ @2
    ;

    sort Member
    | ⟦⟨Identifier⟩:⟨T⟩⟨Separator⟩⟧
    | ⟦⟨Identifier⟩⟨CallSignature⟩{⟨StatementSeq⟩}⟨Separator⟩⟧
    ;

    sort FuncDec
    | ⟦⟨Function⟩⟨Identifier⟩⟨CallSignature⟩{⟨StatementSeq⟩}⟧
    ;

    sort AnonFunc
    | ⟦⟨Function⟩⟨CallSignature⟩{⟨StatementSeq⟩}⟧
    ;

    sort CallSignature
    | ⟦(⟨ArgSeq⟩):⟨T⟩⟧
    ;

    sort ArgSeq
    | ⟦⟨ArgSeq @2⟩,⟨Identifier⟩:⟨T⟩⟧ @2 | ⟦⟨Identifier⟩:⟨T⟩⟧ @3 | ⟦⟧ @1
    ;
}
