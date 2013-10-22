module LibratoMeasurementsJob
  @queue = :filter_queue

  class << self
    def perform
      @users = User.all
      @trials = []
      @free = []
      @user.each do |user|
        if user.trial_ends_at
          @trials << user
        else
          @free << user
        end
      end
      Librato.measure "free_plans", @free.count
      Librato.measure "trial_plans", @trials.count
    end
  end
end
