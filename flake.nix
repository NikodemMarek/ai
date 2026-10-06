{
  description = "Claude Code with bundled personal config (CLAUDE.md, agents, skills, hooks, settings)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib;
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    pkgsFor = lib.genAttrs systems (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfreePredicate = p:
            builtins.elem (lib.getName p) [
              "claude-code"
              "claude"
            ];
          overlays = [self.overlays.default];
        }
    );
    forAllSystems = f: lib.genAttrs systems (system: f system pkgsFor.${system});
  in {
    overlays.default = import ./nix/overlay.nix;

    packages = forAllSystems (
      _system: pkgs: {
        inherit
          (pkgs)
          agent-skills
          claude
          jj-upload
          claude-hooks
          claude-statusline
          ;
        default = pkgs.claude;
      }
    );

    formatter = forAllSystems (_system: pkgs: pkgs.nixfmt);
  };
}
