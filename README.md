# Net-UDAP

## Overview

Net::UDAP is a Perl module to configure the Logitech SqueezeBox Receiver (SBR) from a PC, i.e. without requiring a SqueezeBox Controller (SBC).

I have tested on linux (Fedora 8), Windows XP (ActiveState perl and cygwin).

**Important** If you don't read anything else, read this: [wiki:GettingStarted Getting Started]

## Donations

Net-UDAP is free software - you do not have to pay to use it.

However, if you find Net-UDAP useful, you might like to make a donation - I've got ~~four~~ five kids to support!

https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=V32L8P6YHMS7C

## Support

Please raise issues if you have any problems with Net-UDAP

## Documentation

From http://www.practicalreason.net/item/34-squeezebox-duet-without-controller

**Important**  The Receiver only stays in init mode for a few minutes, construct your set command detailed below before starting.

Prepare the Squeezebox Receiver and get its IP Address

Before starting, the Squeezebox Receiver must be in init mode indicated by its front button flashing slowly red. Do this by performing a factory reset on the receiver by pressing and holding the button for five seconds or more until the light starts flashing red.



Once in init mode, connect the Squeezebox Receiver to your laptop using an ethernet cable.

Turn off your laptop's wireless so it's only looking at the LAN network.

Open a command window and get the IP address of the Squeezebox Receiver using the following DOS command:

ipconfig /all
You should get some output like the following:

```C:\Users\Dermot> ipconfig /all```

    Windows IP Configuration
    
    Host Name . . . . . . . . . . . . : MyLaptop
    Primary Dns Suffix  . . . . . . . : 
    Node Type . . . . . . . . . . . . : Hybrid
    IP Routing Enabled. . . . . . . . : No
    WINS Proxy Enabled. . . . . . . . : No
    DNS Suffix Search List. . . . . . : 

    Wireless LAN adapter Wireless Network Connection:
    Media State . . . . . . . . . . . : Media disconnected
    Connection-specific DNS Suffix  . :
    Description . . . . . . . . . . . : Intel(R) Centrino(R) Ultimate-N 6300 AGN
    Physical Address. . . . . . . . . : 24-77-03-26-B3-D4
    DHCP Enabled. . . . . . . . . . . : Yes
    Autoconfiguration Enabled . . . . : Yes
    
    Ethernet adapter Local Area Connection:

    Connection-specific DNS Suffix  . :
    Description . . . . . . . . . . . : Intel(R) 82579LM Gigabit Network Connection
    Physical Address. . . . . . . . . : 00-21-CC-72-45-01
    DHCP Enabled. . . . . . . . . . . : Yes
    Autoconfiguration Enabled . . . . : Yes
    Link-local IPv6 Address . . . . . : fe80::a4fb:9202:38d6:a32a%14(Preferred)
    Autoconfiguration IPv4 Address. . : 192.168.1.4(Preferred)
    Subnet Mask . . . . . . . . . . . : 255.255.0.0
    Default Gateway . . . . . . . . . :
    DHCPv6 IAID . . . . . . . . . . . : 285221324
    DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-16-B2-73-D0-00-21-CC-72-45-01
    DNS Servers . . . . . . . . . . . : fec0:0:0:ffff::1%1
                                        fec0:0:0:ffff::2%1
                                        fec0:0:0:ffff::3%1
    NetBIOS over Tcpip. . . . . . . . : Enabled

Examine the output and look for the Ethernet adapter details. Here you should find a section Autoconfiguration IPv4 Address which will list the IP address assigned to the device connected on the ethernet port. See the highlighted line above for an example - you can see how the IP address of the Receiver is 192.168.1.4.

##Install Perl

To run the Net:UDAP application you'll need to have Perl installed on your environment. Perl is typically installed by default on Ubuntu. A good way to run Perl scripts in Windows is using the ActivePerl distribution. Download the installer file for its free community edition from here and run it to install Perl on your Windows environment. Once installed run the command `perl -version` within a command window to test that it works:

    Microsoft Windows [Version 6.1.7601]
    Copyright (c) 2009 Microsoft Corporation.  All rights reserved.

    C:\Users\Dermot>perl -version

    This is perl 5, version 14, subversion 2 (v5.14.2) built for MSWin32-x64-multi-thread
    (with 1 registered patch, see perl -V for more detail)

    Copyright 1987-2011, Larry Wall

    Binary build 1402 [295342] provided by ActiveState http://www.ActiveState.com
    Built Oct  7 2011 15:19:36

    Perl may be copied only under the terms of either the Artistic License or the
    GNU General Public License, which may be found in the Perl 5 source kit.

    Complete documentation for Perl, including FAQ lists, should be found on
    this system using "man perl" or "perldoc perl".  If you have access to the
    Internet, point your browser at http://www.perl.org/, the Perl Home Page.


