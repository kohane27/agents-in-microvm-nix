{ ... }:
{
  microvm = {
    hypervisor = "cloud-hypervisor";
    vcpu = 8;
    mem = 8192;

    socket = "control.socket";
    writableStoreOverlay = "/nix/.rw-store";

    volumes = [
      {
        mountPoint = "/var";
        image = "var.img";
        size = 8192;
      }
    ];

    interfaces = [
      {
        type = "tap";
        id = "microvm4";
        mac = "02:00:00:00:00:05";
      }
    ];

    shares = [
      {
        proto = "virtiofs";
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
      {
        proto = "virtiofs";
        tag = "ssh-keys";
        source = "/home/username/.ssh/microvm";
        mountPoint = "/etc/ssh/host-keys";
      }
      {
        proto = "virtiofs";
        tag = "terrax-secrets";
        source = "/var/lib/microvms/terrax/secrets";
        mountPoint = "/run/secrets";
      }
      {
        proto = "virtiofs";
        tag = "workspace";
        source = "/home/username/.local/share/microvms/terrax/workspace";
        mountPoint = "/tmp/workspace";
      }
      {
        proto = "virtiofs";
        tag = "claude-credentials";
        source = "/home/username/.claude";
        mountPoint = "/home/microvm/.claude";
      }
    ];
  };
}
