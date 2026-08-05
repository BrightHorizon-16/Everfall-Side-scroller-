# Milestone 0 — Foundation

- [x] Project created
- [ ] Git repository connected — local repo + .gitignore are set up; pushing to a remote (GitHub, etc.) needs to happen on your end since it requires your credentials
- [x] Project settings configured — 1280x720 viewport, canvas_items stretch, GL Compatibility renderer (chosen for eventual web export)
- [x] Input actions created — move_left (A / Left Arrow), move_right (D / Right Arrow), jump (Space)
- [x] Main scene created — Main > World, Player, Camera, UI
- [x] Player scene created — CharacterBody2D with a single-purpose Movement component script
- [x] Camera follows player — lerp-based follow script on Camera (sibling of Player, not a child)
- [ ] Browser export works — needs export templates set up in the Godot editor; not attempted yet

---

# Milestone 1 — Combat Foundation

- [x] `Health` component (generic, reused by Player and enemies)
- [x] `Combat` component (Player) — one basic attack, Area2D hitbox, no combos
- [x] `Hurtbox` / `Hitbox` generic components (shared, not duplicated per-entity)
- [x] `Chaser` enemy — chases player in range, deals contact damage, has Health
- [x] Enemy death = despawn (`queue_free`), Player death = reset position
- [ ] Everything else in the design doc (other weapons, ranged, magic, poise/stagger, other enemy types, animations, death-drop/decay, inventory) — intentionally deferred, not started

---

# Milestone 2 — Weapon Variety

- [x] `Weapon` Resource (data-only: damage, speed, reach, hitbox size)
- [x] `Combat.gd` reads stats from the equipped `Weapon` instead of hardcoded values
- [x] Three weapons as data: Sword (balanced), Dagger (fast/short/low damage), Spear (long reach, slower)
- [x] Temporary test-only weapon switching (keys 1/2/3) via `WeaponTestSwitcher`
- [ ] Combo chains, heavy attacks, poise/crit/stat scaling, other weapon types, real inventory UI — intentionally deferred

## Notes / things you may want to review
- A temporary placeholder floor (gray rectangle, "TestFloor") was added inside World purely so gravity/jumping can be tested. It's not real level geometry — delete or replace whenever you start building actual rooms.
- Player and floor are untextured colored shapes (Polygon2D) since no art/animation work has been done yet.
- No Inventory or Animation scripts/nodes have been created yet — out of scope so far.
- **Milestone 1 additions:** `attack` input action bound to J (pick was arbitrary, easy to rebind). Player and Chaser roots now have thin coordinator scripts (`player.gd`, `chaser.gd`) whose only job is reacting to the `died` signal — this is new, they were script-less containers before. A `TestChaser` instance was added to `World` near the player spawn purely to make combat testable, same spirit as `TestFloor` — not real level content. Collision layers 1-7 are named in Project Settings → Layer Names for clarity.
- **Deferred by request:** player/enemy bodies currently don't physically collide (each only collides with `world`), just their hitbox/hurtbox areas interact. You want physical body collision added later, once more content exists — not done yet, flagging so it isn't forgotten.
- **Milestone 2 additions:** weapons now live as data (`resources/weapons/*.tres`), not code, so adding a 4th weapon later is just a new `.tres` file, no script changes. `WeaponTestSwitcher` (keys 1/2/3) is explicitly temporary scaffolding, same as `TestFloor`/`TestChaser` — delete it once real inventory/pickups exist.
