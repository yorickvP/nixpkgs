{ lib, stdenv, fetchFromGitHub, meson, pkgconfig, libdrm, xorg
, wayland, wayland-protocols, libxkbcommon, libcap
, SDL2, mesa, libinput, pixman, xcbutilerrors, xcbutilwm, glslang
, ninja, makeWrapper, xwayland, libuuid, xcbutilrenderutil
, pipewire, stb, vulkan-loader, wlroots, libliftoff }:

let
in stdenv.mkDerivation rec {
  pname = "gamescope";
  version = "3.11.30";

  src = fetchFromGitHub {
    owner = "Plagman";
    repo = "gamescope";
    rev = version;
    sha256 = "sha256-LiAQtALeFUBWRSa1P6xLC7KV2w35kMhsB2l8nH466Ds=";
  };

  preConfigure = ''
    sed -i '/force_fallback_for/d' meson.build
    substituteInPlace meson.build \
      --replace "'< 0.3.0'" "'< 0.4.0'"
  '';

  postInstall = ''
    wrapProgram $out/bin/gamescope \
      --prefix PATH : "${lib.makeBinPath [ xwayland ]}"
  '';

  buildInputs = with xorg; [
    libX11 libXdamage libXcomposite libXrender libXext libXxf86vm
    libXtst libdrm vulkan-loader wayland wayland-protocols
    libxkbcommon libcap SDL2 mesa libinput pixman xcbutilerrors
    xcbutilwm libXi libXres libuuid xcbutilrenderutil xwayland
    pipewire wlroots libliftoff stb
  ];
  nativeBuildInputs = [ meson pkgconfig glslang ninja makeWrapper ];

  meta = with lib; {
    description = "The micro-compositor formerly known as steamcompmgr";
    license = licenses.bsd2;
    homepage = src.meta.homepage;
    platforms = platforms.linux;
    maintainers = with maintainers; [ yorickvp ];
  };
}
