# bundle exec sample_task:fargate_log

namespace :sample_task do
  desc "Sample Task"
  task :fargate_log do
    puts("========Exec Sample Task=========")
  end
end