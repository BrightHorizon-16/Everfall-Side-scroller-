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

---

# Milestone 2.5 — Beginner World + Combat Feedback

- [x] `World` content moved out of loose test nodes into `scenes/regions/beginner_world.tscn` — a real first region, not scaffolding. Same floor + Chaser, just properly homed. Keep building on it rather than replacing it.
- [x] Player health bar (fixed UI, top-left)
- [x] Enemy health bar (world-space, floats above the enemy; generic — any future enemy with a `Health` sibling gets one automatically by adding the node)
- [x] Hitbox debug visualization — permanent dev toggle (`debug_visible` on `Hitbox`), not scaffolding to delete, just likely defaults off once real animations exist

---

# Milestone 3 — Input Rebind, Kill Plane, Level Shape, Weapon UI

- [x] Attack rebound from J to left mouse click
- [x] `KillPlane` component — instant death for anything with Health that touches it, reuses the existing death pipeline (no separate respawn logic written)
- [x] Beginner World reshaped: two floor segments with a gap (requires an actual jump to cross) plus one raised platform, instead of one flat strip
- [x] Weapon name UI label, updates live via `PlayerCombat.weapon_changed` signal
- [ ] Movement feel tuning (coyote time, jump buffer, variable jump height) — deliberately still deferred; your call was that it matters more once most of the scaffolding work is done, so revisit this once the core systems settle

---

# Milestone 4 — Chaser Gap-Jumping, Void vs. Combat Death, Visibility

- [x] `ChaserAI` now jumps over gaps — a `LedgeRay` (RayCast2D) checks for ground slightly ahead of its travel direction each frame; no ground found + on floor = jump. No wall-climbing, no pathfinding.
- [x] `KillPlane` redesigned: it no longer routes through `Health.take_damage()`. It now calls a `reset_to_spawn()` method directly if the body has one - decoupling "fell out of the world" from "died in combat" entirely. Player's `_on_died()` (combat) and falling now both call the same `reset_to_spawn()`. Chaser's combat death (`_on_died()`) still despawns via `queue_free()` unchanged, but falling now calls its own `reset_to_spawn()` instead, so a Chaser that misjudges a jump resets instead of vanishing.
- [x] Floor/platform visuals changed to solid black for contrast against the background

## Notes / things you may want to review
- A temporary placeholder floor (gray rectangle, "TestFloor") was added inside World purely so gravity/jumping can be tested. It's not real level geometry — delete or replace whenever you start building actual rooms.
- Player and floor are untextured colored shapes (Polygon2D) since no art/animation work has been done yet.
- No Inventory or Animation scripts/nodes have been created yet — out of scope so far.
- **Milestone 1 additions:** `attack` input action bound to J (pick was arbitrary, easy to rebind). Player and Chaser roots now have thin coordinator scripts (`player.gd`, `chaser.gd`) whose only job is reacting to the `died` signal — this is new, they were script-less containers before. A `TestChaser` instance was added to `World` near the player spawn purely to make combat testable, same spirit as `TestFloor` — not real level content. Collision layers 1-7 are named in Project Settings → Layer Names for clarity.
- **Deferred by request:** player/enemy bodies currently don't physically collide (each only collides with `world`), just their hitbox/hurtbox areas interact. You want physical body collision added later, once more content exists — not done yet, flagging so it isn't forgotten.
- **Milestone 2 additions:** weapons now live as data (`resources/weapons/*.tres`), not code, so adding a 4th weapon later is just a new `.tres` file, no script changes. `WeaponTestSwitcher` (keys 1/2/3) is explicitly temporary scaffolding, same as `TestFloor`/`TestChaser` — delete it once real inventory/pickups exist.
- **Milestone 3 note:** the 150px gap in Beginner World was sized by hand-calculating your jump arc against walking speed (not by playtesting in-editor) — meant to be just-barely-uncrossable without jumping. If it plays too easy or too hard, adjust the gap width on `FloorLeft`/`FloorRight` in `beginner_world.tscn`, nothing else depends on the exact number. (Note: `KillPlane`'s behavior described in Milestone 3 was superseded in Milestone 4 - see below.)
- **Milestone 4 note:** `ChaserAI.move_speed` was bumped from 120 to 220 - at the original speed, the math said it couldn't clear the 150px gap even with a jump (not enough horizontal distance during the jump arc), so I raised it. This was a necessary tuning change to make "jump over gaps" actually work given the existing gap width, not a deliberate combat-feel decision - flagging since you didn't ask for a faster Chaser specifically. Also an estimate, not playtested - `ledge_check_ahead`/`ledge_check_depth`/`move_speed` on `ChaserAI` are the knobs if it still misses jumps or jumps too early/late.
