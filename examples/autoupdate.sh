#!/bin/sh
# SPDX-FileCopyrightText: 2024 Simen Strange <https://github.com/dxlr8r/wrax>
# SPDX-License-Identifier: MIT
# Version: 0.1.0

set -e

# ensure nala is installed
dpkg-query -W nala >/dev/null 2>&1 || apt-get install -y nala

autoupdate='/usr/local/bin/autoupdate.sh'

cat <<'EOF' > "$autoupdate"
#!/bin/sh
set -eo pipefail

nala update
nala upgrade -y

if uname -m | fgrep -qx aarch64; then 
  k3s_bin="${k3s_bin}-arm64"
else
  k3s_bin=k3s
fi

k3s_version=$(jq -n --argjson root "$(curl -sLo - https://update.k3s.io/v1-release/channels)" -r '$root.data[] | select(.id == "stable") | .latest')

curl -sLo /usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/${k3s_version}/${k3s_bin}
chmod +x /usr/local/bin/k3s

systemctl restart k3s
EOF

chmod +x "$autoupdate"

printf '%s' "[Service]
Type=oneshot
ExecStart=$autoupdate
" > /etc/systemd/system/autoupdate.service

printf '%s' '[Timer]
OnCalendar=Wed 19:00:00

[Install]
WantedBy=timers.target
' > /etc/systemd/system/autoupdate.timer

systemctl daemon-reload
systemctl enable autoupdate.service
systemctl enable --now autoupdate.timer
