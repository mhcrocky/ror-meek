angular.module("Meek").service 'DurationService', (
) ->

  class Duration
    episodeDuration: (duration) =>
      [hours, minutes, seconds] = @_getTimeBy(duration)

      # Format => 11 Hours 43 Minutes 13 Seconds ( with removing useless zero numbers )
      duration = ""
      duration += "#{hours} Hours " if hours > 0
      duration += "#{minutes} Minutes " if minutes > 0
      duration += "#{seconds} Seconds" if seconds > 0

      return duration


    inFormat: (duration) =>
      return '' unless duration

      [hours, minutes, seconds] = @_getTimeBy(duration)

      # Format => 11:43:13 ( with removing useless zero numbers )
      duration = "#{('0' + minutes).slice(-2)}:#{('0' + seconds).slice(-2)}"
      duration = "#{('0' + hours).slice(-2)}:#{duration}" if hours > 0

      return duration


    _getTimeBy: (duration) ->
      hours = Math.floor(duration / (60 * 60))
      minutes = Math.floor(duration / 60) - (hours * 60)
      seconds = duration - (minutes * 60) - (hours * 60 * 60)

      return [hours, minutes, seconds]


  return new Duration()
