module yuhan.project1.Pr1Yuhan
{
  //space [ \t\f\r\n] | nested "/*" "*/" | "//".*;

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

    token Identifier | [a-zA-Z$_][a-zA-Z0-9$_]*;
    token Integer    | [0-9]+;
    token String     | \' .* \';

    //    token fragment Escape | \\[];

    //token SingleLineComment | \/\/.*$;
    //token MultiLineComment  | /\*[.\n\r]*\*/;

    main sort Program
    | ⟦⟨StatementSeq⟩⟧
    ;
    
    sort E
    | ⟦⟨Identifier⟩⟧ @19 | ⟦⟨Integer⟩⟧ @19 | ⟦⟨String⟩⟧ @19 | ⟦(⟨E⟩)⟧ @19
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
    | ⟦⟨E @4⟩=⟨E @3⟩⟧ @3 | ⟦⟨E @4⟩+=⟨E @3⟩⟧ @3 // Missing
    | ⟦⟨E @1⟩,⟨E @2⟩⟧ @1 //Comma Sequence has the lowest precedence
    ;

    sort ExpSeq
    | ⟦⟨ExpSeq @2⟩,⟨E⟩⟧ @2 | ⟦⟨E⟩⟧ @3 | ⟦⟧ @1
    ;

    sort T
    | ⟦⟨BooleanType⟩⟧ | ⟦NumberType⟧ | ⟦StringType⟧ | ⟦⟨VoidType⟩⟧
    | ⟦⟨Identifier⟩⟧
    | ⟦(⟨TypeSeq⟩)=>⟨T⟩⟧
    ;

    sort TypeSeq
    | ⟦⟨TypeSeq @2⟩,⟨T⟩⟧ @2 | ⟦⟨T⟩⟧ @3 | ⟦⟧ @1
    ;

    sort Statement
    | ⟦⟨IntDec⟩⟧ | ⟦⟨FuncDec⟩⟧
    | ⟦{⟨StatementSeq⟩}⟧
    | ⟦⟨Var⟩⟨VarDecSeq⟩;⟧
    | ⟦⟨E⟩;⟧
    | ⟦⟨While⟩(⟨E⟩)⟨Statement⟩⟧
    | ⟦⟨Return⟩⟨E⟩;⟧
    | ⟦⟨Return⟩;⟧
    ;

    sort StatementSeq
    | ⟦⟨StatementSeq @2⟩⟨Statement⟩⟧ @2 | ⟦⟨Statement⟩⟧ @3 | ⟦⟧ @1
    ;

    sort VarDecSeq //Variable Declaration Sequence
    | ⟦⟨VarDecSeq @2⟩,⟨Identifier⟩:⟨T⟩⟧ @1 | ⟦⟨Identifier⟩:⟨T⟩⟧ @2
    ;

    sort IntDec
    | ⟦⟨Interface⟩⟨Identifier⟩{⟨MemberSeq⟩}⟧
    ;

    sort MemberSeq
    | ⟦⟨MemberSeq @2⟩⟨Member⟩⟧ @2 | ⟦⟨Member⟩⟧ @3 | ⟦⟧ @1
    ;

    sort Member
    | ⟦⟨Identifier⟩:⟨T⟩;⟧
    | ⟦⟨Identifier⟩⟨CallSignature⟩{⟨StatementSeq⟩};⟧
    ;

    sort FuncDec
    | ⟦⟨Function⟩⟨Identifier⟩⟨CallSignature⟩{⟨StatementSeq⟩}⟧
    ;

    sort CallSignature
    | ⟦(⟨ArgSeq⟩):⟨T⟩⟧
    ;

    sort ArgSeq
    | ⟦⟨ArgSeq @2⟩,⟨Identifier⟩:⟨T⟩⟧ @2 | ⟦⟨Identifier⟩:⟨T⟩⟧ @3 | ⟦⟧ @1
    ;
}
