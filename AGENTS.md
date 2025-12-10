# AGENTS.md - Dotfiles Repository Guide

## Repository Overview

This is a personal dotfiles repository for a developer named Anthony Nichols
(anthony.nichols@kaseya.com) who uses a cross-platform development setup
(Windows, Linux). The repository is inspired by ThePrimeagen's dotfiles and
follows a "stow-like" deployment pattern using Python dploy.

## Essential Commands

### Setup & Management
```bash
# Install/deploy dotfiles (uses Python dploy instead of GNU stow)
./install

# Clean environment (remove all stowed configs)
./clean-env

# Switch between Neovim configurations
./lua-config         # Use lua config (default)
./lua-config vim     # Use vim config
```

### Git Workflow
- **Commit style**: Uses automated commit messages with humorous style
- **GPG signing**: All commits are GPG signed (key: 649D8DD9208C7D23)
- **Default editor**: nvim
- **Line endings**: Uses `autocrlf = input` for cross-platform compatibility

### Environment Functions (available after sourcing)
```bash
# Utility functions from uwuntu/.config/personal/env
commitDotFiles       # Auto-commit dotfiles with standard message
startWork           # Launch work applications (Opera, Teams, Outlook, Obsidian)
startMongo          # Start MongoDB service
increaseWatchers    # Increase inotify watchers for development
gitBranchClean      # Clean up merged branches with AN/* pattern
listEnv             # Show all available environment functions
```

## Repository Structure

### Stow Folders
Deployed via `STOW_FOLDERS="nvim,tmux,uwuntu,i3,zsh,xkb,bash,git,ideavim,lazygit,jj,wez"`

