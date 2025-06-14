# txkyel's flakes

## TODOs:

I want to improve robustness of my config and reduce general evaluation times.

To that end, I'd like to reduce my desktop dependencies to as few flakes as possible to
reduce potential sources of errors.

- Investigate alternatives to home-manager to speed up evaluation times
  - Another reason to home-manager causing bugs due to inconsistencies with nixos configurations ([gvfs broke](https://github.com/NixOS/nixpkgs/issues/412131))
- Find alternative to swaync (potentially also Astal/AGS?)
- Create own nvim config without nvf abstraction layer
- Modularize system settings placed in `modules/desktop`
  - Split into `modules/core` and `modules/gui`

## Dotfiles references: 

- [JaKooLit/Hyprland-Dots](https://github.com/JaKooLit/Hyprland-Dots): Used as a starting point for my hyprland configuration
- [Frost-Phoenix/nixos-config](https://github.com/Frost-Phoenix/nixos-config): Used as a starting point for my config organization
- [sioodmy/dotfiles](https://github.com/sioodmy/dotfiles): Use as inspiration organizing modules of my config
- [reckenrode/nixos-configs](https://github.com/reckenrode/nixos-configs): Copied github actions
