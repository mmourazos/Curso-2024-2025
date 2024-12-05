# Instalar OpenSSH windows server

Comprobar qué está instalado:

```powershell
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
```

Si no apareciese instalado, instalarlo:
```powershell
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

Inicializar el servicio:
```powershell
Start-Service sshd
```

**Las siguientes líneas las ha escrito GitHub Copilot.**

## Configuración

### Configurar el servicio

```powershell
Set-Service -Name sshd -StartupType 'Automatic' 
```

### Configurar el firewall

```powershell
New-NetFirewallRule -DisplayName "OpenSSH Server (sshd)" -Direction Inbound -LocalPort 22 -Protocol TCP -Action Allow
```

### Configurar el archivo de configuración

```powershell
Set-Content -Path C:\ProgramData\ssh\sshd_config -Value @"
#   $OpenBSD: sshd_config,v 1.103 2018/04/09 20:41:22 tj Exp $

# This is the sshd server system-wide configuration file.
```
