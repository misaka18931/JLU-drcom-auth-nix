{ stdenv,
  lib,
  fetchFromGitHub,
  username,
  passwd,
  ipAddr,
  macAddr,
  hostname? "nixos",
  authIP? "10.100.61.3",
  authPort? "61440"
}:

stdenv.mkDerivation rec {
  name = pname;
  pname = "jlu-drcom-client";

  # sources that will be used for our derivation.
  src = fetchFromGitHub {
    owner = "AndrewLawrence80";
    repo = pname;
    rev = "12e3a829f94217e3862aaa9cb8c476633e86c9e2";
    hash = "sha256-rPbKce/Hs4tEbW6FxrEpXPJC/ksFvcMpeN+fVrhq2yI=";
  };
  buildPhase = ''
    substituteInPlace config.h \
    --replace-fail xiaoming22 "${username}" \
    --replace-fail "xiaoming123456" "${passwd}" \
    --replace-fail "192.168.1.100" "${ipAddr}" \
    --replace-fail '\x00\x00\x00\x00\x00\x00' "${macAddr}" \
    --replace-fail "xiaoming-linux" "${hostname}" \
    --replace-fail "5.10.0-amd64" "$(uname -r)" \
    --replace-fail "10.100.61.3" "${authIP}" \
    --replace-fail "61440" "${authPort}"
    make
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp drclient_jlu $out/bin/${pname}
  '';

  meta = with lib; {
    description = "吉林大学校园网认证客户端(C语言版) ";
    longDescription = ''
      吉林大学校园网认证客户端(C语言版)
      基于学校官方提供的Linux认证客户端编写，适用于支持POSIX标准的环境(Linux,BSD,Cygwin...)
    '';
    homepage = "https://github.com/AndrewLawrence80/jlu-drcom-client/tree/master";
    # license = licenses.gpl3Plus;
    maintainers = [ "misaka18931" ];
    platforms = platforms.all;
  };
}
