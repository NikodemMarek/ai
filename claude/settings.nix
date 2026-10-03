# Rendered to $CLAUDE_CONFIG_DIR/settings.json (a read-only link into the
# store). In-session changes (/config, /theme, /plugin, ...) last only for the
# session; change this file or `claude.extend { settings = ...; }` to persist.
{
  permissions = {
    allow = [
      "Bash(jj log:*)"
      "Bash(jj status:*)"
      "Bash(jj show:*)"
      "Bash(jj diff:*)"
      "Bash(jj new:*)"
      "Bash(jj squash:*)"
      "Bash(jj split:*)"
      "Bash(jj edit:*)"
      "Bash(jj describe:*)"
      "Bash(jj commit:*)"
      "Bash(jj rebase:*)"
      "Bash(mvn test:*)"
      "Bash(mvn compile:*)"
    ];
    deny = [ ];
    ask = [ ];
    additionalDirectories = [ "@memoryDir@" ];
  };

  statusLine = {
    type = "command";
    command = "claude-statusline";
  };

  hooks = {
    WorktreeCreate = [
      {
        hooks = [
          {
            type = "command";
            command = "claude-jj-workspace create";
            timeout = 120;
          }
        ];
      }
    ];
    WorktreeRemove = [
      {
        hooks = [
          {
            type = "command";
            command = "claude-jj-workspace remove";
            timeout = 180;
          }
        ];
      }
    ];
    SubagentStop = [
      {
        hooks = [
          {
            type = "command";
            command = "claude-jj-workspace stop";
            timeout = 180;
          }
        ];
      }
    ];
  };

  enabledPlugins = {
    "rust-analyzer-lsp@claude-plugins-official" = true;
  };

  effortLevel = "xhigh";
  theme = "dark";
  skipAutoPermissionPrompt = true;
}
