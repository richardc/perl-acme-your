use ExtUtils::MakeMaker;
my $module = 'lib/Acme/Your.pm';
WriteMakefile(
              'NAME'         => 'Acme::Your',
              'VERSION_FROM' => $module,
              'dist'         => {
                                 COMPRESS=>'gzip -9f',
                                 SUFFIX=>'gz',
                                 DIST_DEFAULT => 'tardist'
                                },
              PM             => {
                                 'lib/Acme/Your.pm'        => '$(INST_LIBDIR)/Your.pm',
                                 'lib/Acme/Your/Filter.pm' => '$(INST_LIBDIR)/Your/Filter.pm',
                                },
              PREREQ_PM      => {
                                 'Test::More' => 0,
                                 'Filter::Simple' => '0.77',
                                 'Parse::RecDescent' => '1.80',
                                },
              $] >= 5.005 ? ('AUTHOR'   => 'Richard Clamp <richardc@unixbeard.net>, Mark Fowler <mark@twoshortplanks.com>',
                             'ABSTRACT' => 'Introduce an our variable into someone else\'s package',

                            ) : ()

             );

sub MY::postamble {
    return <<EOF
README: $module
\tpod2text $module > README

cover:
\trm -rf cover_db
\tPERL5OPT=-MDevel::Cover \$(MAKE) test || true
\tcover cover_db
EOF
}
