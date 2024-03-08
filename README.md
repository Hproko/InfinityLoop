

Artes
  - As artes foram escolhidas do site itch.io - https://cypor.itch.io/12x12-rpg-tileset
-> nesse tileset temos o mapa e um personagem

-> O godot cria automaticamente o atlas (corta as tiles para que a gente possa usar)
-> A animação do personagem foi feita usando o AnimatedSprite2D, bem simples


Movimentação

-> a movimentação do personagem foi feita da maneira que é ensinada no tutorial do site do godot


Mapa

-> O mapa foi criado manualmente, foram criadas várias layers:
	
	água
	terreno
	sobreterreno
	sobreterreno2
	sobreterreno3
	behind
	
	
-> Para adicionar colisão fizemos o player ter um collisionbody2d
-> E no mapa é possível adicionar uma camada física nos tiles, onde eles tem um collisionbody próprio



