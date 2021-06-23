class Batch::TestJob
  include Sidekiq::Worker
  sidekiq_options queue: "default"

  def perform
    logger.info "========Batch::TestJob==========="
  end
end