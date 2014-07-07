class TestJob
	include SuckerPunch::Job

	def perform(sse, message)
		begin
			p "test_job perform"
			sse.write({time: Time.now})
			sleep 1
		rescue Exception => e
		ensure
			sse.close
		end
	end
end