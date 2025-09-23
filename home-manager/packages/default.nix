{ pkgs }:
with pkgs;
[
  act # Run your GitHub Actions locally
  aider-chat # AI pair programming in your terminal
  aria2 # Multi-protocol, multi-source, command-line download utility
  awscli2 # Unified tool to manage your AWS services
  axel # Parallel connections for faster downloading
  bandwhich # CLI utility for displaying current network utilization
  bat # cat(1) clone with syntax highlighting and Git integration
  bottom # Cross-platform graphical process/system monitor
  btop # Monitor of resources
  cabal-install # The command-line interface for Cabal and Hackage
  cargo-diet # Optimal include directives for Cargo.toml manifests
  haskellPackages.hoogle # Hoogle for local Haskell search
  cargo-udeps # Find unused dependencies in Cargo.toml
  cbc # Mixed integer programming solver
  comma # Runs programs without installing them
  commitizen # Tool to create committing rules for projects
  ctop # Top-like interface for container metrics
  deadnix # Find and remove unused code in .nix source files
  docker-compose # Multi-container orchestration for Docker
  duf # Disk Usage/Free Utility
  fd # Simple, fast and user-friendly alternative to find
  figlet # Program for making large letters out of ordinary text
  file # Program that shows the type of files
  # gcc # GNU Compiler Collection
  gh # Simple command-line interface to the facilities of Github
  haskell.compiler.ghc966 # The Glasgow Haskell Compiler
  git-lfs # Git extension for versioning large files
  gitoxide # Utility for interacting with git repositories
  glab # GitLab CLI tool bringing GitLab to your command line
  glow # Render markdown on the CLI, with pizzazz!
  gnumake # Generation of non-source files from sources
  gnupg # GNU Privacy Guard
  gping # Ping, but with a graph
  grafana-loki # Like Prometheus, but for logs
  (haskell-language-server.override { supportedGhcVersions = [ "966" ]; }) # LSP server for GHC
  htop # Interactive process viewer
  httm # Interactive, file-level Time Machine-like tool for ZFS/btrfs
  iperf3 # Tool to measure IP bandwidth using UDP or TCP
  jq # Lightweight and flexible command-line JSON processor
  k9s # Kubernetes CLI To Manage Your Clusters In Style
  killall # Kill processes by name
  kind # Kubernetes IN Docker - local clusters for testing Kubernetes
  lazygit # Simple terminal UI for git commands
  llvmPackages_19.clang-tools # Command line tools for C++ development
  lsd # The next gen ls command
  meld # Visual diff and merge tool
  mods # AI on the command line
  mtr # Network diagnostics tool
  ncdu # Disk usage analyzer with an ncurses interface
  neofetch # Fast, highly customizable system info script
  neovide # Graphical user interface for Neovim
  nerd-fonts.fira-code # Extension of Fira Mono with programming ligatures
  nerd-fonts.fira-mono # Mozilla typeface, dotted zero
  nerd-fonts.victor-mono # Programming font with cursive italics, ligatures
  nix-bisect # Bisect nix builds
  nix-init # Command line tool to generate Nix packages from URLs
  nix-output-monitor # Processes output of Nix commands
  nix-tree # Interactively browse a Nix store paths dependencies
  nixd # Nix language server
  nixfmt-rfc-style # An opinionated formatter for Nix
  nixpkgs-fmt # Nix code formatter for nixpkgs
  nmap # Network discovery and security auditing
  nodejs # Event-driven I/O framework for the V8 JavaScript engine
  ollama # Run large language models locally
  pbzip2 # Parallel implementation of bzip2 for multi-core machines
  pciutils # For inspecting and manipulating PCI devices
  peaclock # Clock, timer, and stopwatch for the terminal
  pgformatter # PostgreSQL SQL syntax beautifier
  postgresql_16 # Open source object-relational database system
  pv # Tool for monitoring the progress of data through a pipeline
  python312 # High-level dynamically-typed programming language
  rdfind # Removes or hardlinks duplicate files very swiftly
  ripgrep # Recursively searches directories for a regex pattern
  rustup # The Rust toolchain installer
  screen # Window manager that multiplexes a physical terminal
  stack # The Haskell Tool Stack
  statix # Lints and suggestions for the nix programming language
  swi-prolog # Prolog compiler and interpreter
  tokio-console # Debugger for asynchronous Rust code
  tree # Command to produce a depth indented directory listing
  unzip # Extraction utility for archives compressed in .zip format
  vim # The most popular clone of the VI editor
  vulnix # NixOS vulnerability scanner
  whois # Intelligent WHOIS client from Debian
  wireshark # Powerful network protocol analyzer
  xcompmgr # X compositing manage
  yq # jq wrapper for YAML, XML, TOML documents
]
++ lib.optionals stdenv.isLinux [
  atop # Console system performance monitor
  btdu # Sampling disk usage profiler for btrfs
  chromium # Open source web browser from Google
  dmenu # Highly customizable menu for the X Window System
  dmidecode # Reads information from the BIOS (SMBIOS/DMI)
  docker # Pack, ship and run lightweight containers
  dool # Python3 compatible clone of dstat
  ethtool # Utility for controlling network drivers and hardware
  feh # Light-weight image viewer
  find-cursor # XLib program to highlight the cursor position
  firefox # Web browser built from Firefox source tree
  gnat14 # GNU Compiler Collection version 14
  # google-chrome # Freeware web browser developed by Google
  # jp2a # Small utility that converts JPG images to ASCII (broken)
  ltrace # Library call tracer
  mupdf # Lightweight PDF, XPS, and E-book viewer
  nmon # AIX & Linux Performance Monitoring tool
  nvitop # Interactive NVIDIA-GPU process viewer
  pinentry # GnuPG’s interface to passphrase input
  polybar # Fast and easy-to-use tool for creating status bars
  rr # Records nondeterministic executions and debugs them deterministically
  scrot # Command-line screen capture utility
  tmux # Terminal multiplexer
  valgrind # Debugging and profiling tool suite
  xclip # Access the X clipboard from a console application
  xmobar # Minimalistic Text Based Status Bar
  xmonad-log # xmonad DBus monitoring solution
  xorg.xhost # server access control program for X
  xsel # Getting and setting the contents of the X selection
  zpool-iostat-viz # "zpool iostats for humans"
]
++ lib.optionals stdenv.isDarwin [
  pinentry_mac # GnuPG’s interface to passphrase input
]
#++ [
#  # Scripts
#  # (writeShellScriptBin "my-hello" ''
#  #   echo "Hello, ${config.home.username}!"
#  # '')
#]
