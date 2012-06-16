# Adding a new development domain

# Add domain to hosts file
# Add domain as virtual host to apache conf
# Add directory to apache conf

FILE_MODE       = "a+"
APACHE_CONF_DIR = "/Applications/XAMPP/xamppfiles/etc"
domain          = ARGV[0] || (puts "Correct usage: add-vhost domain [dir]"; exit)
dir             = ARGV[1] || Dir.pwd

def add_host(domain)
  File.open("/etc/hosts", FILE_MODE) do |file|
    file.write("\n127.0.0.1 #{domain}")
  end
end

def add_apache_vhost(domain, dir)
  write_apache_conf(vhost_template(domain, dir))
end

def add_apache_dir(dir)
  write_apache_conf(dir_template(dir))
end

def write_apache_conf(stuff)
  File.open(APACHE_CONF_DIR + "/httpd.conf", FILE_MODE) do |file|
    file.write(stuff)
  end
end

def dir_template(dir)
  <<-template
  
<Directory "#{dir}">
  AllowOverride All
</Directory>
  template
end

def vhost_template(domain, dir)
  <<-template
  
<VirtualHost #{domain}>
  DocumentRoot "#{dir}"
  ServerName #{domain}
</VirtualHost>
  template
end

add_host(domain)
add_apache_vhost(domain, dir)
add_apache_dir(dir)