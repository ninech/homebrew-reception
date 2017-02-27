class Reception < Formula
  desc "Entry page & reverse proxy for all your docker-compose projects."
  homepage "https://github.com/ninech/reception"
  url "https://github.com/ninech/reception/archive/v0.1.0.tar.gz"
  sha256 "987f84ae9b913d74327ed468329de53ffcc99972f0e7214e5ac6ae180b19c542"
  head "https://github.com/ninech/reception.git"

  depends_on "docker-gen" => :run
  depends_on "dnsmasq" => :run
  depends_on "nginx" => :run
  depends_on "docker" => :optional
  depends_on "docker-compose" => :optional

  def install
    ect_reception = (etc/"reception")
    ect_reception.mkpath
    ect_reception.install "docker-gen.osx.conf",
                          "index.html.tmpl",
                          "nginx.conf.tmpl"
  end

  def caveats
    <<-EOS.undent
      Read https://github.com/ninech/reception#macos to learn how to complete your setup!
    EOS
  end

  plist_options :manual => "sudo docker-gen -config #{HOMEBREW_PREFIX}/etc/docker-gen.osx.conf"

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
        <string>#{HOMEBREW_PREFIX}/bin/docker-gen</string>
        <string>-config</string>
        <string>#{etc}/reception/docker-gen.osx.conf</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>WorkingDirectory</key>
      <string>#{etc}/reception</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/reception.log</string>
      <key>StandardOutPath</key>
      <string>#{var}/log/reception.log</string>
    </dict>
    </plist>
    EOS
  end

  test do
    # This util is merely a bunch of pre-defined config files
    # and the main util `docker-gen` has no config test option.
    # That's why I really can't come up with a test that would
    # test anything meaningfull.
    system "true"
  end
end
