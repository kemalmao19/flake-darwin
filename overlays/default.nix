{ inputs, ... }: {
  flake.overlays.default = final: prev: {
    # rescript
    tree-sitter-grammars = prev.tree-sitter-grammars // {
      tree-sitter-rescript = prev.tree-sitter.buildGrammar {
        version = inputs.ts-rescript.lastModifiedDate;
        language = "rescript";
        generate = true;
        src = inputs.ts-rescript;
      };
    };
  };
}
