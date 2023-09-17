cask "cloudnet" do
  version "1.36.2.1"
  sha256 "53489f77226b4fa55fcefeed68dfeb66e289e3307cfaaa298a4895488dfac6ac"

  url "https://pkgs.cloudnet.world/stable/macos/CloudNet_v#{version}.dmg"
  name "CloudNet for Mac client"
  desc "Professional and easy-to-use enterprise-level meshVPN product"
  homepage "https://cloudnet.world/"

  # This appcast is slower to update than the submissions we get. See:
  #   https://github.com/Homebrew/homebrew-cask/pull/90907#issuecomment-710107547
  livecheck do
    url "https://pkgs.cloudnet.world/stable/appcast.xml"
    strategy :sparkle, &:version
  end

  auto_updates true
  conflicts_with formula: "dayunet2009/tap/cloudnet"
  depends_on macos: ">= :catalina"

  app "CloudNet.app"
  installer script: {
    executable: "CloudNet.app/Contents/Resources/cnet",
    args:       ["install"],
    sudo:       true,
  }

  uninstall quit:      "world.cloudnet.client",
            launchctl: "world.cloudnet.client.cloudnetd",
            script:    {
              executable: "CloudNet.app/Contents/Resources/cnet",
              args:       ["uninstall"],
              sudo:       true,
            },
            delete:    "/Applications/CloudNet.app"

  zap trash: [
    "/Library/LaunchDaemons/world.cloudnet.client.cloudnetd.plist",
    "~/Library/Preferences/world.cloudnet.client.cloudnetd.plist",
    "~/Library/Containers/world.cloudnet.client",
    "~/Library/Group Containers/$(TeamIdentifierPrefix)world.cloudnet.client",
  ]
end
