
# Mikrotik Hotspot Queue Setup Script

To create a **Mikrotik Hotspot Queue**, make sure you have already set up the **Mikrotik Hotspot** and ensure that the client can connect to the internet after login.

### Why You Need This

After updating to **Router OS 7**, you can no longer delete the dynamic queues that are created by the Hotspot. That's why you need to create a custom Mikrotik User Profile.

---

## Full Script for Login and Logout

### On Login Script

In the **Scripts tab**, add the following script to create a queue when the user logs in:

```rsc
:local bw "20M/20M"
:local burstLimit "30M/30M"
:local burstThreshold "15M/15M"
:local burstTime "10/10"

:log info "Creating queue for $user $username at $ip with limit $bw"
:log info "/queue simple add name=(Hotspot-$username-$address) target=$address max-limit=$bw burst-limit=$burstLimit burst-threshold=$burstThreshold burst-time=$burstTime"

/queue simple add name=("Hotspot-" . $username . "-" . $address) \
    target=$address \
    max-limit=$bw \
    burst-limit=$burstLimit \
    burst-threshold=$burstThreshold \
    burst-time=$burstTime
```

### On Logout Script

Add this script to delete the queue when the user logs out:

```rsc
:local ip $address
:log info "Deleting queue for $username at $ip with limit $bw"

/queue simple remove [find name=("Hotspot-" . $username . "-" . $address)]
```

### Queue Parameters Breakdown

| **Variable**      | **Example Value** | **Purpose**                                          |
|-------------------|-------------------|------------------------------------------------------|
| `bw`              | 20M/20M            | Max normal speed (upload/download)                   |
| `burstLimit`      | 30M/30M            | Max speed allowed during a burst                     |
| `burstThreshold`  | 15M/15M            | When average speed reaches 15M, burst stops          |
| `burstTime`       | 10/10              | Duration of the burst in seconds (upload/download)   |

---

# Radius Hotspot Integration

When using a **Radius Server**, you can pass additional parameters in the reply. The script creates a queue when the user successfully logs in, and deletes the queue on logout.

### Radius Reply Example

```rsc
kevin           Cleartext-Password := "password"
                Mikrotik-Group := "100/100"
```

### Example Radius Configuration

```rsc
# <username>    <password-type> := "password"
#               Mikrotik-Rate-Limit := "[Target Upload/Target Download] [Burst Limit Upload / Burst Limit Download] [Burst Threshold U / D] [Burst Time U / D]"
#  echo -n 'yourpassword' | sha256sum

# testuser      SHA2-Password := "e3c652f0ba0b4801205814f8b6bc49672c4c74e25b497770bb89b22cdeb4e951"
#               Mikrotik-Rate-Limit := "1M/2M 2M/4M 500k/1M 10/20 5 256k/512k"
#               Mikrotik-Group := "basic"
```
