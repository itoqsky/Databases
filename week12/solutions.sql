// ex1

create(p1:Fighter{name:'Khabib Nurmagomedov', weight:'155'}), (p2:Fighter{name:'Rafael Dos Anjos', weight:'155'}),
(p3:Fighter{name:'Neil Magny', weight:'170'}), (p4:Fighter{name:'Jon Jones', weight:'205'}),
(p5:Fighter{name:'Daniel Cormier', weight:'205'}), (p6:Fighter{name:'Michael Bisping', weight:'185'}),
(p7:Fighter{name:'Matt Hamill', weight:'185'}), (p8:Fighter{name:'Brandon Vera', weight:'205'}),
(p9:Fighter{name:'Frank Mir', weight:'230'}), (p10:Fighter{name:'Brock Lesnar', weight:'230'}),
(p11:Fighter{name:'Kelvin Gastelum', weight:'185'})
create (p1)-[:beats]->(p2),  (p2)-[:beats]->(p3),
(p4)-[:beats]->(p5),(p6)-[:beats]->(p7),
(p4)-[:beats]->(p8),(p8)-[:beats]->(p9),
(p9)-[:beats]->(p10),(p3)-[:beats]->(p11),
(p11)-[:beats]->(p6),(p6)-[:beats]->(p7),
(p6)-[:beats]->(p11),(p7)-[:beats]->(p4)

-- ex2
-- 1)

match (f:Fighter)-[:beats]->()
where f.weight='155' or f.weight='170' or f.weight='185'
return distinct f

-- 2)

match (f)-[:beats]->()-[:beats]->(f) return distinct f

-- 3)
match (f:Fighter)-[]-()
with f, count(f) as fights
return f
order by fights desc
limit 1 

-- 4)
match (p:Fighter)
where not (p)-[:beats]->()
return collect(p), 
       size(collect(p))
union
match (p:Fighter)
where not ()-[:beats]->(p)
return collect(p), 
       size(collect(p))

-- match (p:Fighter) where not (p)-[:beats]->() or not ()-[:beats]->(p)
--     return p;