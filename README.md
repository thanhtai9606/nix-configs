# nix-configs

Cấu hình NixOS + Home Manager cho user **nemo**, dùng chung trên **laptop** và **desktop**: gói, dịch vụ và dotfiles giống nhau; chỉ khác phần hardware và profile màn hình.

## Yêu cầu

- NixOS với flakes bật (`nix.settings.experimental-features`)
- Clone repo (ví dụ `/home/nemo/apps/k8s/nixos-config`)

## Cấu trúc

```
flake.nix                 # laptop, desktop, alias nemo → laptop
nixos/
  configuration.nix       # Cấu hình hệ thống dùng chung
  machines/
    laptop.nix            # hostname + import hardware laptop
    desktop.nix           # hostname + import hardware desktop
  hardware/
    laptop.nix            # disk, kernel modules (nixos-generate-config)
    desktop.nix           # cập nhật từ generate-config trên desktop
  boot.nix, networking.nix, desktop.nix, packages.nix, ...
home-manager/             # Dotfiles user nemo (niri, fish, neovim, …)
```

| Flake output | Mô tả |
|--------------|--------|
| `#laptop` | Máy laptop (`nemo-laptop`) |
| `#desktop` | Máy desktop (`nemo-desktop`) |
| `#nemo` | Alias của `#laptop` (lệnh deploy cũ) |
| `homeConfigurations.nemo` | Home Manager độc lập (mặc định profile laptop) |

Home Manager trên NixOS nhận `hostProfile` từ flake: laptop dùng `display-kanshi.nix` (màn built-in + dock), desktop dùng `display-kanshi-desktop.nix`.

## Áp dụng cấu hình

Thay `FLAKE` bằng đường dẫn tới repo (hoặc dùng remote flake nếu bạn cấu hình).

**Laptop:**

```bash
sudo nixos-rebuild switch --flake FLAKE#laptop
```

**Desktop** (sau khi đã điền `nixos/hardware/desktop.nix`):

```bash
sudo nixos-rebuild switch --flake FLAKE#desktop
```

Ví dụ local:

```bash
sudo nixos-rebuild switch --flake /home/nemo/apps/k8s/nixos-config#laptop
```

**Home Manager** (ngoài NixOS hoặc thử nhanh):

```bash
home-manager switch --flake FLAKE#nemo
```

## Thiết lập hardware desktop lần đầu

Trên máy desktop:

```bash
sudo nixos-generate-config --show-hardware-config
```

Copy nội dung vào `nixos/hardware/desktop.nix` (thay các placeholder `REPLACE-*-UUID`). Commit và rebuild với `#desktop`.

Trên laptop, nếu đổi ổ đĩa hoặc partition, cập nhật tương tự `nixos/hardware/laptop.nix`.

## Kiểm tra flake

```bash
nix flake check
nix fmt   # alejandra (formatter trong flake)
```

## Font chữ (Fira Code)

| Nơi | Cấu hình |
|-----|----------|
| **Alacritty** | Terminal mặc định — **FiraCode Nerd Font Mono** (`home-manager/alacritty.nix`) |
| **Ghostty** | Cài system-wide; font trong `home-manager/fonts.nix` → `~/.config/ghostty/config` |
| **Neovim / tmux / fish** | Chạy *trong* terminal → dùng font của Alacritty (hoặc Ghostty nếu bạn mở Ghostty) |
| **Toàn hệ thống** | `fonts.packages` + fontconfig mặc định monospace — `nixos/packages.nix`, `home-manager/fonts.nix` |

**Fira Code** và **FiraCode Nerd Font** đều được cài; Alacritty dùng `FiraCode Nerd Font Mono`, Ghostty vẫn `Fira Code` (`fonts.nix`).

### Font Microsoft & WPS

Cài qua `fonts.packages` trong `nixos/packages.nix` (license **unfree** — flake đã bật `allowUnfree`):

| Gói | Dùng cho |
|-----|----------|
| `corefonts` | Arial, Times New Roman, Verdana, Courier New, … |
| `vista-fonts` | Calibri, Cambria, Consolas, Corbel, Candara, … (Office) |
| `vista-fonts-chs` / `vista-fonts-cht` | Font Hán cho WPS / tài liệu Trung |
| `liberation_ttf` | Fallback tương thích metric với MS |

**WPS Office** (nếu cài `wpsoffice` từ nixpkgs) sẽ tìm font theo tên qua fontconfig — không cần cấu hình riêng trong WPS sau khi rebuild. Terminal vẫn ưu tiên Fira Code; sans/serif mặc định desktop ưu tiên Noto rồi Calibri/Arial (xem `home-manager/fonts.nix`).

## Ghi chú

- User hệ thống: **nemo** (fish, wheel, docker, …) — khai báo trong `nixos/users.nix`.
- Hostname: `nemo-laptop` / `nemo-desktop` (sửa trong `nixos/machines/*.nix` nếu cần).
- Channel NixOS tắt; cập nhật qua `nix flake update` trong repo.
