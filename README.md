# 35 bài tập thiết kế số bằng Verilog

Repository này gồm **35 bài tập Verilog**, tương ứng với 35 mục trong danh sách A–E. Mỗi thư mục bài có **3 file**:

- `spec.txt` — mô tả yêu cầu, ngõ vào/ngõ ra, chức năng, giả định và các trường hợp kiểm tra.
- `<ten_bai>.v` — mã nguồn Verilog, với `<ten_bai>` trùng **phần tên sau số thứ tự của thư mục**.
- `tb_<ten_bai>.v` — testbench tự kiểm tra, in PASS/FAIL cho mỗi phép kiểm tra và tổng số ở cuối.

**Ví dụ:** bài `02_mux4_8b/` sau khi nộp sẽ có:

```text
02_mux4_8b/
├── spec.txt
├── mux4_8b.v
└── tb_mux4_8b.v
```

> **Quan trọng:** Mỗi thư mục bài chỉ giữ 3 file trên, không giữ `.gitkeep`, waveform hay file build. Không đổi tên các thư mục đã có.

RTL dùng Verilog-2001. Quy ước I/O, clock/reset, parameter và test plan được ghi trong `spec.txt` từng bài. Testbench dài 22–41 dòng; với mạch dùng clock, dữ liệu được đổi trước cạnh lấy mẫu và kiểm tra sau khi RTL cập nhật. Bài 33 dùng đúng hai trạng thái đỏ/xanh, đổi theo `tick`.

Đợt mô phỏng dùng Vivado xsim chỉ chạy bài 27–35; bài 1–26 có testbench nhưng không chạy mô phỏng. Bài 29–30 dùng parameter nhỏ trong testbench để rút ngắn thời gian. Mặc định bài 30 vẫn tạo một tick mỗi 50.000.000 chu kỳ clock.

📘 **Đọc [HUONG_DAN.md](HUONG_DAN.md) trước khi đóng góp** — có hướng dẫn từng bước cho người mới bằng giao diện GitHub và Git Bash, kể cả `add`, `commit`, `push`, Pull Request.

## Danh sách 35 bài tập

### A. Mạch tổ hợp cơ bản

| STT | Thư mục | Tên bài | File Verilog phải nộp |
|---:|---|---|---|
| 1 | [`01_logic/`](01_logic/) | Các cổng logic cơ bản | `logic.v` |
| 2 | [`02_mux4_8b/`](02_mux4_8b/) | Bộ dồn kênh 4:1, dữ liệu 8 bit | `mux4_8b.v` |
| 3 | [`03_mux8/`](03_mux8/) | Bộ dồn kênh 8:1 | `mux8.v` |
| 4 | [`04_dec2_4/`](04_dec2_4/) | Bộ giải mã 2–4 | `dec2_4.v` |
| 5 | [`05_dec3_8/`](05_dec3_8/) | Bộ giải mã 3–8 | `dec3_8.v` |
| 6 | [`06_prio_enc4_2/`](06_prio_enc4_2/) | Bộ mã hóa ưu tiên 4–2 | `prio_enc4_2.v` |
| 7 | [`07_prio_enc8_3/`](07_prio_enc8_3/) | Bộ mã hóa ưu tiên 8–3 | `prio_enc8_3.v` |
| 8 | [`08_cmp4/`](08_cmp4/) | Bộ so sánh 4 bit | `cmp4.v` |
| 9 | [`09_bcd_7seg/`](09_bcd_7seg/) | Giải mã BCD sang LED 7 đoạn | `bcd_7seg.v` |
| 10 | [`10_bin_gray/`](10_bin_gray/) | Chuyển đổi nhị phân ↔ mã Gray | `bin_gray.v` |
| 11 | [`11_barrel8/`](11_barrel8/) | Bộ quay vòng 8 bit (barrel shifter) | `barrel8.v` |

### B. Mạch số học

| STT | Thư mục | Tên bài | File Verilog phải nộp |
|---:|---|---|---|
| 12 | [`12_half_adder/`](12_half_adder/) | Bộ cộng bán phần (half adder) | `half_adder.v` |
| 13 | [`13_full_adder/`](13_full_adder/) | Bộ cộng toàn phần (full adder) | `full_adder.v` |
| 14 | [`14_rca4/`](14_rca4/) | Bộ cộng 4 bit (ripple-carry) | `rca4.v` |
| 15 | [`15_sub4/`](15_sub4/) | Bộ trừ 4 bit | `sub4.v` |
| 16 | [`16_addsub4/`](16_addsub4/) | Bộ cộng/trừ 4 bit | `addsub4.v` |
| 17 | [`17_cla4/`](17_cla4/) | Bộ cộng nhớ nhanh 4 bit (CLA) | `cla4.v` |
| 18 | [`18_mul4x4/`](18_mul4x4/) | Bộ nhân 4 × 4 bit | `mul4x4.v` |
| 19 | [`19_alu4/`](19_alu4/) | ALU 4 bit | `alu4.v` |

