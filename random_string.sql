with
randomNumbers (rownbr, randnbr) AS
(
    values (1, int(rand() * 100000))
  UNION ALL
    select rownbr + 1, int(rand() * 100000)
    from randomNumbers
    where rownbr < 64
)
,
randomCharacters (randchr) AS
(
    select substr('ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwzyz023456789@#$%&*_', 
               int(mod(randnbr*0.1 ,64)+1), 1) 
    from randomNumbers
)
SELECT LISTAGG(randchr , '') as randomString 
FROM randomCharacters
