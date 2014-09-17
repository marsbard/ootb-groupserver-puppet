class groupserver {
	exec { "retrieve-groupserver":
		cwd => "/root",
		path => "/bin:/usr/bin",
		command => "wget $groupserver_url -O $groupserver_filename",
		creates => "/root/${groupserver_filename}",
	}

	exec { "unpack-groupserver":
		cwd => "/root",
		path => "/bin:/usr/bin",
		command => "tar xzf ${groupserver_filename}",
		require => Exec["retrieve-groupserver"],
	}

	service { "postfix":
		ensure => running,
	}

	file { "/root/${groupserver_name}/config.cfg":
		ensure => present,
		content => template("groupserver/config.cfg.erb"),
		before => Exec["run-gs-install"],
	}

	file { "/root/${groupserver_name}/buildout.cfg":
		ensure => present,
		content => template("groupserver/buildout.cfg.erb"),
		before => Exec["run-gs-install"],
		require => Exec["unpack-groupserver"],
	}


	exec{ "run-gs-install":
		path => "/bin:/usr/bin",
		cwd => "/root/${groupserver_name}",
		command => "/root/${groupserver_name}/gs_install_ubuntu.sh",
		logoutput => true,
		timeout => 0,
	}

	# buildout fails (called by gs_install_ubuntu.sh) due to missing cssutils
	# so attempt to run that and then run buildout again

	exec { "install-cssutils":
		path => "/bin:/usr/bin",
		command => "/root/${groupserver_name}/bin/pip install cssutils",
		require => Exec["run-gs-install"],
		cwd => "/root/${groupserver_name}",
	}

	exec { "run-buildout":
		cwd => "/root/${groupserver_name}",
		command => "bin/buildout -N",
		path => "/bin:/usr/bin",
		require => Exec["install-cssutils"],
	}

}