##Run the Application to Connect to the Squeezebox Receiver

Download the Net::UDAP application ZIP and extract the archive to any location.

To get the Net::UDAP application to connect to the Squeezebox Receiver you need to run its udap_shell.pl script and specify the IP address of the Receiver you determined in the previous section. Here's an example of the command where the IP address of the Receiver is 169.254.163.42:

`C:\branches\1.0.x\scripts>udap_shell.pl --local-address 169.254.163.42`
If the script successfully connects to the network address and you should see a command line interface as follows:

    C:\branches\1.0.x\scripts>UDAP>
If the connection fails then it's typically because the IP address is incorrect. See the Troubleshooting section for some help.

Use the help command to see what commands are available in the CLI:

    UDAP> help
    Type 'help command' for more detailed help on a command.
    Commands:
    configure - configure a device
    discover  - Discover UDAP devices and get their current configuration
    exit      - Exit configure mode (if configuring a device), otherwise exit application
    fields    - Display a list of valid device fields
    help      - prints this screen, or help on 'command'
    list      - List discovered devices, or a specific information about a device
    quit      - Exit configure mode (if configuring a device), otherwise exit application
    reset     - Reset a device
    save_data - Save data parameters to device(s)
    save_ip   - Save ip parameters to device(s)
    set       - Set device parameter(s)


The next step is to use the CLI to discover the Receiver and start its configuration.

##Discover and Configure the Receiver

Once you've launched the script and connected to the Receiver you can begin to configure it.

The first step is to tell the application which Squeezebox Receiver you wish to configure. Do this using the discover command to scan the IP address for Squeezebox Receivers running on the connection. You should get the following type of output:

     UDAP>
     discover
      info: *** Broadcasting adv_discovery message to MAC address 00:00:00:00:00:00 on 255.255.255.255
      info:   adv_discovery response received from 00:04:20:16:05:8f
      info: *** Broadcasting get_ip message to MAC address 00:04:20:16:05:8f on 255.255.255.255
      info:   get_ip response received from 00:04:20:16:05:8f
      info: *** Broadcasting get_data message to MAC address 00:04:20:16:05:8f on 255.255.255.255
      info:   get_data response received from 00:04:20:16:05:8f

When the scan has completed as above, use the list command to display the available Squeezebox Receivers. There should only be one in this case:

     UDAP> list
   
    #    MAC Address    Type       Status
    == ================= ========== ===============
    1 00:04:20:16:05:8f squeezebox init

Use the configure command to select the Squeezebox Receiver to configure based on its number (it will always be 1):

    UDAP> configure 1

    UDAP [1] (squeezebox 16058f)>
Notice the prompt has changed to show the device number [1] and name

