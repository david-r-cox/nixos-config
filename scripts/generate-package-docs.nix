# Generate Markdown documentation from package metadata
{ pkgs ? import <nixpkgs> {} }:

let
  packages = import ../home-manager/packages/packages.nix { inherit pkgs; };
  
  # Extract metadata from package list
  getMetadata = p: if p ? meta then p.meta else null;
  
  # Generate documentation
  generateDocs = pkgs:
    let
      # Filter packages with metadata
      packagesWithMeta = builtins.filter (p: p ? meta) pkgs;
      
      # Create markdown content
      content = builtins.concatStringsSep "\n\n---\n\n" 
        (map (p: p.meta) packagesWithMeta);
        
      # Add header
      header = ''
        # Package Documentation
        
        This document provides detailed information about the packages included in this configuration.
        
        ## Table of Contents
        
        ${builtins.concatStringsSep "\n"
          (map (p: "- [${p.package.name}](#${p.package.name})")
            packagesWithMeta)}
        
        ---
        
      '';
    in
    header + content;
    
  # Write documentation to file
  writeDoc = content:
    pkgs.writeText "package-documentation.md" content;

in
writeDoc (generateDocs packages)