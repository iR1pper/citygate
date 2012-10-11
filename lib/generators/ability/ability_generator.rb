class AbilityGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_ability_file
    copy_file "ability.rb", "lib/ability.rb"
  end
end
