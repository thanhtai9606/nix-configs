{ pkgs, ... }:

{
  time.timeZone = "Asia/Ho_Chi_Minh";

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-unikey
      fcitx5-gtk
    ];
  };
  # Ghi đè xóa biến GTK_IM_MODULE để tránh cảnh báo trên Wayland
  environment.sessionVariables = {
    GTK_IM_MODULE = "";
  };
}
