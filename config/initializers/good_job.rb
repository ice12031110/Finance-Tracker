# frozen_string_literal: true

if Rails.application.config.active_job.queue_adapter == :good_job
  Rails.application.configure do
    config.good_job.execution_mode = :external
    config.good_job.enable_cron = true
    config.good_job.cron = {
      update_stock_prices: {
        cron: "30 17 * * *",
        class: "UpdateStockPricesJob",
        description: "每日更新股票收盤價"
      }
    }
    config.good_job.max_threads = ENV.fetch("RAILS_MAX_THREADS", 5)
  end
end
