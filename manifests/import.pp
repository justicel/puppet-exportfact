define exportfact::import (
  $export_env = false,
  $category   = $name,
) {

  $categoryfile = "${exportfact::factsdir}/${category}.txt"

  ensure_resource('file',
    $categoryfile,
      { owner => 'root',
        group => 'root',
        mode  => '0640',
      }
  )

  if $export_env {
    Augeas <<| tag == "fact_${category}" |>> {
      context => '/files/etc/environment',
      incl    => '/etc/environment',
    }
  }
  else {
    Augeas <<| tag == "fact_${category}" |>>
  }
}
