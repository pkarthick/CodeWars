proc race*(v1, v2, g: int): array[0..2, int] = 

    result = [-1, -1, -1]

    if v1 < v2:
  
      let count = int(g * 3600 / (v2 - v1))
      
      result[2] = count %% 60
      result[1] = (count div 60) %% 60
      result[0] = (count div 3600) %% 60
      
echo race(720, 850, 70)




    

