#!/bin/bash
# ==========================================
#  PT RAJA SERVER PREMIUM
#  SSH / DROPBEAR BANNER INSTALLER
# ==========================================

BANNER="/etc/banner.com"

# Pastikan dijalankan sebagai root
if [[ $EUID -ne 0 ]]; then
    echo "Jalankan script sebagai root!"
    exit 1
fi

# Buat banner premium
cat > "$BANNER" << 'EOF'
<p style="text-align:center">
<font color="#00E5FF">━━━━━━━━━━━━━━━━━━━━━━━━━━━━</font><br>
<font color="#FFD700"><b>✦ THANK YOU FOR YOUR ORDER! ✦</b></font><br>
<font color="#00E5FF">━━━━━━━━━━━━━━━━━━━━━━━━━━━━</font><br>
</p>
EOF

# Atur permission banner
chmod 644 "$BANNER"

# Restart service jika tersedia
for SERVICE in ssh sshd dropbear; do
    if systemctl cat "$SERVICE" >/dev/null 2>&1; then
        systemctl restart "$SERVICE" 2>/dev/null || true
    fi
done

echo "=========================================="
echo "  BANNER SSH / DROPBEAR BERHASIL DIPASANG"
echo "  PT RAJA SERVER PREMIUM"
echo "=========================================="
echo "Lokasi: $BANNER"
