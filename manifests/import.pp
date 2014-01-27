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
    $export_content = {
      context => '/files/etc/environment',
      incl    => '/etc/environment',
    }
  }
  else {
    $export_content
  }

  Augeas <<| tag == "fact_${category}" |>> {
    $export_content,
  }

}
