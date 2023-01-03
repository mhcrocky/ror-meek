angular.module("Meek").directive 'meekDatePicker', (
) ->

  template = [
    '<div class="birthdate-item">'
      '<label class="icon-calendar">Year</label>'
      '<select id="birthdate-year" class="field" ng-model="val.year" ng-options="y for y in years">'
        '<option value disabled selected>Year</option>'
      '</select>'
      '<input type="hidden" name="user[year]" value="{{ val.year }}" />'
    '</div>'
    '<div class="birthdate-item">'
      '<label class="icon-calendar">Month</label>'
      '<select id="birthdate-month" class="field" ng-model="val.month", ng-options="m.value as m.name for m in months">'
        '<option value disabled>Month</option>'
      '</select>'
      '<input type="hidden" name="user[month]" value="{{ val.month }}" />'
    '</div>'
    '<div class="birthdate-item">'
      '<label class="icon-calendar">Day</label>'
      '<select id="birthdate-day" class="field" ng-model="val.day", ng-options="d for d in dates">'
        '<option value disabled selected>Day</option>'
      '</select>'
      '<input type="hidden" name="user[day]" value="{{ val.day }}" />'
    '</div>'
  ]

  {
    restrict: 'A'
    template: template.join('')

    link: (scope, elem, attrs, model) ->
      max = new Date().getFullYear()
      min = new Date().getFullYear() - 100

      scope.val = {
        year: parseInt(attrs.year)
        month: parseInt(attrs.month)
        day: parseInt(attrs.day)
      }

      scope.years = []

      i = max
      while i >= min
        scope.years.push(i)
        i--

      scope.$watch 'val.year', (newValue, oldValue) ->
        if newValue
          updateMonthOptions()

      scope.$watchCollection '[val.month, val.year]', ->
        if scope.val.month and scope.val.year
          updateDateOptions()

      updateMonthOptions = ->
        scope.months = []
        minMonth = 0
        maxMonth = 11
        monthNames = ['January',
                      'February',
                      'March',
                      'April',
                      'May',
                      'June',
                      'July',
                      'August',
                      'September',
                      'October',
                      'November',
                      'December']

        j = minMonth
        while j <= maxMonth
          scope.months.push
            name: monthNames[j]
            value: j + 1
          j++

      updateDateOptions = (year, month) ->
        minDate = 1
        maxDate = 31

        scope.dates = []
        i = minDate
        while i <= maxDate
          scope.dates.push i
          i++
  }
