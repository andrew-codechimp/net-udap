#!/usr/bin/env perl

# $Id: udap_shell.pl 31 2008-02-14 23:53:47Z robin $
#
# Copyright (c) 2008 by Robin Bowes <robin@robinbowes.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use warnings;

# Add the Net-UDAP modules to the libpath
use FindBin;
use lib "$FindBin::Bin/../src/Net-UDAP/lib";

use version; our $VERSION = qv('0.1');

use Carp;
use Data::Dumper;
use Net::UDAP::Util;

$| = 1;

my $ips = local_addresses;
print join ',', keys %$ips;

print "\n";

# vim:set softtabstop=4:
# vim:set shiftwidth=4:
