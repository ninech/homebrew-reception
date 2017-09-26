class Reception < Formula
  desc "Entry page & reverse proxy for all your docker-compose projects."
  homepage "https://github.com/ninech/reception"
  url "https://github.com/ninech/reception/archive/2.0.0.tar.gz"
  sha256 "efc080ca5245a6a9718936c22c7502a889c2d3dd71880315fe4bea95b4da4cb5"
  head "https://github.com/ninech/reception.git"
  revision 3

  depends_on "go" => :build
  depends_on "git" => :build
  depends_on "docker" => :optional
  depends_on "docker-compose" => :optional

  bottle do
    cellar :any
    root_url "https://github.com/ninech/homebrew-reception/releases/download/v2.0.0_3"
    sha256 "70964ae0e9f1c416ddde43adbb50e955b0f6d38c2f86b7310912ebca01d89f3d" => :sierra
  end

  def install
    mkdir_p buildpath/"src/github.com/ninech"
    ln_sf buildpath, buildpath/"src/github.com/ninech/reception"

    ENV["GOBIN"] = buildpath
    ENV["GOPATH"] = buildpath
    ENV["PATH"] = "#{buildpath}:#{ENV["PATH"]}"

    system "make", "build"

    bin.install "reception"
  end

  def caveats
    <<-EOS.undent
      Read https://github.com/ninech/reception#macos to learn how to complete the setup!

      Then type http://reception.docker into your browser and 😍.
    EOS
  end

  plist_options :manual => "sudo reception"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>ch.nine.reception</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{HOMEBREW_PREFIX}/bin/reception</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>WorkingDirectory</key>
      <string>#{var}/run/</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/reception.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/reception.log</string>
    </dict>
    </plist>
    EOS
  end

  test do
    system bin/"reception", "-v"
  end
end
