# Hirschmann Switch Basic Config

Connect using console
```
switch>en
switch#
```

Enter Config Mode
```
switch>#conf t
switch(config)#
```

Enable SSH
```
switch(config)#ip ssh server
```

Setup user for SSH
```
switch(config)#local-user admin class manager
switch(config-user-manager-admin)#service-type ssh
switch(config-user-manager-admin)#password 0 <your_password>
```

Setup enable Password
```
switch(config)#enable password 0 <your_password>
```

Setup VLAN
```
switch(config)#vlan 120
switch(config)#inter vlan 120
switch(config)#ip address <vlan interface address>
```

Setup Route
```
switch(config)#ip route 0.0.0.0 0.0.0.0 <gateway>
```

Assign VLAN Trunk Mode
```
switch(config)#inter gigabitethernet 0/24
switch(config-if-gigabitethernet0/24)#switchport mode trunk
switch(config-if-gigabitethernet0/24)#switchport trunk pvid vlan 120
switch(config-if-gigabitethernet0/24)#switchport trunk allowed add 120, 920
```

Assign Access VLAN
```
switch(config)#interface gigabitethernet0/2-0/24
switch(config)#switchport mode access
switch(config-if-range)#switchport access vlan <vlan-id>
```

Save Config
```

```