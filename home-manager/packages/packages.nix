# Development Tools and Utilities
{ pkgs }:
with pkgs;
let
  # Package documentation format:
  # {Description} - Detailed explanation of the package
  # {Key Features} - Notable features and capabilities
  # {Common Commands} - Frequently used commands and flags
  # {Examples} - Real-world usage examples
  # {See Also} - Related tools or alternatives
  # {Links} - Documentation and resources

  commonPackages = [
    # Version Control
    {
      package = act;
      meta = ''
        # GitHub Actions Local Runner
        Run your GitHub Actions workflows locally for testing and debugging.
        
        ## Key Features
        - Run workflows locally
        - Support for most GitHub Actions
        - Secret handling
        - Matrix build support
        
        ## Common Commands
        act -l                    # List available actions
        act push                  # Run push workflows
        act pull_request         # Run PR workflows
        
        ## Examples
        act -j test              # Run specific job
        act -n                   # Dry run
        act -v                   # Verbose output
        
        ## See Also
        - gh (GitHub CLI)
        - glab (GitLab CLI)
        
        ## Links
        https://github.com/nektos/act
      '';
    }
    {
      package = gh;
      meta = ''
        # GitHub CLI
        Official command-line tool for interacting with GitHub repositories.
        
        ## Key Features
        - Repository management
        - Issue and PR workflows
        - GitHub Actions control
        - Gist management
        
        ## Common Commands
        gh repo clone REPO       # Clone repository
        gh pr list              # List pull requests
        gh issue create         # Create issue
        gh workflow run         # Run workflow
        
        ## Examples
        gh pr checkout 123      # Check out PR
        gh release create v1.0  # Create release
        gh gist create file.txt # Create gist
        
        ## See Also
        - git
        - glab
        - act
        
        ## Links
        https://cli.github.com/
      '';
    }
    {
      package = gitoxide;
      meta = ''
        # Modern Git Implementation
        Fast, safe, pure Rust implementation of git features.
        
        ## Key Features
        - Pure Rust implementation
        - High performance
        - Safe operations
        - Modern CLI interface
        
        ## Common Commands
        gix clone URL           # Clone repository
        gix status             # Show status
        gix add .              # Stage changes
        
        ## Examples
        gix diff               # Show changes
        gix log                # View history
        
        ## See Also
        - git
        - gh
        
        ## Links
        https://github.com/Byron/gitoxide
      '';
    }

    # Development Tools
    {
      package = llvmPackages_19.clang-tools;
      meta = ''
        # Clang Development Tools
        Comprehensive suite of C/C++ development tools including clang-format, clang-tidy, etc.
        
        ## Key Features
        - Code formatting
        - Static analysis
        - Code modernization
        - Include-what-you-use
        
        ## Common Commands
        clang-format -i file.cpp    # Format file in-place
        clang-tidy file.cpp         # Run static analysis
        clang-format -style=file    # Use .clang-format
        
        ## Examples
        # Format all C++ files
        find . -name '*.cpp' -o -name '*.hpp' | xargs clang-format -i
        
        # Run specific checks
        clang-tidy file.cpp -checks=-*,clang-analyzer-*
        
        ## Configuration
        # .clang-format example:
        # BasedOnStyle: LLVM
        # IndentWidth: 2
        
        ## See Also
        - gcc
        - bear (compilation database)
        
        ## Links
        https://clang.llvm.org/docs/ClangFormat.html
        https://clang.llvm.org/extra/clang-tidy/
      '';
    }
    {
      package = cargo-diet;
      meta = ''
        # Cargo.toml Optimizer
        Tool for optimizing include/exclude directives in Cargo.toml.
        
        ## Key Features
        - Package size optimization
        - Include directive analysis
        - Automatic suggestions
        
        ## Common Commands
        cargo diet                  # Analyze current package
        cargo diet --dry-run       # Show what would change
        cargo diet --update        # Update Cargo.toml
        
        ## Examples
        # Check package size
        cargo diet --package-size
        
        # Update with specific rules
        cargo diet --update --rules="*.rs,README.md"
        
        ## See Also
        - cargo-udeps
        - cargo-edit
        
        ## Links
        https://github.com/the-lean-crate/cargo-diet
      '';
    }
    {
      package = cargo-udeps;
      meta = ''
        # Unused Dependency Checker
        Find unused dependencies in Rust projects.
        
        ## Key Features
        - Detects unused direct dependencies
        - Supports workspace analysis
        - Integration with cargo
        
        ## Common Commands
        cargo udeps                # Check for unused deps
        cargo udeps --all         # Check workspace
        cargo udeps --release     # Check release build
        
        ## Examples
        # Check specific target
        cargo udeps --target x86_64-unknown-linux-gnu
        
        # With features
        cargo udeps --features "feature1,feature2"
        
        ## See Also
        - cargo-audit
        - cargo-outdated
        
        ## Links
        https://github.com/est31/cargo-udeps
      '';
    }

    # System Tools
    {
      package = btop;
      meta = ''
        # System Resource Monitor
        Resource monitor that shows usage and stats for processor, memory, disks, network and processes.
        
        ## Key Features
        - CPU, memory, disk, network monitoring
        - Process management
        - Customizable displays
        - Mouse support
        
        ## Common Commands
        btop                     # Start monitor
        btop --utf-force        # Force UTF-8
        btop --low-color        # Low color mode
        
        ## Keyboard Shortcuts
        m                        # Memory view
        p                        # CPU view
        d                        # Disk view
        n                        # Network view
        
        ## Configuration
        ~/.config/btop/btop.conf
        
        ## See Also
        - htop
        - atop
        - nmon
        
        ## Links
        https://github.com/aristocratos/btop
      '';
    }
    {
      package = bandwhich;
      meta = ''
        # Network Utilization Monitor
        Terminal bandwidth utilization tool.
        
        ## Key Features
        - Real-time bandwidth monitoring
        - Process-network connection mapping
        - Detailed connection information
        
        ## Common Commands
        bandwhich                # Start monitoring
        bandwhich --raw         # Raw output mode
        sudo bandwhich          # Full process info
        
        ## Examples
        # Monitor specific interface
        bandwhich --interface eth0
        
        # Export DNS queries
        bandwhich --dns
        
        ## See Also
        - iftop
        - nethogs
        
        ## Links
        https://github.com/imsnif/bandwhich
      '';
    }

    # Development Environment
    {
      package = neovide;
      meta = ''
        # Neovim GUI Client
        Modern, graphical user interface for Neovim.
        
        ## Key Features
        - Hardware accelerated rendering
        - Smooth scrolling
        - Ligature support
        - Multi-grid UI
        
        ## Common Commands
        neovide                  # Start Neovim GUI
        neovide --maximize      # Start maximized
        neovide --frame none    # Frameless window
        
        ## Configuration
        # In init.vim/init.lua:
        let g:neovide_cursor_animation_length=0.1
        let g:neovide_refresh_rate=60
        
        ## Examples
        # Custom font
        neovide --font="FiraCode Nerd Font:h12"
        
        # With file
        neovide file.txt
        
        ## See Also
        - neovim
        - vimr
        
        ## Links
        https://neovide.dev/
      '';
    }
    {
      package = nixfmt-rfc-style;
      meta = ''
        # Nix Code Formatter
        Opinionated Nix code formatter following RFC style.
        
        ## Key Features
        - RFC style compliance
        - Consistent formatting
        - Editor integration
        
        ## Common Commands
        nixfmt file.nix         # Format file
        nixfmt --check         # Check formatting
        nixfmt --width 80      # Set line width
        
        ## Examples
        # Format directory
        find . -name "*.nix" -exec nixfmt {} +
        
        # With editor config
        nixfmt --file .nixfmt
        
        ## See Also
        - nixpkgs-fmt
        - alejandra
        
        ## Links
        https://nix.dev/guides/style
      '';
    }
  ] ++ [
    # Core Utils
    bat       # Enhanced cat clone
    bottom    # System/process monitor
    fd        # Fast find alternative
    ripgrep   # Fast grep alternative
    tree      # Directory structure viewer
  ];

  linuxPackages = lib.optionals stdenv.isLinux [
    # System Monitoring
    {
      package = nvitop;
      meta = ''
        # NVIDIA GPU Process Viewer
        Interactive NVIDIA-GPU process monitoring.
        
        ## Key Features
        - Real-time GPU metrics
        - Process monitoring
        - Resource utilization
        - Temperature tracking
        
        ## Common Commands
        nvitop                   # Interactive mode
        nvitop --monitor        # Monitor mode
        nvitop --no-color       # Disable colors
        
        ## Examples
        # Sort by memory
        nvitop --sort memory
        
        # Update interval
        nvitop -d 2.0
        
        ## See Also
        - nvidia-smi
        - gpustat
        
        ## Links
        https://github.com/XuehaiPan/nvitop
      '';
    }
    {
      package = zpool-iostat-viz;
      meta = ''
        # ZFS Pool I/O Visualizer
        Human-friendly visualization of ZFS pool I/O statistics.
        
        ## Key Features
        - Real-time I/O monitoring
        - Visual bandwidth display
        - Pool health status
        
        ## Common Commands
        zpool-iostat-viz         # Start visualization
        zpool-iostat-viz -p pool # Monitor specific pool
        
        ## Examples
        # With custom interval
        zpool-iostat-viz -i 5
        
        # Monitor multiple pools
        zpool-iostat-viz -p pool1,pool2
        
        ## See Also
        - zpool
        - iostat
        
        ## Links
        https://github.com/sindresorhus/zpool-iostat-viz
      '';
    }
  ];

  darwinPackages = lib.optionals stdenv.isDarwin [
    {
      package = pinentry_mac;
      meta = ''
        # macOS Pinentry Dialog
        Secure passphrase entry dialog for GPG on macOS.
        
        ## Key Features
        - Native macOS dialog
        - GPG integration
        - Secure input
        
        ## Configuration
        # In ~/.gnupg/gpg-agent.conf:
        pinentry-program /Applications/MacPorts/pinentry-mac.app/Contents/MacOS/pinentry-mac
        
        ## See Also
        - gpg-agent
        - gnupg
        
        ## Links
        https://github.com/GPGTools/pinentry-mac
      '';
    }
  ];

  # Extract packages from documentation
  getPackage = p: if p ? package then p.package else p;

in
  map getPackage (commonPackages ++ linuxPackages ++ darwinPackages) ++ [
    # Fonts
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "VictorMono"
      ];
    })
  ]