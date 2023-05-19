Create Directory with Limited Storage:
1. buat directory Kosong
```bash
$ mkdir /home/user/newspace
```

2. Membuat image dengan file size 5GB
```bash
$ sudo dd if=/dev/zero of=/mnt/space00.img bs=1024 count=5000000
```

3. Format image supaya bisa di akses
```bash
$ sudo mkfs.ext4 /mnt/space00.img
```

4. Mount img ke folder
```bash
$ sudo mount -o loop /mnt/space00.img /home/user/newspace
```

5. Jika berhasil di mount, cek menggunakan
```bash
$ df -h
```

6. Mendaftarkan di fstab supaya setiap dinyalakan saat di restart auto mount
```bash
$ sudo nano /etc/fstab
add new line
/mnt/space00.img /home/user/newspace ext4 loop 1 2
```