- **nvim/**: Neovim configuration with Lua-based setup
- **tmux/**: Terminal multiplexer configuration
- **uwuntu/**: Personal shell environment, aliases, and functions
- **i3/**: i3 window manager configuration
- **zsh/**: Zsh shell configuration
- **bash/**: Bash shell configuration
- **git/**: Git configuration with extensive aliases
- **ideavim/**: IntelliJ Vim plugin configuration
- **lazygit/**: LazyGit TUI configuration
- **jj/**: Jujutsu VCS configuration
- **wez/**: WezTerm terminal configuration
- **xkb/**: Custom keyboard layout (real-prog-dvorak)

### Key Configuration Files
- `uwuntu/.config/personal/env` - Main environment functions and variables
- `git/.gitconfig` - Extensive git aliases and configuration
- `nvim/.config/nvim/lua/rooster/` - Modular Neovim configuration

## Code Patterns & Conventions

### General Coding Rules (CRITICAL - ALL AGENTS MUST FOLLOW)

#### File Operations
- **ALWAYS read/view files** before making changes - user makes parallel edits that agents must not accidentally revert
- **Read files at conversation start** to understand current state before any modifications

#### Language-Agnostic Rules
- **Increment operators**: Prefer `++x` over `x++` for performance and clarity
- **Explicit scopes**: Always use `{ }` braces around if blocks, even single statements
- **Guard clauses**: Prefer early returns over nested if/else patterns
- **Comments**: Place comments on their own line above relevant code
- **Branch avoidance**: Minimize branching code (if/else, ternary, switch, null coalesce) - use arithmetic/bitwise operations when possible
- **Switch expressions**: When branching is necessary, prefer switch expressions > switch statements > if/else chains
- **Output formatting**: Avoid using semicolons in output text

#### Code Signature
- **All new code**: Add comment `// HALLO from crush` above any code blocks you add

#### API Restrictions
- **JIRA API**: Query operations only - never create, update, or delete via JIRA API

### Frontend TypeScript Rules

#### Method Conventions
- **Private methods**: Must be prefixed with underscore `_methodName()`
- **Type safety**: Avoid `any` type - use proper TypeScript types

#### Import Management
- **No relative paths**: Use absolute imports only
- **Import sorting**: Sort imports by line length (shortest first)
- **Long imports**: If import line exceeds 160 characters, wrap and sort types by length
```typescript
// Good - sorted by length
import { A } from '@/short'
import { LongType } from '@/medium'
import { VeryLongTypeName } from '@/longer-path'

// Good - wrapped long import, types sorted by length
import { 
  A,
  LongType, 
  VeryLongTypeName,
  ExtremelyLongTypeNameHere 
} from '@/very-long-module-path'
```

### Lua Configuration (Neovim)
- **Module system**: Uses `require("rooster.modulename")` pattern
- **Namespace**: Everything under `rooster.*` namespace
- **Global variables**: 
  - `C` for colors (`C = require("rooster.colors")`)
  - `R()` function for module reloading
- **File organization**: Logical separation (set.lua, remap.lua, lsp.lua, etc.)

### Shell Scripting
- **Shebang**: Uses `#!/usr/bin/env bash` 
- **Function style**: camelCase naming (startWork, gitBranchClean)
- **Error handling**: Uses `die()` function for error messaging
- **Path functions**: `addToPath()` and `addToPathFront()` utilities

### Git Aliases
- **Single letter shortcuts**: `g`, `s`, `l`, `d`, `p`, etc.
- **Logical grouping**: ga/gall/gap for add operations
- **Smart defaults**: Uses `get_default_branch()` function to detect main/master
- **Interactive options**: Many aliases include interactive flags

## Important Gotchas

### Cross-Platform Considerations
1. **Stow replacement**: Uses Python `dploy` instead of GNU stow for Windows compatibility
2. **Line endings**: Enforces Unix line endings for most file types via Neovim autocommands
3. **Path separators**: Scripts handle both forward and backward slashes
4. **Shell compatibility**: Mixes bash and zsh patterns

### Environment Dependencies
1. **Python requirement**: Needs Python with `dploy` package installed
2. **GPG setup**: Git commits require GPG key to be properly configured
3. **Directory structure**: Some hardcoded paths reference `/home/theprimeagen/` (legacy from original)

### Neovim Configuration
1. **Plugin manager**: Uses lazy.nvim for plugin management
2. **LSP setup**: Modular LSP configuration in separate files per language
3. **Autocommands**: Heavy use of autocommands for file formatting and behavior
4. **Terminal integration**: Configured for floating terminal with bash

### File Permissions
- Some scripts may need execute permissions after stowing
- Installation script uses `pushd`/`popd` for directory management

## Testing & Verification

After making changes:
1. Test stow/unstow with `./install` and `./clean-env`
2. Verify Neovim configuration loads without errors
3. Check that shell aliases and functions work after sourcing
4. Ensure git operations work with GPG signing

## Security Notes

- GPG signing is mandatory for commits
- Git credential helper is configured for Windows (`manager`)
- SSH keys for GitHub operations (configured for gh: prefix)
- Personal information is in git config (name, email, signing key)

## Development Workflow

1. **Make changes** to configuration files in their respective directories
2. **Test locally** before committing
3. **Use standard commit message** or call `commitDotFiles` function
4. **Cross-platform testing** recommended due to Windows/Linux dual setup

## Common Tasks

### Adding New Tool Configuration
1. Create directory structure: `tool/.config/tool/config_files`
2. Add tool name to `STOW_FOLDERS` in `uwuntu/.config/personal/env`
3. Test with `./install`

### Updating Neovim Configuration
1. Modify files in `nvim/.config/nvim/lua/rooster/`
2. Use `R("module.name")` function to reload during development
3. Check lazy-lock.json for plugin version locks

### Git Workflow Customization
1. Add aliases to `git/.gitconfig` or `uwuntu/.config/personal/aliases/git.aliases.bash`
2. Follow existing naming patterns (single letters for common operations)
3. Use `get_default_branch()` function for main/master branch detection

## Session Continuity & Recovery

**CRITICAL**: Update this AGENTS.md file with all significant changes made during your session to ensure continuity if the session is interrupted by API errors or restarts.

### What to Document
- New files created or modified
- Configuration changes made
- Issues encountered and solutions
- Work-in-progress status
- Next steps planned

### Recovery Protocol
1. When resuming after interruption, read this file first
2. Check git status to see what changed since last documented state
3. Review any uncommitted changes before proceeding
4. Continue from documented stopping point

### Current Session Status
*Agents should update this section with their progress*

**Last updated**: December 3, 2025
**Status**: ✅ C# debugging setup complete and ready for testing
**Recent changes**: 
- Added comprehensive coding rules for TypeScript frontend development
- Added file operation safety rules
- Added code signature requirements
- Added API usage restrictions
- **COMPLETED**: C# DAP debugging configuration (`nvim/.config/nvim/lua/rooster/lazy/dap.lua`)
- **VERIFIED**: netcoredbg debug adapter v3.1.2-1 installed and working
- **CONFIRMED**: dotnet process running (PID 20916)
- **READY**: All configurations in place for breakpoint debugging
**Next steps**: User should restart Neovim and test debugging with F5 key

### C# Debugging Setup
- **Debug adapter**: netcoredbg v3.1.2-1054 (installed via scoop)
- **Configuration file**: `nvim/.config/nvim/lua/rooster/lazy/dap.lua` 
- **QuickerPay specific**: Auto-detects DLL at `QuickerPay.TenantPortal/bin/Debug/net8.0/QuickerPay.TenantPortal.dll`
- **Key bindings**: 
  - F5: Start/Continue debugging
  - F1/F2/F3: Step Into/Over/Out
  - <leader>b: Toggle breakpoint
  - F7: Toggle DAP UI
  - <leader>dt: Terminate debug session
