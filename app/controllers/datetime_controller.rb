class DatetimeController < ApplicationController
  include ActionController::Live

  def stream
    response.headers['Content-Type'] = 'text/event-stream'
    current_time = Time.current.in_time_zone('Asia/Tokyo')
    sse = SSE.new(response.stream, event: "message", retry: 1000)
    sse.write(current_time.to_s)
  ensure
    sse.close
  end
end
