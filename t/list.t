#!/usr/bin/env perl

use Mojolicious::Lite;

use Test::More;
use Test::Mojo;
use Test::LongString;

use File::Spec;
use File::Basename;

use lib 'lib';
use lib '../lib';

## Webapp START

my $testdir = File::Spec->catdir( dirname(__FILE__), '..', 'test' );

plugin('Prove' => {
  tests => {
    base => $testdir,
  }
});

## Webapp END

my $t = Test::Mojo->new;

$t->get_ok( '/prove' )->status_is( 200 )->content_is( <<"HTML" );
<h2>Tests</h2>

<ul>
    <li><a href="/prove/test/base">base</a></li>
</ul>
HTML

$t->get_ok( '/prove/test/does_not_exist' )->status_is( 200 );
is_string $t->tx->res->body, <<"HTML";
<h2>Fehler</h2>
HTML

done_testing();

