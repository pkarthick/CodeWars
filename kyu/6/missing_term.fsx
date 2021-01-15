type 'a IList = 'a System.Collections.Generic.IList

let findMissing (items : int IList) = 
    let d0 = items.[1] - items.[0]
    let dl = items.[items.Count - 1] - items.[items.Count - 2]

    if items.Count = 3 then
      if items.[1] + dl + dl = items.[2] then
        items.[1] + dl
      else
        items.[0] + dl
    else
      
      if d0 = dl then
        let filtered =
          items
          |> Seq.toList
          |> List.pairwise
          |> List.map (fun (x, y ) -> (x, y), y - x)
          |> List.filter(fun (tup, dif)  -> dif <> d0)
          
        (filtered.[0] |> fst |> fst) + d0

      else
        let d1 = items.[2] - items.[1]
        if d0 = d1 then
          items.[items.Count - 1] - d0
        else
          items.[0] + dl

[
  7, [|1; 3; 5; 9; 11|]
  15, [|0; 5; 10; 20; 25|]
  10, [|0; 1; 2; 3; 4; 5; 6; 7; 8; 9; 11|]
  1400, [|1040; 1220; 1580|]
  1220, [|1040; 1400; 1580|]
]
|> List.map (fun (miss, xs) -> findMissing xs = miss)
|> printfn "%A"
