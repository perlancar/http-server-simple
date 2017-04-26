# -*- perl -*-

# checks RT#114124

use Socket;
use Test::More;
use strict;

BEGIN {
    plan skip_all => "Net::Server::Single not available"
        unless eval { require Net::Server::Single; 1 };
}

package MyServer;
use base 'HTTP::Server::Simple';

sub net_server { "Net::Server::Single" }

package main;

my $PORT = 40000 + int(rand(10000));

my $server = MyServer->new();
$server->port($PORT);
#my $pid = $server->background();
#is(kill(9,$pid),1,'Signaled 1 process successfully');
eval {
    local $SIG{ALRM} = sub { die };
    alarm 1;
    $server->run;
};

use Data::Dumper; print Dumper $server;

done_testing;
