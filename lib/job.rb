class Job

  def initialize
    @queue = []
  end

  def add_job(job)
    @queue << job
  end

  def process_jobs
    @queue.each do |job|
      job.perform
    end
    @queue.clear
  end
end