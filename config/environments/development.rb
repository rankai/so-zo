SoZo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = false # enable error handling
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # paperclip
  Paperclip.options[:command_path] = "/usr/bin/convert"

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load


# Disable request forgery protection in development environment  
  config.action_controller.allow_forgery_protection = false  
  
  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.threadsafe = true

  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 587,
      domain:               'gmail.com',
      user_name:            'mr.rankai@gmail.com',
      password:             'woai(iujuan',
      authentication:       'plain',
      enable_starttls_auto: true  
  }

  config.i18n.available_locales = ['zh-CN', 'ja', :de]
  config.i18n.default_locale = 'zh-CN'

end
