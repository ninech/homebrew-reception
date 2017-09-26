class Reception < Formula
  desc "Entry page & reverse proxy for all your docker-compose projects."
  homepage "https://github.com/ninech/reception"
  url "https://github.com/ninech/reception/archive/2.0.0.tar.gz"
  version "2.0.0"
  sha256 "f2cc027a448990761ca9e3da704f3a6aefeee2520ac246bcf9e1c54ef122ae31"
  head "https://github.com/ninech/reception.git"

  depends_on "go" => :build
  depends_on "docker" => :optional
  depends_on "docker-compose" => :optional

  def install
    mkdir_p buildpath/"src/github.com/ninech"
    ln_sf buildpath, buildpath/"src/github.com/ninech/reception"

    ENV["GOBIN"] = buildpath
    ENV["GOPATH"] = buildpath

    system "make", "build"

    bin.install "reception"
  end

  def caveats
    <<-EOS.undent
      Read https://github.com/ninech/reception#macos to learn how to complete the setup!
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
