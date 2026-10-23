# The Homebrew formula for Yagi with the built-in Tailscale node (the build the -tailscale Docker image has), which the
# release workflow fills in (scripts/render_formula.sh) and pushes to the tap, johnschult/homebrew-tap, on every
# release. The @…@ marks are replaced with the release's version and the SHA-256 of each of its archives. It installs
# the program the release already built; nothing is built by Homebrew.
class YagiTailscale < Formula
  desc "Share an HDHomeRun tuner with Plex, Jellyfin and Emby, with a Tailscale node"
  homepage "https://github.com/johnschult/yagi"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/johnschult/yagi/releases/download/v2026.10.19/yagi_2026.10.19_darwin_arm64_tailscale.tar.gz"
      sha256 "09ba40d92d10249078b19912ffdb250305e6ce1b16fe9c391a46934a656bcb48"
    end
    on_intel do
      url "https://github.com/johnschult/yagi/releases/download/v2026.10.19/yagi_2026.10.19_darwin_amd64_tailscale.tar.gz"
      sha256 "624e9a06dfce4611ec6d2c7127404f2e0790eb2aab1c46501e9748552fcb920a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/johnschult/yagi/releases/download/v2026.10.19/yagi_2026.10.19_linux_arm64_tailscale.tar.gz"
      sha256 "f18b0787aca7f60d09d9c8135c569e314f873d523769c418f02113f9bc6c1142"
    end
    on_intel do
      url "https://github.com/johnschult/yagi/releases/download/v2026.10.19/yagi_2026.10.19_linux_amd64_tailscale.tar.gz"
      sha256 "b2f2b89341e29656e76deda6d1a8e8a9c28ea9700f29a30f6d72b318b0d1fabe"
    end
  end

  # Both install a program called yagi. They keep their settings in the same place, so switching keeps them.
  conflicts_with "yagi", because: "both install a program called yagi"

  def install
    bin.install "yagi"
  end

  def post_install
    (var/"yagi").mkpath
  end

  # The settings live in var/yagi, not in whatever folder it was started from.
  service do
    run [opt_bin/"yagi", "-config", var/"yagi/yagi.json"]
    keep_alive true
    working_dir var/"yagi"
    log_path var/"log/yagi.log"
    error_log_path var/"log/yagi.log"
  end

  def caveats
    <<~EOS
      To run Yagi in the background, and again after a restart:
        brew services start yagi

      Its settings file is #{var}/yagi/yagi.json, and its log is #{var}/log/yagi.log. The log has the one-time
      setup link that makes you the admin; the web page is at http://localhost:9244/ on this machine.
      To try it in a terminal first, run: yagi

      This build has Yagi's own Tailscale node: switch it on under Settings → Access. Its identity is kept in
      #{var}/yagi/tailscale.
    EOS
  end

  test do
    assert_match "#{version} (built-in Tailscale)", shell_output("#{bin}/yagi -version")
  end
end