You are now ready to change the Receiver's configuration details. Use the list command to display the current settings. You'll see a list of all the configuration fields and their default values:

    UDAP [1] (squeezebox 16058f)> list
    
                   bridging: 0
                   hostname:
                  interface: 0
                lan_gateway: 0.0.0.0
                lan_ip_mode: 1
        lan_network_address: 0.0.0.0
            lan_subnet_mask: 255.255.255.0
                primary_dns: 0.0.0.0
              secondary_dns: 0.0.0.0
             server_address: 0.0.0.0
      squeezecenter_address: 0.0.0.0
         squeezecenter_name:
              wireless_SSID:
           wireless_channel: 0
            wireless_keylen: 0
              wireless_mode: 0
         wireless_region_id: 0
         wireless_wep_key_0:
         wireless_wep_key_1:
         wireless_wep_key_2:
         wireless_wep_key_3:
            wireless_wep_on: 0
        wireless_wpa_cipher: 1
            wireless_wpa_on: 0
          wireless_wpa_mode: 1
           wireless_wpa_psk:
  
  To see a list of all the available fields and their descriptions use the fields command:

     UDAP> fields
                   bridging: Use device as a wireless bridge (not sure about this)
                   hostname: Device hostname (is this set automatically?)
                  interface: 0 - wireless, 1 - wired
                lan_gateway: IP address of default network gateway, (e.g. 192.168.1.1)
                lan_ip_mode: 0 - Use static IP details, 1 - use DHCP to discover IP details
        lan_network_address: IP address of device, (e.g. 192.168.1.10)
            lan_subnet_mask: Subnet mask of local network, (e.g. 255.255.255.0)
                primary_dns: IP address of primary DNS server
              secondary_dns: IP address of secondary DNS server
             server_address: IP address of currently active server (either Squeezenetwork or local server
      squeezecenter_address: IP address of local Squeezecenter server
         squeezecenter_name: Name of local Squeezecenter server (???)
              wireless_SSID: Wireless network name
           wireless_channel: Wireless channel (used by AdHoc mode???)
            wireless_keylen: Length of wireless key, (0 - 64-bit, 1 - 128-bit)
              wireless_mode: 0 - Infrastructure, 1 - Ad Hoc
         wireless_region_id: 4 - US, 6 - CA, 7 - AU, 13 - FR, 14 - EU, 16 - JP, 21 - TW, 23 - CH
         wireless_wep_key_0: WEP Key 0
         wireless_wep_key_1: WEP Key 1
         wireless_wep_key_2: WEP Key 2
         wireless_wep_key_3: WEP Key 3
            wireless_wep_on: 0 - WEP Off, 1 - WEP On
        wireless_wpa_cipher: 1 - CCMP, 2 - TKIP
            wireless_wpa_on: 0 - WPA Off, 1 - WPA On
          wireless_wpa_mode: 1 - WPA, 2 - WPA2
           wireless_wpa_psk: WPA Public Shared Key

In general you only need to configure a subset of these fields to get things working. It all depends on the type of network you want the Receiver to connect to.

* server_address - It's not clear from the documentation what exactly this setting relates to but if it's not set it doesn't work. I assumed it relates to the IP address of the Squeezebox server (the same as the squeezecenter_address field). You decide what the IP value is - make sure its a unique address anywhere on your network.
* lan_subnet_mask - The subnet mask of your network. The default is 255.255.255.0 so if your subnet mask is the same then there's no need to change it.
* squeezecenter_address - The IP address of the Squeezecenter server running on your network.
* wireless_SSID - The SSID of your wireless network.
* wireless_wep_key_0
* wireless_wep
* interface- 0 - wireless, 1 - wired
* hostname - A name for the Squeezebox Receiver so you can easily identify it.

NOTE THAT THESE ARE CASE SENSITIVE SO BE CAREFUL! Here's an example where the wireless network was WPA enabled and therefore just required a passphrase. :

set server_address=192.168.1.3 squeezecenter_address=192.168.1.3 squeezecenter_name=Squeezecenter wireless_SSID=shed wireless_wpa_psk=rathcloughduallacashel wireless_wpa_on=1 wireless_wpa_mode=2 wireless_wpa_cipher=2 interface=0 hostname=squeezebox-duet
Type list to see the values have changed:

     UDAP [1] (squeezebox 16058f)> list
                   bridging: 0
                   hostname: squeezebox-duet
                  interface: 0
                lan_gateway: 0.0.0.0
                lan_ip_mode: 1
        lan_network_address: 0.0.0.0
            lan_subnet_mask: 255.255.255.0
                primary_dns: 0.0.0.0
              secondary_dns: 0.0.0.0
             server_address: 192.168.1.3
      squeezecenter_address: 192.168.1.3
         squeezecenter_name:
              wireless_SSID: shed
           wireless_channel: 0
            wireless_keylen: 0
              wireless_mode: 0
         wireless_region_id: 0
         wireless_wep_key_0: 
         wireless_wep_key_1:
         wireless_wep_key_2:
         wireless_wep_key_3:
            wireless_wep_on: 0
        wireless_wpa_cipher: 2
            wireless_wpa_on: 1
          wireless_wpa_mode: 2
           wireless_wpa_psk: rathcloughduallacashel

Use the save_data command to save the settings to the device:

     UDAP [1] (squeezebox 16058f)> save_data
      info: *** Broadcasting set_data message to MAC address 00:04:20:16:05:8f on 255.255.255.255
      ucp_method set_data callback not implemented yet at /home/robin/projects/Net-UDAP/trunk/scripts/../src/Net-UDAP/lib/Net/UDAP.pm line 281
      Raw msg:
      00 01 02 03 04 05 06 07 - 08 09 0A 0B 0C 0D 0E 0F  0123456789ABCDEF

      00000000  00 02 00 00 00 00 00 00 - 00 01 00 04 20 16 05 8F  ............ ...
      00000010  00 01 C0 01 00 00 01 00 - 01 00 06 00 1A           .............
      info:   set_data response received from 00:04:20:16:05:8f

Finally, use the reset command to reset the Squeezebox Receiver in order to apply the changes:

    UDAP [1] (squeezebox 16058f)> reset
      info: *** Broadcasting reset message to MAC address 00:04:20:16:05:8f on 255.255.255.255
      ucp_method reset callback not implemented yet at /home/robin/projects/Net-UDAP/trunk/scripts/../src/Net-UDAP/lib/Net/UDAP.pm line 281
      Raw msg:

            00 01 02 03 04 05 06 07 - 08 09 0A 0B 0C 0D 0E 0F  0123456789ABCDEF
    
      00000000  00 02 00 00 00 00 00 00 - 00 01 00 04 20 16 05 8F  ............ ...
      00000010  00 01 C0 01 00 00 01 00 - 01 00 04                 ...........
      info:   reset response received from 00:04:20:16:05:8f

Ignore any warnings.

The Squeezebox Receiver should reset and when it restarts it should begin connecting to your wireless network using the new settings. The Receiver will indicate a successful connection when a dark white light appears.

## Requirements

 * On Unix:
   * perl v5.8.5, or later (it may work on earlier versions)
   * either subversion or unzip

 * On Windows:
   * ActiveState perl
   * optionally, TortoiseSVN (or similar) 

For the 1.0.0 release, all necessary modules should either be part of base perl, or are distributed with this module. 

Note: this will change in the next release. Net::UDAP will require installing one or two supporting perl modules from CPAN or using the ActiveState [http://aspn.activestate.com/ASPN/Downloads/ActivePerl/PPM/ Perl Package Manager].

## News

### March 22, 2014

Imported code to github.

I have tried to update the documenttion to reflect the new location of the wiki, etc. but please let me know if I've missed anything.

### January 21, 2009

I just committed a change that switches to hex entry for WEP keys. This simply means that instead of entering a hex key like this: {{{abcd}}}, you should now enter it like this: {{{61626364}}}.

The change is in trunk, and also in a new 1.0.x branch I've created from the 1.0.0 release.

### January 9, 2009

Blimey, two updates in two days - what's going on???!!

I just noticed that the documentation doesn't mention anything about firewalls. Oooops. I've updated the [wiki:GettingStarted Getting Started] docs to include details of what size hole is required in the firewall.

For the record, the UDAP protocol uses broadcast traffic on port 17784 (udp).

### January 8, 2009

Happy New Year all!

No major updates to report at this stage, but I've re-arranged the wiki documentation and updated the [wiki:GettingStarted Getting Started] documentation. Also, the registration procedure should now work so you can register, login, and create tickets to report any issue. Hell, you could even go crazy and edit the wiki to update the documentation!

A couple of points regarding getting the code:

 1. Most folk should grab the 1.0.0 Release () rather than the latest development code
 1. trac is able to dynamically create a zip file of any view of the code repository. What this means in practise is that it is not necessary to install subversion to get Net::UDAP - you can simply grab a zip archive. Look for the "Zip archive" link at the bottom of the page under "'''Download in other formats:'''"

### June 2, 2008

I've moved all my projects to a new server and a new version of trac.

Please [/register register] to be able to create/modify tickets and/or modify the wiki.

https access is secured using a certificate signed by the CAcert. To import the CAcert root certificate, please go to https://www.cacert.org/index.php?id=3

## Useful Links

http://wiki.slimdevices.com/index.php/SBRFrontButtonAndLED

http://forums.slimdevices.com/showpost.php?p=280981&postcount=47
