ACCOUNTS = YAML.load_file("#{Rails.root}/config/accounts.yml") unless Rails.env.test?
