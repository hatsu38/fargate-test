# bundle exec rails sample_task:fargate_log

namespace :sample_task do
  desc "Sample Task"
  task :fargate_log do |task|
    Rails.logger = Logger.new(STDOUT)
    puts("========Exec Sample Task=========")
    puts Rails.logger.info task.name
  end
end