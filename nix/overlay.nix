final: prev: {
  jj-upload = final.callPackage ../pkgs/jj-upload/package.nix { };
  claude-hooks = final.callPackage ../pkgs/claude-hooks/package.nix { };
  claude-statusline = final.callPackage ../pkgs/claude-statusline/package.nix { };
  # The nulls pin the "use the bundled default" arguments so a same-named
  # top-level package (e.g. `skills`) is never auto-injected by callPackage.
  claude = final.callPackage ../pkgs/claude/package.nix {
    instructions = null;
    agents = null;
    skills = null;
    settings = null;
  };
}
