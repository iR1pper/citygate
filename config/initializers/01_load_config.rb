ACCOUNTS = YAML.load_file("#{Citygate.root}/config/accounts.yml") unless Rails.env.test?
