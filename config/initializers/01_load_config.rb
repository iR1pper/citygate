file_name = "#{Rails.root}/config/accounts.yml"
ACCOUNTS = YAML.load_file(file_name) unless Rails.env.test? or not File.exist?(file_name)
