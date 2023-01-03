angular.module("Meek").service 'HeadService', (
  $location
  $rootScope
) ->

  class Head
    _defaultTitle: 'Meek'
    tags: []

    constructor: ->
      @addCanonicalTag()

      $rootScope.$on '$locationChangeStart', @clearTags
      $rootScope.$on '$locationChangeSuccess', @addCanonicalTag

      return this


    setTitle: (title) =>
      if title? && title != null && title != ''
        document.title = title
      else
        document.title = @_defaultTitle


    setMetaTag: (attrs, tagName) =>
      htmlElement = document.createElement(tagName || 'meta')
      $tag = $(htmlElement)

      for attribute, value of attrs
        $tag.attr(attribute, value)

      $('head').append($tag)
      @tags.push($tag)

      return

    clearTags: =>
      for $tag in @tags
        $('head').find($tag).remove()

      return

    addCanonicalTag: =>
      canonicalUrl = $location.absUrl().split('?')[0]
      @setMetaTag({ rel: 'canonical', href: canonicalUrl }, 'link')

      return


    setAllMetaInformation: (info = {}) =>
      opts =
        isVideo:         !!info.videoUrl
        title:           info.title || 'Meek'
        description:     info.description || 'Without description'
        imagePath:       $location.$$protocol + '://' + $location.$$host + "#{ info.imagePath || '/meek-logo-web.png'}"
        googlePath:      $location.$$protocol + '://' + $location.$$host + "#{ info.googlebotImage || '/meek-logo-web.png'}"
        locationPath:    window.location.href
        videoUrl:        info.videoUrl
        type:            'website'
        siteName:        'Meek'
        twitterCardType: if info.videoUrl then 'player' else 'summary'
        twitterOwner:    '@johnpaulmains'

      # Title:
      @setTitle(opts.title)
      @setMetaTag({ name:     'title',           content: opts.title })
      @setMetaTag({ property: 'og:title',        content: opts.title })

      # Description:
      @setMetaTag({ name:     'description',     content: opts.description })
      @setMetaTag({ property: 'og:description',  content: opts.description })

      # Image:
      @setMetaTag({ property: 'og:image',        content: opts.imagePath })
      @setMetaTag({ property: 'og:image:url',    content: opts.imagePath })
      @setMetaTag({ property: 'og:image:width',  content: '200' })
      @setMetaTag({ property: 'og:image:height', content: '200' })

      @setMetaTag({ rel: 'image_src', href: opts.googlePath }, 'link')

      # OpenGraph Data:
      @setMetaTag({ property: 'og:url',          content: opts.locationPath })
      @setMetaTag({ property: 'og:type',         content: opts.type })
      @setMetaTag({ property: 'og:site_name',    content: opts.siteName })

      # Twitter Card:
      @setMetaTag({ property: 'twitter:card',        content: opts.twitterCardType })
      @setMetaTag({ property: 'twitter:site',        content: opts.twitterOwner })
      @setMetaTag({ property: 'twitter:title',       content: opts.title })
      @setMetaTag({ property: 'twitter:description', content: opts.description })
      @setMetaTag({ property: 'twitter:image',       content: opts.imagePath })


      if opts.isVideo
        @setMetaTag({ property: 'og:video:url',         content: opts.videoUrl })
        @setMetaTag({ property: 'og:video:secure_url',  content: opts.videoUrl })
        @setMetaTag({ property: 'og:video:type',        content: 'text/html' })

        @setMetaTag({ property: 'twitter:url',           content: opts.videoUrl })
        @setMetaTag({ property: 'twitter:player',        content: opts.videoUrl })
        @setMetaTag({ property: 'twitter:player:width',  content: '640' })
        @setMetaTag({ property: 'twitter:player:height', content: '360' })

  return new Head()
