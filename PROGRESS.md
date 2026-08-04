# Milestone 0 — Foundation

- [x] Project created
- [ ] Git repository connected — local repo + .gitignore are set up; pushing to a remote (GitHub, etc.) needs to happen on your end since it requires your credentials
- [x] Project settings configured — 1280x720 viewport, canvas_items stretch, GL Compatibility renderer (chosen for eventual web export)
- [x] Input actions created — move_left (A / Left Arrow), move_right (D / Right Arrow), jump (Space)
- [x] Main scene created — Main > World, Player, Camera, UI
- [x] Player scene created — CharacterBody2D with a single-purpose Movement component script
- [x] Camera follows player — lerp-based follow script on Camera (sibling of Player, not a child)
- [ ] Browser export works — needs export templates set up in the Godot editor; not attempted yet

## Notes / things you may want to review
- A temporary placeholder floor (gray rectangle, "TestFloor") was added inside World purely so gravity/jumping can be tested. It's not real level geometry — delete or replace whenever you start building actual rooms.
- Player and floor are untextured colored shapes (Polygon2D) since no art/animation work has been done yet.
- No Combat, Health, Inventory, or Animation scripts/nodes have been created yet — out of scope for this milestone step.
