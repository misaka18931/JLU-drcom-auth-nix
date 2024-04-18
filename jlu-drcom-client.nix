{ pkgs ? import <nixpkgs> {},
  fetchFromGithub
}:

pkgs.stdenv.mkDerivation rec {
  pname = "jlu-drcom-client";

  # sources that will be used for our derivation.
  src = fetchFromGithub {
    owner = "AndrewLawrence80";
    repo = pname;
    rev = "12e3a829f94217e3862aaa9cb8c476633e86c9e2";
    sha256 = "0rs9bxxrw4wscf4a8yl776a8g880m5gcm75q06yx2cn3lw2b7v22";
  };
}