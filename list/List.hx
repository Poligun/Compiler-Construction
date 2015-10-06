module zyh.hw4.List
{
  token NUM | [+-]?[0-9]+;

  main sort L
  | ⟦⟨NUM⟩ ⟨L⟩⟧
  | ⟦{⟨L⟩} ⟨L⟩⟧
  | ⟦⟧;

  sort Computed;

  | scheme Product(L);
  Product(#) → ProductIter(#, ⟦1⟧);

  | scheme ProductIter(L, Computed);
  ProductIter(⟦⟧, #p) → #p;
  ProductIter(⟦⟨NUM#1⟩⟨L#2⟩⟧, #p) → ProductIter(#2, ⟦$#1 * #p⟧);
  ProductIter(⟦{⟨L#1⟩}⟨L#2⟩⟧, #p) → ProductIter(#2, Times(Product(#1), #p));

  | scheme Times(Computed, Computed);
  Times(#1, #2) → ⟦#1 * #2⟧;			

  sort L;
  | scheme Flatten(L);
  Flatten(#) → FlattenRecur(#, ⟦⟧);

  | scheme FlattenRecur(L, L);
  FlattenRecur(⟦⟧, #) → #;
  FlattenRecur(⟦⟨NUM#1⟩⟨L#2⟩⟧, #3) → ⟦⟨NUM#1⟩⟨L FlattenRecur(#2, #3)⟩⟧;
  FlattenRecur(⟦{⟨L#1⟩}⟨L#2⟩⟧, #3) → FlattenRecur(#1, FlattenRecur(#2, #3));

  | scheme Reverse(L);
  Reverse(#) → ReverseIter(#, ⟦⟧);

  | scheme ReverseIter(L, L);
  ReverseIter(⟦⟧, #) → #;
  ReverseIter(⟦⟨NUM#1⟩⟨L#2⟩⟧, #3) → ReverseIter(#2, ⟦⟨NUM#1⟩⟨L#3⟩⟧);
  ReverseIter(⟦{⟨L#1⟩}⟨L#2⟩⟧, #3) → ReverseIter(#2, ⟦{⟨L Reverse(#1)⟩}⟨L#3⟩⟧);

}
