module NginxCookbook
  module Helpers

    # Set default hostname to server hostname
    def parsed_servername
      return new_resource.servername if new_resource.servername
      node.hostname
    end

    def platform_user
      case node.platform_family
      when "debian", "ubuntu"
        "www-data"
      else
        "nginx"
      end
    end

    def proc_init
      if node['platform_family'] == 'debian' && node['platform_version'] > '12.10'
        return 'upstart'
      elsif node['platform_family'] == 'rhel' && node['platform_version'] > '5'
        return 'systemd'
      else
        return 'sysvinit'
      end
    end
  end
end
