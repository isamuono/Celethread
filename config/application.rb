require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Portfolio
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.default_locale = :ja # 2020/11/25追記
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s] # 2020/11/25追記

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
    
    # 2020/11/25追記
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      if instance.kind_of?(ActionView::Helpers::Tags::Label)
        html_tag.html_safe
      else
        class_name = instance.object.class.name.underscore
        method_name = instance.instance_variable_get(:@method_name)
        "<div class=\"has-error\">#{html_tag}
          <div class=\"help-block\">
            ［#{I18n.t("activerecord.attributes.#{class_name}.#{method_name}")}］
            #{instance.error_message.first}
          </div>
        </div>".html_safe
      end
    end
  end
end
