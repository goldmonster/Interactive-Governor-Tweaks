#Script created by Alcolawl - 1/06/2016 - Please give credit when using this in your work!
echo ----------------------------------------------------
echo Applying 'RedHawk' IntelliActive Governor Settings
echo ----------------------------------------------------

#Experimental Settings Meshing Interactive and IntelliActive together.
#For Phasma(5X) and Kylo(6P) Kernels only!

#Apply settings to LITTLE cluster
echo Applying settings to LITTLE cluster
#Temporarily change permissions to governor files for the LITTLE cluster to enable IntelliActive governor
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo intelliactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
#Tweak IntelliActive Governor
echo 95 460800:25 600000:43 672000:65 787200:78 864000:92 960000:95 1248000:98 1440000:100 > /sys/devices/system/cpu/cpufreq/intelliactive/target_loads
echo -1 > /sys/devices/system/cpu/cpufreq/intelliactive/timer_slack
echo 384000 > /sys/devices/system/cpu/cpufreq/intelliactive/hispeed_freq
echo 20000 > /sys/devices/system/cpu/cpufreq/intelliactive/timer_rate
echo 20000 > /sys/devices/system/cpu/cpufreq/intelliactive/above_hispeed_delay
echo 200 > /sys/devices/system/cpu/cpufreq/intelliactive/go_hispeed_load
echo 60000 > /sys/devices/system/cpu/cpufreq/intelliactive/min_sample_time
echo 960000 > /sys/devices/system/cpu/cpufreq/intelliactive/up_threshold_any_cpu_freq
echo 787000 > /sys/devices/system/cpu/cpufreq/intelliactive/sync_freq
echo 90 > /sys/devices/system/cpu/cpufreq/intelliactive/up_threshold_any_cpu_load

#Apply settings to Big cluster
echo Applying settings to Big cluster
#Temporarily change permissions to governor files for the Big cluster to enable Interactive governor
echo 1 > /sys/devices/system/cpu/cpu4/online								#Online Core 4
chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
#Temporarily change permissions to governor files for the Big cluster to lower minimum frequency to 384MHz
chmod 644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 384000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq			#Core 4 Minimum Frequency = 384MHz
chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
#Tweak Interactive Governor
echo 24 480000:16 633600:29 768000:40 864000:52 960000:63 1248000:71 1344000:80 1440000:88 1536000:94 1632000:97 1728000:98 1824000:99 1948000:100 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
echo -1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
echo 384000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
echo 200 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration

#Enable Input Boost for LITTLE cluster @672MHz for 40ms
echo Enabling Input Boost at 672MHz for the LITTLE cluster
echo 0:672000 1:672000 2:672000 3:672000 4:0 5:0 > /sys/module/cpu_boost/parameters/input_boost_freq
echo 0 > /sys/module/cpu_boost/parameters/boost_ms
echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
#Disable TouchBoost
echo Disabling TouchBoost
echo 0 > /sys/module/msm_performance/parameters/touchboost
#Disable Core Control and Enable Thermal Throttling allowing for longer sustained performance
echo Disabling Aggressive CPU Thermal Throttling
echo 0 > /sys/module/msm_thermal/core_control/enabled
echo Y > /sys/module/msm_thermal/parameters/enabled
echo ----------------------------------------------------
echo Settings Successfully Applied! You may now tweak them further in ElementalX Kernel Manager
echo ----------------------------------------------------