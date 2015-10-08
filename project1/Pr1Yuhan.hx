module yuhan.project1.Pr1Yuhan
{
    token Identifier | [a-zA-Z$_][a-zA-Z0-9$_]*;
    token Integer    | [0-9]+;
    token String     | \'\';

    token SingleLineComment | //.*$;
    token MultiLineComment  | /\*[.\n\r]*\*/;

    sort E
    | ⟦⟨Identifier⟩⟧ | ⟦⟨Integer⟩⟧ | ⟦⟨String⟩⟧ | ⟦⟨E #⟩⟧
    | ⟦⟨E #⟩.⟨E #⟩⟧
    | ⟦⟨E #⟩@2?⟨E #⟩@1:⟨E #⟩⟧@1
    | ⟦⟨E #⟩@2=⟨E #⟩@1⟧@1 | ⟦⟨E #⟩@2+=⟨E #⟩@1⟧@1 | 
    ;
}
