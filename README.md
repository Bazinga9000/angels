# Angels
> *"Praise him, all his angels; praise him, all his heavenly hosts."*
>
> *-Psalm 148:2*

A NixOS Configuration for my various machines.

This configuration uses the [Dendritic Pattern](https://github.com/mightyiam/dendritic?tab=readme-ov-file), wherein every file is a `flake-parts` moudle.

### Hosts
- `metatron`: Main PC
- `jophiel`: Always-on desktop for hosting things (primarily discord bots)

If you want to use this configuration as a base, see `store-files/README.md` for what files you need already in the nix store for what packages.

### Interacting with this configuration

Assuming you place this repository in `/home/{username}/angels`, this configuration aliases the shell command `angels` to run the justfile found at `justfile`. This will work from any directory, so you can simply open a terminal. `angels` on its own gives you a list of `just` recipes.
