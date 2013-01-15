#!/usr/bin/perl
use strict;
use warnings;

opendir(DIRH, ".");
my @files = readdir(DIRH);
closedir(DIRH);

foreach my $file (@files) {
 next unless $file =~ /_fr$/;
 `iconv -f latin1 -t utf-8 $file > $file.utf8`;
 `mv $file.utf8 $file`;
}
