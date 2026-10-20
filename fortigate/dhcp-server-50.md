# FortiGate DHCP server for family devices (reference)

FortiGate takes over DHCP on the Rogers LAN (wan1) so family devices receive the AdGuard DNS address.
The Rogers gateway pool was shrunk to 10.0.0.201 to 253 so the FortiGate pool does not overlap it.

```
config system dhcp server
  edit 50
    set interface "wan1"
    set default-gateway 10.0.0.1
    set netmask 255.255.255.0
    set dns-server1 10.0.0.4
    set dns-server2 9.9.9.9
    set lease-time 86400
    config ip-range
      edit 1
        set start-ip 10.0.0.20
        set end-ip 10.0.0.200
      next
    end
  next
end
```

- `10.0.0.4` is a virtual IP on the FortiGate that forwards port 53 to AdGuard Home at 10.20.0.102.
- `9.9.9.9` is the fallback. It works if AdGuard is down but skips filtering.
- Verify the exact syntax against the live device before reuse. FortiOS 6.0.8.
