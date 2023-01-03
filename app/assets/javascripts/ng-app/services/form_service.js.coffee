angular.module("Meek").service 'FormService', (
  $http
) ->

  class Form

    submit: ($form) =>
      if $('input[type="file"]', $form).length > 0
        $http
          url: $form.attr('action')
          method: $form.attr('method')
          data: @serializeForm($form)
          transformRequest: angular.identity,
          headers: {'Content-Type': undefined}
      else
        $http
          url: $form.attr('action')
          method: $form.attr('method')
          data: @serializeForm($form)


    serializeForm: ($form) =>
      if $('input[type="file"]', $form).length > 0
        data = new FormData()

        for input in $('input, select, textarea', $form)
          $input = $(input)

          if $input.attr('type') == 'file'
            data.append($input.attr('name'), input.files[0]) if input.files.length > 0

          else
            data.append($input.attr('name'), $input.val())

      else
        data = $form.serializeJSON()

      return data


    displayErrors: ($form, data) =>
      errors = @formatErrors(data)

      for input, messages of errors
        $input = $form.find("input[name=#{input}], input[name*=\"[#{input}]\"], select[name=#{input}], select[name*=\"[#{input}]\"], textarea[name=#{input}], textarea[name*=\"[#{input}]\"]")

        if $input.length > 0
          $group = $input.parents('.input-parent')
          $group.addClass('has-error')
          $group.append("<p class='help-block error-message'>#{messages.join("<br/>")}</p>")

      return


    clearErrors: ($form) =>
      $form.find('.has-error').removeClass('has-error')
      $form.find('p.error-message').remove()

      return

    clearFields: ($form) ->
      $form.find('input').val('')
      $form.find('textarea').val('')


    formatErrors: (data) ->
      data.errors = {} if !data.errors?
      data.errors.base = [] if !data.errors.base?
      data.errors['base'].push(data.error) if data.error?

      return data.errors


  return new Form()
