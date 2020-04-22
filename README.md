BBYS
====

A PICO8 game for [ludum dare 46](https://ldjam.com)

Play the demo here: https://lambdanaut.itch.io/bbys?secret=NUlT5Ed6Qz6PQk26dCnJywlzyG4


…∧░➡️⧗▤⬆️☉🅾️◆█★⬇️✽●♥웃⌂⬅️▥❎🐱ˇ▒♪😐


Notes
-----

* Item modifiers
  * Alien: Randomly scrambles position of all bbys and enemies when picked up
  * Bandana: Damages monsters on contact
  * Box: Stops wandering
  * Bra: Stops life slowly dropping from hunger
  * Cap: It's just a hat
  * Clown nose: Heals all bbys on screen when picked up
  * Crown: Randomly generates rocks when picked up
  * Dress: Heals colliding bbys
  * Eyepatch: One bat dies on screen when its picked up
  * Flower in hair: Randomly generates food when picked up
  * Karate headband: Destroys rocks on collision
  * Mask: Deprioritizes from enemy target
  * Pants: Makes player faster while colliding
  * Thick coat(Kenny): Makes invulnerable
  * Wig: Makes all enemies prioritize this bbys_pos
  * Sunglasses: Slows all bats

TODO
----

* Fix rock collisions. We shouldn't ever get stuck on a rock. 
* Fix it so with the crown, when destroying rocks, you don't always pick the food up right away.
* WHY DOES bby.collide CALL ITSELF AGAIN AT THE END WTF
* Make the bandana fire projectiles, not damage enemies on contact



Refactoring Notes
-----------------

* Can replace all tile_to_pixel_pos calls with multiplication by 8.
* Remove unused player.movement_enabled if it is unused
* Replace array length using # with `add` function
* Delete unused sprites(palm tree)
