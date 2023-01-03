angular.module("Meek").filter "truncate", ->
  (value, limit) ->
    if !value
      return ''
    if !limit
      return value
    if value.length <= limit
      return value
    value[0...limit].replace(/[^\s]+$/g, '')[0...-1] + '...'
