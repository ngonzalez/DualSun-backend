# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :redis_store,
  servers: ["redis://#{REDIS_HOST}:#{REDIS_PORT}/#{REDIS_DB}/session"],
  expire_after: 90.minutes,
  key: "_#{Rails.application.class.module_parent_name.downcase}_session",
  threadsafe: true,
  secure: true
