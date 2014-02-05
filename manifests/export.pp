define exportfact::export (
  $value,
  $category  = 'fact',
  $fact_name = $name,
) {

  $categoryfile = "${exportfact::factsdir}/${category}.txt"

  ensure_resource('file',
    $categoryfile,
      { owner => 'root',
        group => 'root',
        mode  => '0640',
      }
  )

  @@augeas { "fact_${fact_name}":
    context => "/files${categoryfile}",
    incl    => $categoryfile,
    lens    => 'Shellvars.lns',
    changes => "set ${fact_name} ${value}",
    require => [Class['exportfact'],File[$categoryfile]],
    tag     => "fact_${category}"
  }

}
