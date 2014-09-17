class package-deps {

	exec{ "apt-get update":
		path => "/usr/bin",
	}

	package{ "wget":
		require => Exec["apt-get update"],
		ensure => present,
	}

	package{ "sed":
                require => Exec["apt-get update"],
                ensure => present,
        }
	package{ "python":
                require => Exec["apt-get update"],
                ensure => present,
        }

	exec { "install-pip-cssutils":
		path => "/bin:/usr/bin",
		command => "pip install cssutils",
		require => Package["python"],
	}

	package{ "python-virtualenv":
                require => Exec["apt-get update"],
                ensure => present,
        }
	package{ "python-dev":
                require => Exec["apt-get update"],
                ensure => present,
        }
	package{ "build-essential":
                require => Exec["apt-get update"],
                ensure => present,
        }
	package{ "postfix":
                require => Exec["apt-get update"],
                ensure => present,
        }
	package{ "postgresql":
                require => Exec["apt-get update"],
                ensure => present,
        }
	package{ "libpq-dev":
                require => Exec["apt-get update"],
                ensure => present,
        }
	package{ "swaks":
                require => Exec["apt-get update"],
                ensure => present,
        }
	package{ "redis-server":
                require => Exec["apt-get update"],
                ensure => present,
        }
	package{ "libxslt-dev":
                require => Exec["apt-get update"],
                ensure => present,
        }

}
