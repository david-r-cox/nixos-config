{ pkgs }:
with pkgs;
[
  act # Run your GitHub Actions locally
  aria2 # Multi-protocol, multi-source, command-line download utility
  awscli2 # Unified tool to manage your AWS services
  axel # Parallel connections for faster downloading
  bandwhich # CLI utility for displaying current network utilization
  bat # cat(1) clone with syntax highlighting and Git integration
  bottom # Cross-platform graphical process/system monitor
  btop # Monitor of resources
  cabal-install # The command-line interface for Cabal and Hackage
  cargo-diet # Optimal include directives for Cargo.toml manifests
  cargo-udeps # Find unused dependencies in Cargo.toml
  cbc # Mixed integer programming solver
  clang-tools_16 # Standalone command line tools for C++ development
  comma # Runs programs without installing them
  commitizen # Tool to create committing rules for projects
  ctop # Top-like interface for container metrics
  deadnix # Find and remove unused code in .nix source files
  docker # Pack, ship and run lightweight containers
  docker-compose # Multi-container orchestration for Docker
  duf # Disk Usage/Free Utility
  fd # Simple, fast and user-friendly alternative to find
  feh # Light-weight image viewer
  figlet # Program for making large letters out of ordinary text
  file # Program that shows the type of files
  gcc # GNU Compiler Collection
  gh # Simple command-line interface to the facilities of Github
  ghc # The Glasgow Haskell Compiler
  gitoxide # Utility for interacting with git repositories
  glab # GitLab CLI tool bringing GitLab to your command line
  glow # Render markdown on the CLI, with pizzazz!
  gnumake # Generation of non-source files from sources
  gnupg # GNU Privacy Guard
  gping # Ping, but with a graph
  grafana-loki # Like Prometheus, but for logs
  haskell-language-server # LSP server for GHC
  htop # Interactive process viewer
  httm # Interactive, file-level Time Machine-like tool for ZFS/btrfs
  iperf3 # Tool to measure IP bandwidth using UDP or TCP
  jq # Lightweight and flexible command-line JSON processor
  k9s # Kubernetes CLI To Manage Your Clusters In Style
  killall # Kill processes by name
  kind # Kubernetes IN Docker - local clusters for testing Kubernetes
  lazygit # Simple terminal UI for git commands
  lsd # The next gen ls command
  meld # Visual diff and merge tool
  mods # AI on the command line
  mtr # Network diagnostics tool
  ncdu # Disk usage analyzer with an ncurses interface
  neofetch # Fast, highly customizable system info script
  neovide # Graphical user interface for Neovim
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
  swiProlog # Prolog compiler and interpreter
  tokio-console # Debugger for asynchronous Rust code
  tree # Command to produce a depth indented directory listing
  unzip # Extraction utility for archives compressed in .zip format
  vim # The most popular clone of the VI editor
  vulnix # NixOS vulnerability scanner
  whois # Intelligent WHOIS client from Debian
  wireshark # Powerful network protocol analyzer
  yq # jq wrapper for YAML, XML, TOML documents
] ++ lib.optionals stdenv.isLinux [
  atop # Console system performance monitor
  btdu # Sampling disk usage profiler for btrfs
  chromium # Open source web browser from Google
  dmenu # Highly customizable menu for the X Window System
  dmidecode # Reads information from the BIOS (SMBIOS/DMI)
  dstat # Versatile resource statistics tool
  ethtool # Utility for controlling network drivers and hardware
  firefox # Web browser built from Firefox source tree
  jp2a # Small utility that converts JPG images to ASCII
  ltrace # Library call tracer
  mupdf # Lightweight PDF, XPS, and E-book viewer
  nmon # AIX & Linux Performance Monitoring tool
  nvitop # Interactive NVIDIA-GPU process viewer
  pciutils # For inspecting and manipulating PCI devices
  pinentry # GnuPG’s interface to passphrase input
  polybar # Fast and easy-to-use tool for creating status bars
  scrot # Command-line screen capture utility
  valgrind # Debugging and profiling tool suite
  xclip # Access the X clipboard from a console application
  xcompmgr # X compositing manage
  xmobar # Minimalistic Text Based Status Bar
  xmonad-log # xmonad DBus monitoring solution
  xorg.xhost # server access control program for X
  xsel # Getting and setting the contents of the X selection
  zpool-iostat-viz # "zpool iostats for humans"
  zfs-prune-snapshots # Remove snapshots from one or more zpools
] ++ lib.optionals stdenv.isDarwin [
  pinentry_mac # GnuPG’s interface to passphrase input
]
++ [
  # Overrides
  (nerdfonts.override {
    fonts = [
      "FiraCode"
      "VictorMono"
    ];
  })
]
#++ [
#  # Scripts
#  # (writeShellScriptBin "my-hello" ''
#  #   echo "Hello, ${config.home.username}!"
#  # '')
#]
