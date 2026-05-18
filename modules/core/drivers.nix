{ ... }:

{
  flake.nixosModules.drivers = { pkgs, ... }: {
    # AMDGPU & GRAPHICS HARDWARE
    hardware.graphics = {
      enable = true;
      enable32Bit = true; # Critical for 32-bit games (Steam/Wine)
    };

    # Enable native AMD OpenCL and early KMS stage-1 loading
    hardware.amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
    };

    # PERFORMANCE & LATENCY TUNING
    environment.variables = {
      # Enable a large shader cache size (forces Mesa to cache shaders to prevent in-game compilation stutter)
      MESA_SHADER_CACHE_MAX_SIZE = "4G";
    };

    services.xserver.videoDrivers = ["amdgpu"];

    # AMDGPU CONTROLLER & OVERCLOCKING (LACT)
    # Enable LACT system daemon for fan curves, voltage control, and monitoring
    services.lact = {
      enable = true;
    };

    # Required featuremask kernel parameter to unlock all overdrive power state configurations in LACT
    boot.kernelParams = [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];

    # Install LACT GUI and CLI utilities for control
    environment.systemPackages = with pkgs; [
      lact
    ];
  };
}
