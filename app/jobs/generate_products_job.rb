require "redis-queue"
class GenerateProductsJob
	include SuckerPunch::Job

	def perform(message)
		_redis = Redis.new
		_queue = Redis::Queue.new('__test', 'bp__test', :redis => _redis)
		10.times { |i| _queue << "e_#{i}"}
		_queue << "finished"
	end
end