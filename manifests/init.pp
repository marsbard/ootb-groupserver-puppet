

$groupserver_name = "groupserver-14.06"
$groupserver_filename = "${groupserver_name}.tar.gz"
$groupserver_url = "http://groupserver.org/sites/onlinegroups/Content/groupserver/downloads/${groupserver_filename}"

$gs_host = "lists.orderofthebee.org"
$gs_port = "8000"
$gs_adm_email = "martin@ocretail.com"
$gs_adm_password = "password"
$gs_supp_email = $gs_adm_email
$gs_smtp_host = "localhost"

$gs_zope_host = "localhost"
$gs_zope_port = 8000
$gs_zope_admin = "admin"
$gs_zope_password = "password"

$gs_pgsql_password = "password"
$gs_relstorage_password = "password"


##########################################################

# fix locales
exec{ "fix-locales":
	command => "locale-gen en_GB.UTF-8",
	path => "/usr/sbin:/bin",
}
exec{ "dpkg-reconfigure locales":
	path => "/bin:/usr/bin:/usr/sbin",
	require => Exec["fix-locales"],
}



stage { 'first':
        before => Stage['main'],
}
class { "package-deps":
        stage => first,
}
include "package-deps"

include "groupserver"