### C. Phần tử nhớ & thanh ghi

| STT | Thư mục | Tên bài | File Verilog phải nộp |
|---:|---|---|---|
| 20 | [`20_dlatch/`](20_dlatch/) | D latch | `dlatch.v` |
| 21 | [`21_dff_en/`](21_dff_en/) | D flip-flop có enable | `dff_en.v` |
| 22 | [`22_dff_rst/`](22_dff_rst/) | D flip-flop: reset đồng bộ và bất đồng bộ | `dff_rst.v` |
| 23 | [`23_jkff/`](23_jkff/) | JK flip-flop | `jkff.v` |
| 24 | [`24_tff/`](24_tff/) | T flip-flop | `tff.v` |
| 25 | [`25_sipo8/`](25_sipo8/) | Thanh ghi dịch 8 bit (SIPO) | `sipo8.v` |
| 26 | [`26_univ_shift4/`](26_univ_shift4/) | Thanh ghi dịch đa năng 4 bit | `univ_shift4.v` |

### D. Bộ đếm & định thời

| STT | Thư mục | Tên bài | File Verilog phải nộp |
|---:|---|---|---|
| 27 | [`27_cnt_up4_load/`](27_cnt_up4_load/) | Bộ đếm lên 4 bit có nạp | `cnt_up4_load.v` |
| 28 | [`28_cnt_updn4/`](28_cnt_updn4/) | Bộ đếm lên/xuống 4 bit | `cnt_updn4.v` |
| 29 | [`29_clk_div/`](29_clk_div/) | Bộ chia tần số | `clk_div.v` |
| 30 | [`30_tick1hz_50m/`](30_tick1hz_50m/) | Tạo xung tick 1 Hz từ clock 50 MHz | `tick1hz_50m.v` |
| 31 | [`31_bcd_cnt_00_59/`](31_bcd_cnt_00_59/) | Bộ đếm BCD 00–59 (đếm giây) | `bcd_cnt_00_59.v` |

### E. FSM & bộ nhớ

| STT | Thư mục | Tên bài | File Verilog phải nộp |
|---:|---|---|---|
| 32 | [`32_fsm_1011/`](32_fsm_1011/) | FSM phát hiện chuỗi 1011 | `fsm_1011.v` |
| 33 | [`33_fsm_traffic/`](33_fsm_traffic/) | FSM đèn giao thông | `fsm_traffic.v` |
| 34 | [`34_lfsr8/`](34_lfsr8/) | Bộ tạo số giả ngẫu nhiên LFSR 8 bit | `lfsr8.v` |
| 35 | [`35_sync_ram16x8/`](35_sync_ram16x8/) | RAM đồng bộ 16 × 8 bit | `sync_ram16x8.v` |

## Quy tắc đóng góp

1. Chọn **đúng thư mục** theo số bài; tuyệt đối không sửa bài khác trong cùng Pull Request.
2. Trong thư mục bài đã hoàn thành, chỉ giữ **`spec.txt`, `<ten_bai>.v` và `tb_<ten_bai>.v`**.
3. Viết mã bằng **Verilog** (`.v`), ưu tiên RTL có thể tổng hợp, không đưa waveform, file build hay file mô phỏng lên repository.
4. `spec.txt` gồm Overview, Scope, Functional spec (I/O và Blocks nếu có nhiều khối), Dataflow, Test plan. Test plan chỉ nêu ca kiểm tra, không ghi expected; xem [mẫu SPEC](templates/spec_template.txt).
5. Mỗi bài nên được nộp trong **một branch riêng và một Pull Request**, để dễ kiểm tra và duyệt.
6. Nếu người khác đã hoàn thành bài, hãy cập nhật đúng ba file đó trên branch mới và giải thích thay đổi trong Pull Request; không ghi đè mà không xem bản mới nhất.

### Người quản lý repo

Người quản lý tạo repository GitHub, đẩy bộ khung này lên `main`, xem các Pull Request và merge khi đạt yêu cầu. **Không cần tự tay tạo lại 35 thư mục.**

---

**Tóm tắt Git**: `git add` chọn thay đổi → `git commit` lưu thành một phiên bản trên máy → `git push` đưa phiên bản đó lên GitHub → Pull Request đề nghị gộp vào `main`.
