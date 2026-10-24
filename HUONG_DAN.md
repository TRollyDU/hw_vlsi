# Hướng dẫn GitHub cho người mới (Verilog 35 bài)

## 0. Git, GitHub và các từ thường gặp

- **Repository (repo):** nơi lưu toàn bộ 35 bài trên GitHub.
- **Folder:** thư mục bài tập bạn được phân công (đã có sẵn).
- **Commit:** một lần ghi nhận thay đổi, kèm lời nhắn.
- **Branch:** nhánh làm việc riêng, tránh sửa trực tiếp `main`.
- **Push:** gửi các commit từ máy tính lên GitHub.
- **Pull Request (PR):** yêu cầu người quản lý kiểm tra và gộp bài vào `main`.
- **Fork:** bản sao repo trong tài khoản của bạn, dùng nếu bạn không có quyền ghi vào repo gốc.

## 1. Người quản lý: Đưa bộ khung 35 thư mục lên GitHub (chỉ làm MỘT lần)

**Chuẩn bị:** Đăng nhập GitHub, cài [Git](https://git-scm.com/downloads). Trên Windows có thể mở **Git Bash** trong thư mục `rtl-verilog-35-exercises` sau khi giải nén file ZIP.

1. Trên https://github.com chọn **New repository** (hoặc dấu `+` → `New repository`). Đặt tên `rtl-verilog-35-exercises`, chọn Public/Private tùy nhu cầu. **Không đánh dấu** khởi tạo thêm README, `.gitignore` hoặc License vì bộ khung đã có README và `.gitignore`.
2. Giải nén ZIP và mở terminal tại **bên trong** thư mục `rtl-verilog-35-exercises` (thư mục chứa `README.md`, `01_logic/`, ...).
3. Chạy lần lượt các lệnh sau (thay `YOUR_USERNAME` bằng tên tài khoản GitHub của bạn):

```bash
git init -b main
git config user.name "Tên của bạn"
git config user.email "email-ban-dung-cho-git@example.com"
git add .
git commit -m "Initialize 35 Verilog exercise folders"
git remote add origin https://github.com/YOUR_USERNAME/rtl-verilog-35-exercises.git
git push -u origin main
```

**Lưu ý:** Thay email ví dụ bằng email Git của bạn (có thể dùng địa chỉ GitHub no-reply). Khi `push`, GitHub có thể yêu cầu bạn xác thực bằng trình duyệt/Git Credential Manager; không dùng mật khẩu tài khoản như mật khẩu Git qua HTTPS.

4. Mở lại trang repo, kiểm tra thấy đủ thư mục `01_logic` đến `35_sync_ram16x8`.
5. Khuyên dùng: bật tính năng **Issues**, yêu cầu **Pull Request** trước khi merge vào `main` (Settings → Branches/Rules → Rulesets/branch protection tùy giao diện/quyền repo). Không cần cấp quyền Write cho người lạ; repo Public có thể nhận PR từ fork.

> Nếu bạn lỡ tạo repo có sẵn README mặc định, cách dễ nhất cho người mới là tạo một repo **rỗng** khác theo bước 1 để tránh phải giải quyết lịch sử Git khác nhau.

## 2. Người nộp bài: Quy tắc nộp file

Chọn một thư mục đã tạo sẵn, ví dụ `14_rca4`. Kết quả cần có đúng **2 file**:

```text
14_rca4/
├── spec.txt
└── rca4.v
```

- **Không** upload nguyên folder `14_rca4` vào bên trong `14_rca4` (tránh `14_rca4/14_rca4/`).
- **Không** đổi tên thư mục hoặc đổi tên bài khác.
- **Xóa `.gitkeep`** khi đã thêm đủ hai file (Git chỉ cần `.gitkeep` để giữ thư mục rỗng ban đầu).
- Nếu bài đang có `spec.txt` và `.v`, hãy cập nhật đúng hai file, không tạo thêm các bản `final.v`, `fixed.v`, `v2.v`.
- Không upload file nhị phân build, `.vcd`, `.out`, ảnh mô phỏng hoặc tài khoản/mật khẩu.

### Mẫu nội dung `spec.txt`

Có thể copy từ [`templates/spec_template.txt`](templates/spec_template.txt). Điền ít nhất:

```text
Ten bai: 14 - Bo cong 4 bit ripple-carry
Module: rca4
Chuc nang: Cong hai so 4 bit, co carry in va carry out.
Input: a[3:0], b[3:0], cin
Output: sum[3:0], cout
Mo ta: {cout, sum} = a + b + cin
Ghi chu: To hop, khong dung clock.
Kiem thu: 0+0, 15+1, 15+15+1, cac truong hop carry.
```

Đây **chỉ là mẫu minh họa**, các bài khác phải ghi rõ thông số thực tế của bài mình.

## 3. Cách 1: Nộp bằng website GitHub (không cần cài Git)

### A. Nếu bạn có quyền Write trong repo

1. Đăng nhập GitHub và mở repository do người quản lý cung cấp.
2. Bấm vào **thư mục bài** (ví dụ `14_rca4/`).
3. Bấm **Add file → Upload files**; kéo thả **hai file** `spec.txt` và `rca4.v` vào trang. Đảm bảo đang upload ở **đường dẫn `14_rca4/`**.
4. Nhập commit message, ví dụ `Add exercise 14 ripple-carry adder`.
5. Chọn **Create a new branch for this commit and start a pull request** thay vì commit thẳng vào `main`. Đặt branch ví dụ `submit-14-rca4`.
6. Bấm **Propose changes**, tiếp theo **Create pull request** (tên nút có thể thay đổi nhẹ).
7. **Xóa `.gitkeep` trên cùng branch**: mở file `.gitkeep` trong branch vừa tạo, chọn menu xóa file, commit thay đổi vào branch đó. PR tự cập nhật. Nếu thao tác này khó, nhờ người quản lý xóa `.gitkeep` khi duyệt PR.
8. Điền PR mô tả các đầu vào/đầu ra, cách kiểm tra và gửi cho người quản lý review.

### B. Nếu bạn KHÔNG có quyền Write trong repo

1. Mở repo gốc → bấm **Fork** để tạo bản sao repo trong tài khoản của bạn.
2. Vào fork của bạn và làm lại các thao tác upload trong mục A (chọn branch riêng trong fork).
3. Mở PR về repo gốc: bấm **Contribute → Open pull request** hoặc **Compare & pull request**.
4. Kiểm tra **base** là `main` của repo gốc, **compare/head** là branch trong fork của bạn rồi tạo PR.
5. Người quản lý repo gốc sẽ review và merge. Bạn không cần quyền Write vào repo gốc.

**Sửa file đã có:** vào đúng file, dùng biểu tượng chỉnh sửa (bút chì); commit thay đổi vào branch đang nộp. Nên giữ mỗi bài trong cùng một PR.

## 4. Cách 2: Nộp bằng Git Bash / Terminal (biết `add`, `commit`, `push`)

**Chuẩn bị:** cài Git. Nếu repo gốc cấp quyền Write thì clone repo gốc. Nếu không có Write, trên GitHub **Fork repo trước**, rồi clone URL của fork của chính bạn.

```bash
# Chỉ làm lần đầu: tải repo về máy (thay đường dẫn của repo mà bạn được phép push)
git clone https://github.com/YOUR_USERNAME/rtl-verilog-35-exercises.git
cd rtl-verilog-35-exercises

# Tạo branch mới từ main cập nhật
git switch main
git pull origin main
git switch -c submit-14-rca4
```

Giờ mở thư mục `14_rca4/` trên máy và thêm `spec.txt`, `rca4.v`, xóa `.gitkeep`. Rồi chạy:

```bash
git status                       # Xem file mới, file thay đổi, file đã xóa
git add 14_rca4/                 # Stage tất cả thay đổi trong bài 14, gồm xóa .gitkeep
git status                       # Kiểm tra lại trước khi commit
git commit -m "Add exercise 14 RCA 4-bit"
git push -u origin submit-14-rca4
```

Cuối cùng, mở link repo trên GitHub → **Compare & pull request** → mô tả rồi bấm **Create pull request**.

**Các lệnh thường dùng:**

| Lệnh | Ý nghĩa |
|---|---|
| `git status` | Xem file đã đổi và đang ở branch nào |
| `git pull origin main` | Lấy cập nhật mới nhất của nhánh main về máy (khi đang đứng ở main) |
| `git switch -c ten-branch` | Tạo và chuyển sang branch riêng |
| `git add 14_rca4/` | Chọn toàn bộ thay đổi của thư mục bài 14 |
| `git commit -m "Noi dung"` | Lưu thay đổi thành một commit |
| `git push -u origin ten-branch` | Gửi branch lên GitHub |
| `git log --oneline -5` | Xem 5 commit gần nhất |

**Nếu bị `Permission denied` khi push:** bạn không có quyền với repo gốc hoặc chưa đăng nhập; hãy dùng fork của mình và push lên fork (kiểm tra `git remote -v`).

**Nếu `git commit` báo `nothing to commit`:** chưa thay đổi file, hoặc đang đứng sai thư mục, hoặc đã commit những thay đổi đó rồi. Chạy `git status`.

**Nếu `git push` báo `rejected` / `non-fast-forward`:** có cập nhật mới trên branch ở GitHub. Đừng dùng `--force`; xem lại branch, fetch/pull và xử lý conflict hoặc hỏi người quản lý.

## 5. Người quản lý: Review và merge

1. Vào tab **Pull requests** của repository.
2. Mở PR, xem tab **Files changed**.
3. Xác minh chỉ một thư mục bài được cập nhật; đã có `spec.txt` và file `.v` đúng tên; đã xóa `.gitkeep`; `spec.txt` nêu đủ chức năng, I/O.
4. Nếu ổn, chọn **Merge pull request**. Nếu chưa ổn, comment để người nộp chỉnh sửa trên branch cũ.
5. Sau merge, thư mục trên `main` sẽ có đúng hai file bài tập. Không cần tạo thư mục khác.

## 6. Nguồn tham khảo GitHub chính thức

- [Tải file lên GitHub](https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository)
- [Bắt đầu với Pull Request](https://docs.github.com/en/pull-requests/get-started/pull-request-quickstart)
- [Tạo PR từ fork](https://docs.github.com/en/pull-requests/how-tos/create-pull-requests/creating-a-pull-request-from-a-fork)
