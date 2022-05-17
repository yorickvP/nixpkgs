{ lib, stdenv, fetchFromGitLab
, meson, pkg-config, ninja
, libdrm
}:

stdenv.mkDerivation rec {
  pname = "libliftoff";
  version = "0.3.0";

  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "emersion";
    repo = pname;
    rev = "ac919002ca2e099a07da25a385c24c0f4480302e";
    sha256 = "sha256-lx1hTkZgqwY/ffzL4DqZdLVHDgNZpalZmUNNtik19xw=";
  };

  nativeBuildInputs = [ meson pkg-config ninja ];

  buildInputs = [ libdrm ];

  meta = with lib; {
    description = "A lightweight KMS plane library";
    longDescription = ''
      libliftoff eases the use of KMS planes from userspace without standing in
      your way. Users create "virtual planes" called layers, set KMS properties
      on them, and libliftoff will pick planes for these layers if possible.
    '';
    inherit (src.meta) homepage;
    changelog = "https://github.com/emersion/libliftoff/releases/tag/v${version}";
    license     = licenses.mit;
    platforms   = platforms.linux;
    maintainers = with maintainers; [ primeos ];
  };
}
