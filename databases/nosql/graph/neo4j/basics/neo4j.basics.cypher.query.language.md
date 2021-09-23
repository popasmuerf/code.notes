## Cyper Query Lan

// Detailed table of some of your mentions 

MATCH
    (u:User:Me)-[:POSTS]-> (t:Tweet)-[:MENTIONS]->(m:User)
RETURN
    m.screen_name AS screen_name,
COUNT(m.screen_name) AS count
ORDER BY
    count DESC
LIMIT 10


1. For all the posts associated with some tweet that mentions me
2. Return an ordered list of  screen name of every body who mentioned me.....


## My mentions
To the right is a giant code block containing a single 
Cypher query statement to determine who's mentioning you on 
Twitt
    

































































































































