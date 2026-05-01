let
  wrap = s: "[┤ ](white)${s}[ ├](white)";
  wrapLong = s: "[─┤ ](white)${s}[ ├─](white)";
in
{
  flake.aspects.nushell.homeManager.programs.starship.settings = {
    add_newline = true;

    format = "[╭─┤ ](white)[$username](fg:#ffff55)[ @ ](fg:#ff5555)[$hostname](fg:#55ff55)[ ├─┤ ](white)[$directory](fg:#ff5555)[├](white)$nix_shell$sudo$fill$status$cmd_duration$git_branch$git_status$time\n[├──╢ ](white)";

    # $fill handles alignment, no need for right propmt
    right_format = "";

    # Continuation prompt
    continuation_prompt = "[├──╢ ](white)";

    # Modules
    username = {
      show_always = true;
      format = "[$user]($style)";
    };

    hostname = {
      ssh_only = false;
      format = "[$hostname]($style)";
    };

    directory = {
      style = "fg:#ff5555";
      truncation_length = 3;
      truncation_symbol = "…/";
    };

    nix_shell = {
      format = wrapLong "[λ ($name)](fg:#5fb8f2)";
    };

    sudo = {
      symbol = "א";
      format = wrap "[$symbol](fg:#ff9248)";
    };

    status = {
      disabled = false;
      success_symbol = "[⊤](fg:#55ff55)";
      symbol = "[⊥](fg:#ff5555)";
      format = wrap "[$symbol $status]($style)";
      success_style = "white";
    };

    cmd_duration = {
      disabled = false;
      min_time = 500;
      format = wrap "[∞ $duration](fg:#fefefe)";
    };

    fill = {
      symbol = "─";
      style = "white";
    };

    git_branch = {
      symbol = "󿂠 ";
      format = "[┤ ](white)[$symbol$branch](fg:#e0f8ff)";
    };

    git_status = {
      format = "[$ahead_behind$staged$modified$untracked$deleted]($style)[ ├](white)";
      staged = "[ ● $count](fg:#00aa00)";
      modified = "[ ● $count](fg:#d75f00)";
    };

    time = {
      disabled = false;
      format = wrapLong "[⏲ $time](fg:#55ffff)";
      time_format = "%a, %d %b %Y %T %Z";
    };
  };
}
