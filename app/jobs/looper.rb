class Looper
	include SuckerPunch::Job

	def perform(queue, sse)
		p "loop message"
		begin
			while message = queue.pop
				p "message #{message}"

				if message == "finished"
					p "break"
					break
				else
					sse.write({:msg => message})
				end
			end
							queue.commit
		rescue IOError
			#
		ensure
			sse.close
		end
	end
end