{ hm, ... }:
{
  hm.programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "merionette";
      
      editor = {
        line-number = "relative";
        
        lsp = {
          
        };
      };

      keys.normal = {
        alt.l = [ "goto_line_end" ":append-output echo -n ';'" ];
        ctrl.c = "normal_mode";
      };
    };
  };
}
