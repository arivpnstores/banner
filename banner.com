```bash
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
<font color="#00BFFF">━━━━━━━━━━━━━━━━━━━━━━━━━━━━</font><br>
<font color="#00FF7F"><b>☁ PT RAJA SERVER PREMIUM ☁</b></font><br>
<font color="#00BFFF">━━━━━━━━━━━━━━━━━━━━━━━━━━━━</font><br>
<font color="#FFD700">✦ PREMIUM SSH TUNNEL SERVICE ✦</font><br>
<br>
<font color="#FF4444"><b>⚠ SERVER RULES & POLICY ⚠</b></font><br>
<font color="#FFFFFF">━━━━━━━━━━━━━━━━━━━━━━━━━━━━</font><br>
<font color="#FF5555">✘ NO FRAUD / SCAM</font><br>
<font color="#FF8C42">✘ NO HACKING / ATTACKS</font><br>
<font color="#FFD700">✘ NO CARDING / ILLEGAL ACTIVITY</font><br>
<font color="#00D9FF">✘ NO TORRENT / ABUSE</font><br>
<font color="#FF55FF">✘ NO CRIMINAL CYBER ACTIVITY</font><br>
<font color="#FFFFFF">━━━━━━━━━━━━━━━━━━━━━━━━━━━━</font><br>
<font color="#00FF7F"><b>✓ MAX LOGIN: 1 / 2 / 5 DEVICES</b></font><br>
<font color="#FF4444">⚡ MULTI-LOGIN: AUTO DELETE</font><br>
<font color="#FFFFFF">━━━━━━━━━━━━━━━━━━━━━━━━━━━━</font><br>
<br>
<font color="#00BFFF">SECURE • STABLE • PREMIUM</font><br>
<font color="#FFD700"><b>THANK YOU FOR YOUR ORDER!</b></font><br>
<font color="#00FF7F">ENJOY YOUR CONNECTION</font><br>
<font color="#00BFFF">━━━━━━━━━━━━━━━━━━━━━━━━━━━━</font><br>
<font color="#FFFFFF">© PT RAJA SERVER PREMIUM</font><br>
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
```
