{
  description = "使用 Noctalia 的 NixOS 配置";

  inputs = {
   nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

   quickshell = {
     url = "github:outfoxxed/quickshell";
     inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
     url = "github:noctalia-dev/noctalia-shell";
     inputs.nixpkgs.follows = "nixpkgs";
      # inputs.quickshell.follows = "quickshell";
    };

    zen-browser = {
     url = "github:youwen5/zen-browser-flake";
     inputs.nixpkgs.follows = "nixpkgs";
    };

   nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";

   home-manager= {
     url = "github:nix-community/home-manager/master";
     inputs.nixpkgs.follows = "nixpkgs";
    };

   nix-wpsoffice-cn.url = "github:Beriholic/nix-wpsoffice-cn";
  };

  outputs = inputs@{ self, nixpkgs, zen-browser, home-manager, ... }:
  let
    lib = nixpkgs.lib;
   system = "x86_64-linux";

    # 自动生成模块列表
   generatedModules = lib.map (file: ./modules/${file})
      (lib.filter (file: lib.hasSuffix ".nix" file)
        (builtins.attrNames (builtins.readDir ./modules)));
  in
  {
   nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
     inherit system;

      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix

        # Home Manager 配置
       home-manager.nixosModules.home-manager
        {
         home-manager.useGlobalPkgs = true;
         home-manager.useUserPackages = true;
         home-manager.users.kopfhanger = import ./home.nix;
         home-manager.extraSpecialArgs = inputs;
        }

        # Zen Browser 和中文字体
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
           inputs.zen-browser.packages.${system}.default
            # inputs.nix-wpsoffice-cn.packages.${system}.wpsoffice-cn
          ];

          fonts.packages = with pkgs; [
           inputs.nix-wpsoffice-cn.packages.${system}.chinese-fonts
          ];
        })
      ] ++ generatedModules;
    };
  };
}
