#!/usr/bin/perl

package X11::Connection::INETFH;

# Copyright (C) 1997 Stephen McCamant. All rights reserved. This program
# is free software; you can redistribute and/or modify it under the same
# terms as Perl itself.

use X11::Connection::FileHandle;
use FileHandle;
use Socket;
use Carp;
use strict;
use vars qw($VERSION @ISA);

@ISA = ('X11::Connection::FileHandle');

$VERSION = 0.01;

sub open
  {
    my($pkg) = shift;
    my($host, $dispnum) = @_;
    my($sock) = new FileHandle;
    socket $sock, PF_INET(), SOCK_STREAM(), getprotobyname("tcp")
      or croak "socket: $!";
    connect $sock, sockaddr_in(6000 + $dispnum, inet_aton $host) or
      croak "Can't connect to display `$host:$dispnum': $!";
    $sock->autoflush(1);
    return bless \$sock, $pkg;
  }
1;
__END__

=head1 NAME

X11::Connection::INETFH - Perl module for FileHandle-based TCP/IP X11 connections

=head1 SYNOPSIS

  use X11::Protocol;
  use X11::Connection::INETFH;
  $conn = X11::Connection::INETFH->open($host, $display_number);
  $x = X11::Protocol->new($conn); 

=head1 DESCRIPTION

This module is used by X11::Protocol to establish a connection and
communicate with a server over an internet-type TCP/IP socket
connection, using the FileHandle module.

=head1 AUTHOR

Stephen McCamant <alias@mcs.com>.

=head1 SEE ALSO

L<perl(1)>,
L<X11::Protocol>,
L<X11::Connection::UNIXFH>,
L<X11::Connection::FileHandle>, 
L<FileHandle>.

=cut