assets = Rails.application.config.assets
assets.precompile += %w(snippets.js novnc.js)
